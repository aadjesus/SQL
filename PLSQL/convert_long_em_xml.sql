CREATE OR REPLACE FUNCTION F_LONG_TO_XML(p_rowid IN ROWID) RETURN XMLTYPE IS
    v_long LONG;
    v_clob CLOB;
BEGIN
    SELECT conteudoxml INTO v_long
    FROM BGM_XML_TERCEIROS
    WHERE ROWID = p_rowid;

    v_clob := TO_CLOB(v_long);

    RETURN XMLTYPE(v_clob);

    EXCEPTION WHEN OTHERS THEN
         dbms_output.put_line(SQLERRM);
         RETURN NULL;
    END;
