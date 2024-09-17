CREATE OR REPLACE TRIGGER TR_EscParam_GlbxToGlb7
    BEFORE UPDATE OR DELETE ON t_Esc_Paramfunc
    FOR EACH ROW
DECLARE
    v_TipoOperacao NUMBER;
    v_funcao EscalaTeste2.Funcionario.Funcao%TYPE;
    v_COMPETENCIA VW_COMPETENCIATERMINAL.COMPETENCIA%TYPE;
    v_Codfunc flp_funcionarios.Codfunc%TYPE;
    v_Chapafunc flp_funcionarios.Chapafunc%TYPE;
    v_Nomefunc flp_funcionarios.Nomefunc%TYPE;
    v_Apelidofunc flp_funcionarios.Apelidofunc%TYPE;
    v_codigoempresa flp_funcionarios.codigoempresa%TYPE;
    v_codigofl flp_funcionarios.codigofl%TYPE;
BEGIN
    BEGIN
        v_TipoOperacao := 0;
        IF DELETING THEN
            v_TipoOperacao := 2;
        END IF;
    
        BEGIN
            SELECT COMPETENCIA
            INTO v_COMPETENCIA
            FROM VW_COMPETENCIATERMINAL;
        
            SELECT decode(TPFUNCFIXA, 'MOT', 0, 1)
                  ,f.Codfunc
                  ,f.Chapafunc
                  ,f.Nomefunc
                  ,f.Apelidofunc
                  ,f.codigoempresa
                  ,f.codigofl
            INTO v_funcao
                ,v_Codfunc
                ,v_Chapafunc
                ,v_Nomefunc
                ,v_Apelidofunc
                ,v_codigoempresa
                ,v_codigofl
            FROM flp_funcionarios f
            INNER JOIN FLP_HISTORICOSALARIAL H ON f.codintfunc = h.codintfunc
            INNER JOIN FLP_FUNCAO U ON U.CODFUNCAO = H.CODFUNCAO
            INNER JOIN BGM_FUFIXO_FUNCAO b ON u.codfuncao = b.codfuncao AND b.TPFUNCFIXA IN ('MOT', 'COB') AND sistema = 'ESC'
            INNER JOIN t_Esc_Paramfunc p ON p.cod_func = H.CODINTFUNC
            WHERE f.codintfunc = :NEW.CODINTFUNC
                  AND H.DTHISTSAL =
                  (SELECT MAX(FLP_HISTORICOSALARIAL.DTHISTSAL)
                   FROM FLP_HISTORICOSALARIAL
                   WHERE FLP_HISTORICOSALARIAL.DTHISTSAL <= v_COMPETENCIA
                         AND FLP_HISTORICOSALARIAL.STATUSHISTSAL = 'N'
                         AND FLP_HISTORICOSALARIAL.CODINTFUNC = :NEW.cod_func );
        EXCEPTION
            WHEN OTHERS THEN
                RETURN;
        END;
    
        IF Inserting OR :NEW.idexterno IS NULL THEN
            :NEW.IdExterno := sys_guid();
            INSERT INTO EscalaTeste2.Funcionario
                (Id
                ,registro
                ,chapa
                ,nome
                ,apelido
                ,idexterno
                ,funcao
                ,IdFilial)
            VALUES
                (SEQ_EmpresaAutorizada.NEXTVAL
                ,:NEW.Codfunc
                ,:NEW.Chapafunc
                ,:NEW.Nomefunc
                ,:NEW.Apelidofunc
                ,:NEW.IdExterno
                ,v_funcao
                ,(SELECT MAX(f.Id)
                 FROM EscalaTeste2.Filial f
                 INNER JOIN EscalaTeste2.Empresa e ON f.IdEmpresa = e.Id
                 WHERE e.Codigo = v_codigoempresa
                       AND f.Codigo = v_codigofl));
        ELSE
            UPDATE EscalaTeste2.Funcionario
            SET registro = :NEW.Codfunc
               ,chapa = :NEW.Chapafunc
               ,nome = :NEW.Nomefunc
               ,apelido = :NEW.Apelidofunc
               ,DataHoraExclusao = (CASE WHEN v_TipoOperacao = 2 THEN SYSDATE ELSE NULL END)
            WHERE IdExterno = :OLD.IdExterno;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line(SQLERRM);
    END;

END TR_EscParam_GlbxToGlb7;
/