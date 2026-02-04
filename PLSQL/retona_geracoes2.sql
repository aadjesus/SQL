declare
  v_sql   CLOB := '';
  v_linha CLOB := '';
  v_first BOOLEAN := TRUE;
  Cursor c_User Is
    select owner
      from all_all_tables
     where table_name IN ('CTR_CADASTRODEUSUARIOS','FLP_FUNCIONARIOS','ACD_INFORMACOESGERAIS');
BEGIN
  v_sql := '';
  For item_User In c_User Loop
    BEGIN
          v_linha := 
          'SELECT GERACAO, COUNT(*) AS QTDE, ''' || item_User.owner || ''' AS OWNER ' ||
          'FROM ( ' ||
          '  SELECT CASE ' ||
          '           WHEN EXTRACT(YEAR FROM B.DTNASCTOFUNC) BETWEEN 2010 AND EXTRACT(YEAR FROM SYSDATE) THEN ''ALFA'' ' ||
          '           WHEN EXTRACT(YEAR FROM B.DTNASCTOFUNC) BETWEEN 1996 AND 2009 THEN ''Z'' ' ||
          '           WHEN EXTRACT(YEAR FROM B.DTNASCTOFUNC) BETWEEN 1981 AND 1995 THEN ''Y'' ' ||
          '           WHEN EXTRACT(YEAR FROM B.DTNASCTOFUNC) BETWEEN 1965 AND 1980 THEN ''X'' ' ||
          '           WHEN EXTRACT(YEAR FROM B.DTNASCTOFUNC) BETWEEN 1946 AND 1964 THEN ''BABY BOOMER'' ' ||
          '         END AS GERACAO ' ||
          '    FROM ' || item_User.owner || '.CTR_CADASTRODEUSUARIOS A ' ||
          '    INNER JOIN ' || item_User.owner || '.FLP_FUNCIONARIOS B ON A.CODINTFUNC = B.CODINTFUNC ' ||
          ') WHERE GERACAO IS NOT NULL GROUP BY GERACAO';
    
        v_sql := v_sql || v_linha;
        DBMS_OUTPUT.PUT_LINE(item_User.owner||'----'|| v_linha);
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(item_User.owner||'----'|| SQLERRM);
    END;
    
  End Loop;
  
  --EXECUTE IMMEDIATE v_sql
    DBMS_OUTPUT.PUT_LINE(v_sql);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
