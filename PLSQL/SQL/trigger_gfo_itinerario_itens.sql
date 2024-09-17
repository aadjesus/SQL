create or replace trigger TR_xisto
   after insert on gfo_itinerario_itens

  for each row

Declare
  V_QTDE NUMBER;

begin

  If Inserting Then
      SELECT
       Count(*)
      INTO
        V_QTDE
      FROM
        t_esc_localidade
      WHERE cod_localidade = :New.cod_localidade;

       If V_QTDE = 0 Then
          INSERT INTO t_esc_localidade 
                (cod_localidade,desc_localidade )
          VALUES 
                 (:New.cod_localidade, 'Descricao - ' || to_char(:New.cod_localidade) );
       End If;
  End If;

End TR_xisto;


----------------------------

--SELECT UTL_INADDR.get_host_address from dual;
--SELECT UTL_INADDR.get_host_name('192.168.2.4') FROM dual;
--SELECT UTL_INADDR.get_host_name FROM dual;
--SELECT SYS_CONTEXT('USERENV','TERMINAL') FROM dual;

SELECT SYS_CONTEXT('USERENV','HOST') FROM dual;

--SELECT SYS_CONTEXT('USERENV','IP_ADDRESS') FROM dual;
--SELECT SYS_CONTEXT('USERENV','SERVER_HOST') FROM dual;

 SELECT terminal, machine FROM v$session

SELECT LEVEL l  FROM dual CONNECTED BY LEVEL <= 365


1. sid of current session
SELECT SYS_CONTEXT('USERENV','SID') FROM DUAL;
OR
SELECT USERENV('SID') FROM DUAL

2. name of host from which client has connectd to oracle
SELECT SYS_CONTEXT('USERENV', 'HOST') FROM DUAL;

3. os username of the client process that has started the session.
SELECT SYS_CONTEXT('USERENV', 'OS_USER') FROM DUAL;

4. ip address from which the client is connected.
SELECT SYS_CONTEXT('USERENV', 'IP_ADDRESS') FROM DUAL;

5. name of the instance
SELECT SYS_CONTEXT('USERENV', 'INSTANCE_NAME') FROM DUAL;

6. name of the database as db_name initialization parameter.
SELECT SYS_CONTEXT('USERENV', 'DB_NAME') FROM DUAL;

7. domain of the database as db_domain initialization parameter.
SELECT SYS_CONTEXT('USERENV', 'DB_DOMAIN') FROM DUAL;

8. db user name by which the current user is authenticated.
SELECT SYS_CONTEXT ('USERENV', 'SESSION_USER') FROM DUAL;

9. get sid and serial# from current session using the auditing session identifier
SELECT SID, SERIAL# FROM V$SESSION WHERE AUDSID = SYS_CONTEXT('USERENV','SESSIONID');

----------------------------




CREATE OR REPLACE TRIGGER global_logon_trg AFTER logon ON DATABASE
DECLARE
   p_aplicacao  varchar2(100);
   p_usuario    varchar2(100);
   p_ip         varchar2(100);
BEGIN
   SELECT UPPER(SYS_CONTEXT('USERENV','MODULE'    )) INTO p_aplicacao FROM DUAL;
   SELECT UPPER(SYS_CONTEXT('USERENV','HOST'      )) INTO p_usuario   FROM DUAL;
   SELECT UPPER(SYS_CONTEXT('USERENV','IP_ADDRESS')) INTO p_ip        FROM DUAL;

   INSERT INTO xxxx_teste 
         (aplicacao ,usuario, ip ,data )
    VALUES 
         (p_aplicacao, p_usuario, p_ip , sysdate );   


END;


/*Create Table xxxx_teste(aplicacao Varchar2(100) 
                    ,Usuario Varchar2(100) 
                    ,Data Date)*/



----------------------------



