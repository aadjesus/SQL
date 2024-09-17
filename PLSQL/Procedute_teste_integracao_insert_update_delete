CREATE OR REPLACE PROCEDURE teste_integracao(p_codcli_parceria varchar2) Is
    v_idexterno raw(16);
    v_empresa   number;
    v_filial    number;
    v_garagem   number;
BEGIN
    Dbms_Output.Put_Line('--- Incluindo ');

    v_empresa := 800;
    v_filial  := 811;
    v_garagem := 811;

    begin
        select id_externo
          into v_idexterno
          from PBA012
         where empresa = v_empresa
               and filial = v_filial
               and garagem = v_garagem;
    EXCEPTION
        WHEN OTHERS THEN
        
            insert into PBA012
                (empresa,
                 filial,
                 garagem,
                 recnum)
            values
                (v_empresa,
                 v_filial,
                 v_garagem,
                 (select max(recnum) + 1 from PBA012));
    END;

    Dbms_Output.Put_Line('--- Alterando ');
    update PBA012
       set codcli_parceria = p_codcli_parceria --828 --6
     where id_externo = v_idexterno;

    --  Dbms_Output.Put_Line('--- Excluindo ');
    --  delete PBA012 where id_externo = v_idexterno;

    Dbms_Output.Put_Line('--- ' || TO_CHAR(v_idexterno));

END;