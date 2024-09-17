CREATE OR REPLACE TRIGGER TR_ExemploTrigger
    BEFORE INSERT OR UPDATE OR DELETE ON Nome_Tabela
    FOR EACH ROW
DECLARE
    v_Variavel1 NUMBER;
    v_Variavel2 Nome_Tabela.Nome_Campo%TYPE;
BEGIN
    IF Inserting THEN
        dbms_output.put_line('Incluir');
    ELSIF updating THEN
        dbms_output.put_line('Alterar');
    ELSIF deleting THEN
        dbms_output.put_line('Excluir');
    END IF;
END TR_ExemploTrigger;
/