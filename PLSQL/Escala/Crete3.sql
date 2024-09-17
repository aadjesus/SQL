  --connect MOBIBRASIL180726@MOBIBRASIL180726;
DROP USER ESCALATESTE_ALE CASCADE;
CREATE USER ESCALATESTE_ALE IDENTIFIED BY ESCALATESTE_ALE DEFAULT TABLESPACE GLOBUS_TABLE;

-- Grant/Revoke role privileges
grant connect to ESCALATESTE_ALE;
grant dba to ESCALATESTE_ALE;
grant imp_full_database to ESCALATESTE_ALE;
grant resource to ESCALATESTE_ALE;
grant select_catalog_role to ESCALATESTE_ALE;
-- Grant/Revoke system privileges
grant create public synonym to ESCALATESTE_ALE;
grant debug any procedure to ESCALATESTE_ALE;
grant debug connect session to ESCALATESTE_ALE;
grant select any table to ESCALATESTE_ALE;
grant insert any table to ESCALATESTE_ALE;
grant update any table to ESCALATESTE_ALE;
grant delete any table to ESCALATESTE_ALE;
grant select any sequence to ESCALATESTE_ALE;
grant execute any procedure to ESCALATESTE_ALE;
grant unlimited tablespace to ESCALATESTE_ALE;

/*Declare
    Cursor c_Coluna Is
        Select table_name
          From user_tab_cols
         Where column_name = 'ID_EXTERNO';
Begin
    For itemColuna In c_Coluna
    Loop
        Begin
            Execute Immediate 'ALTER TABLE  ' || itemColuna.table_name ||
                              ' DROP COLUMN id_externo';
        Exception
            When Others Then
                dbms_output.put_line(itemColuna.table_name || ': ' ||
                                     Sqlerrm);
        End;
    End Loop;
End;*/

/*DROP USER ESCALATESTE_ALE Cascade;
CREATE USER ESCALATESTE_ALE IDENTIFIED BY ESCALATESTE_ALE DEFAULT TABLESPACE GLOBUS_TABLE;
GRANT DBA TO ESCALATESTE_ALE;
GRANT CONNECT TO ESCALATESTE_ALE;

-- Grant/Revoke role privileges 
--grant connect to ESCALATESTE_ALE;
grant dba to ESCALATESTE_ALE;
grant imp_full_database to ESCALATESTE_ALE;
grant resource to ESCALATESTE_ALE;
grant select_catalog_role to ESCALATESTE_ALE;

grant create public synonym to ESCALATESTE_ALE;
grant debug any procedure to ESCALATESTE_ALE;
grant debug connect session to ESCALATESTE_ALE;
grant select any table to ESCALATESTE_ALE;
grant unlimited tablespace to ESCALATESTE_ALE;

grant execute on MOBIBRASIL180726.PRESC_GERAESCALADIARIA to ESCALATESTE_ALE;
grant execute on MOBIBRASIL180726.PRESC_GERAESCALADIARIA02 to ESCALATESTE_ALE;
grant execute on MOBIBRASIL180726.PRESC_EXCLUIESCALADIARIA  to ESCALATESTE_ALE;
grant execute on MOBIBRASIL180726.PRESC_EXCLUIESCALADIARIA2A  to ESCALATESTE_ALE;

grant update, insert, DELETE, select on MOBIBRASIL180726.T_ESC_ESCALAPADRAO to ESCALATESTE_ALE;
grant update, insert, DELETE, select on MOBIBRASIL180726.T_ESC_SERVICOPADRAO to ESCALATESTE_ALE;
grant update, insert, DELETE, select on MOBIBRASIL180726.T_esc_SERVICODIARIA to ESCALATESTE_ALE;
grant update, insert, DELETE, select on MOBIBRASIL180726.T_ESC_TEMPORARIA to ESCALATESTE_ALE;
grant update, insert, DELETE, select on MOBIBRASIL180726.Flp_Funcionarios to ESCALATESTE_ALE;
grant update, insert, DELETE, select on MOBIBRASIL180726.T_esc_SERVICODIARIA TO escalademonstracao;
grant update, insert, DELETE, select on MOBIBRASIL180726.T_ESC_TEMPORARIA TO escalademonstracao;

ALTER TABLE  MOBIBRASIL180726.ctr_empautorizadas DROP COLUMN id_externo;
ALTER TABLE  MOBIBRASIL180726.flp_area DROP COLUMN  id_externo;
ALTER TABLE  MOBIBRASIL180726.FLP_FUNCIONARIOS_COMPLEMENTAR DROP COLUMN  id_externo;
ALTER TABLE  MOBIBRASIL180726.Frt_Tipodefrota DROP COLUMN  id_externo;
ALTER TABLE  MOBIBRASIL180726.Frt_cadveiculos DROP COLUMN  id_externo;
ALTER TABLE  MOBIBRASIL180726.BGM_CADLINHAS DROP COLUMN  id_externo;
ALTER TABLE  MOBIBRASIL180726.T_ESC_ESCALAPADRAO DROP COLUMN  id_externo;
ALTER TABLE  MOBIBRASIL180726.T_ESC_SERVICOPADRAO DROP COLUMN  id_externo;
ALTER TABLE  MOBIBRASIL180726.CTR_CADASTRODEUSUARIOS DROP COLUMN  id_externo;
*/
/*
grant update, insert, select on ESCALATESTE_ALE.empresaautorizada  to MOBIBRASIL180726;
grant update, insert, select on ESCALATESTE_ALE.empresa to MOBIBRASIL180726;
grant update, insert, select on ESCALATESTE_ALE.filial to MOBIBRASIL180726;
grant update, insert, select on ESCALATESTE_ALE.funcionario to MOBIBRASIL180726;
grant update, insert, select on ESCALATESTE_ALE.tecnologia to MOBIBRASIL180726;
grant update, insert, select on ESCALATESTE_ALE.veiculo to MOBIBRASIL180726;
grant update, insert, select on ESCALATESTE_ALE.linha to MOBIBRASIL180726;



Create Or Replace Procedure Teste_Integracao Is
    v_cod_intescala Number;
Begin

    Select Min(a.cod_intescala)
      Into v_cod_intescala
      From GRUPONIFF180620.T_ESC_ESCALAPADRAO a
     Inner Join padrao b On a.id_externo = b.idexterno
     Where Not Exists (Select 1
              From GRUPONIFF180620.t_Esc_Escaladiaria b
             Where a.cod_intescala = b.cod_intescala);
    
     Delete GRUPONIFF180620.T_ESC_SERVICOPADRAO b
     Where Exists (Select 1
              From GRUPONIFF180620.T_ESC_ESCALAPADRAO a
             Where a.COD_INTESCALA = b.COD_INTESCALA
                   And a.cod_intescala = v_cod_intescala);

    Delete GRUPONIFF180620.T_ESC_ESCALAPADRAO
     Where cod_intescala = v_cod_intescala;
End;

*/

