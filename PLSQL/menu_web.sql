-------------------------------------------------------------------------------------------------------------------------------------------------
-- CRIAR TABELA
declare
  v_existe number;
BEGIN
  SELECT count(*)
    INTO v_existe
    FROM user_tables
   WHERE table_name = 'MENUWEB';

  IF v_existe = 0 THEN
    EXECUTE IMMEDIATE 'CREATE TABLE MenuWeb (
      nome VARCHAR2(100) NOT NULL,
      sistema VARCHAR2(3) NOT NULL,
      data_inclusao DATE DEFAULT SYSDATE NOT NULL,
      data_inativo DATE
    )';
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ocorreu um erro: ' || SQLERRM);
END;
-------------------------------------------------------------------------------------------------------------------------------------------------
-- CRIAR INSERT
declare
  v_qtde number;
  Cursor c_menus Is
    select a.nome
      from (SELECT upper(TRIM(REGEXP_SUBSTR(menus, '[^,]+', 1, LEVEL))) AS nome
              FROM (SELECT 'Menu1 , valor2,valor3,valor4' AS menus
                      FROM DUAL)
            CONNECT BY LEVEL <= LENGTH(menus) - LENGTH(REPLACE(menus, ',', '')) + 1) a
     where not exists(select 1 
                        from MenuWeb b 
                       where b.nome = a.nome);
BEGIN
  v_qtde := 0;
  For item_menu In c_menus Loop
    INSERT INTO MenuWeb(sistema, nome) 
                 VALUES('ACD', item_menu.nome);
    v_qtde := v_qtde + 1;
  End Loop;
  
  If v_qtde > 0 then
     DBMS_OUTPUT.PUT_LINE('Qtde menus incluidos: '|| v_qtde);
     COMMIT;
  End If;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Ocorreu um erro ao tentar incluir o menu: ' || SQLERRM);
END;
