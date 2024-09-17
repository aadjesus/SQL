Declare
    v_table_name User_Tables.Table_Name%Type;
Begin
    Begin
        Select a.table_name
          Into v_table_name
          From User_Tables a
         Where a.table_name = 'LOG_TRIGGER';
    Exception
        When Others Then
            Execute Immediate 'CREATE TABLE LOG_TRIGGER(CONTEUDO  VARCHAR2(4000) not null, Tabela  VARCHAR2(30) not null, Chave  VARCHAR2(1000), DATA Date default SYSDATE not null)';
    End;
End;

Create Or Replace Procedure Pr_LOG_TRIGGER(
       p_Tabela LOG_TRIGGER.Tabela%TYPE,
       p_conteudo LOG_TRIGGER.CONTEUDO%TYPE,
       p_Chave LOG_TRIGGER.p_Chave%TYPE = NULL) Is
Begin
    Insert Into LOG_TRIGGER
        (Conteudo,
         Tabela,
         Chave)
    Values
        (p_conteudo,
         p_Tabela,
         p_Chave);
End;