CREATE OR REPLACE FUNCTION FC_Previsao_AtendimentoTMP(
        p_IdTicket      IN NUMBER,
        p_DataBase      IN DATE,
        p_Sistema       IN VARCHAR,
        p_Prioridade    IN NUMBER,
        p_Severidade    IN NUMBER,
        p_Nivel         IN NUMBER,
        p_IdSla         IN NUMBER,
        p_Critico       IN VARCHAR,
        p_Vip           IN NUMBER) RETURN DATE IS
    v_Sla         MTK_SLA%ROWTYPE;
    v_Ignora      NUMBER;
    v_Minuto      NUMBER;
    v_Porcentagem NUMBER;    
    v_Retorno     DATE; 
    
    FUNCTION CalcularPrevisaoAtendimento(
            p_Minuto NUMBER) RETURN DATE Is
        v_Hora        NUMBER;
        v_Semana      NUMBER;
        v_HoraInicio  NUMBER := 0495; -- 08:30
        v_HoraFim     NUMBER := 1047; -- 17:45
    BEGIN
         IF (p_Sistema in ('SIG' ,'SGI') ) THEN
            v_HoraInicio := 0540;  -- 09:00
            v_HoraFim    := 1080;  -- 18:00
         END IF;
        
         v_Retorno    := p_DataBase + Numtodsinterval(p_Minuto, 'MINUTE');            
         
                  DBMS_OUTPUT.PUT_LINE(p_Minuto);
         DBMS_OUTPUT.PUT_LINE('DataBase: ' || to_char(p_DataBase, 'DD/MM/YYYY HH24:MI:SS'));
         DBMS_OUTPUT.PUT_LINE('Retorno: ' || to_char(v_Retorno,  'DD/MM/YYYY HH24:MI:SS'));
                          
         v_Hora       := To_Number(To_Char(v_Retorno, 'hh24mi')) * 60 / 100;
         IF (v_Hora >  v_HoraFim) THEN
            v_Retorno := v_Retorno + Numtodsinterval(1, 'DAY');
            v_Retorno := To_Date(v_Retorno,'DD/MM/YYYY') + Numtodsinterval(v_HoraInicio, 'MINUTE');            
         END IF;    

         v_Semana     := to_char(v_Retorno,'D');
         IF (v_Semana in (1,7)) THEN   -- Sabado adiciona 2 dias e domingo adiciona 1 dia
            v_Retorno := v_Retorno + Numtodsinterval(IIF(v_Semana = 7,2,1), 'DAY');
         END IF;
        
         RETURN v_Retorno;
    END;
    
BEGIN      
    -- Retorna 2hs, para o primeiro atendimento "Ticket não classificado" 
    IF p_Prioridade is null THEN
        RETURN CalcularPrevisaoAtendimento(120);
    END IF;
    
    -- Procura qualquer tramite diferente de "Em Andamento" 
    SELECT NVL(MAX(ID),0)
      INTO v_Ignora
      FROM MTK_TRAMITE 
     WHERE ID_TICKET = p_IdTicket
       AND STATUS_ATUAL != 3; 

    IF v_Ignora > 0 THEN
        RETURN TO_DATE('31/12/9999', 'DD/MM/YYYY');
    END IF;    
    
    SELECT *
      INTO v_Sla
      FROM MTK_SLA
     WHERE p_IdSla is null And Id = p_Nivel 
        Or Id = p_IdSla;
    
    CASE WHEN p_Prioridade = 1 THEN v_Minuto := v_Sla.Prioridade_Baixa;    
         WHEN p_Prioridade = 2 THEN v_Minuto := v_Sla.Prioridade_Media;
         WHEN p_Prioridade = 3 THEN v_Minuto := v_Sla.Prioridade_Alta;
         WHEN p_Prioridade = 4 THEN
              CASE WHEN p_Severidade = 1 THEN v_Minuto := v_Sla.Emergencia;         
                   WHEN p_Severidade = 2 THEN v_Minuto := v_Sla.Operacao_Degradada;
              END CASE;
    END CASE; 
    
    v_Porcentagem := IIF(p_Critico = 'S', 30, IIf(p_Vip = 1, 20, 0));

    DBMS_OUTPUT.PUT_LINE('---------------------------');
    DBMS_OUTPUT.PUT_LINE('Cri:' || p_Critico);
    DBMS_OUTPUT.PUT_LINE('Vip:' || p_Vip);    

    DBMS_OUTPUT.PUT_LINE(p_IdTicket);
    DBMS_OUTPUT.PUT_LINE('Vip-1:' || v_Minuto);
   
    IF v_Porcentagem > 0 THEN    
        v_Minuto  := v_Minuto - (v_Minuto * v_Porcentagem / 100);  
    END IF;    

    DBMS_OUTPUT.PUT_LINE('Vip-2:' || v_Minuto);

    RETURN CalcularPrevisaoAtendimento(v_Minuto);
END;
/
