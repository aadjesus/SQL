DECLARE
	v_sql VARCHAR2(4000);	
	
	PROCEDURE Executar(p_sql IN VARCHAR2) IS
	BEGIN
		BEGIN
			EXECUTE IMMEDIATE p_sql;
		EXCEPTION
		WHEN OTHERS THEN
			Dbms_Output.Put_Line(SQLERRM);
		END;
	END;
BEGIN 
	v_sql := '';
	v_sql := v_sql || 'CREATE TABLE MANU_INTEGRACAO(';
	v_sql := v_sql || '  CONTEUDO       VARCHAR2(4000) not null,';
	v_sql := v_sql || '  TRANSACTION_ID VARCHAR2(20) not null,';
	v_sql := v_sql || '  TABLE_NAME     VARCHAR2(30),';
	v_sql := v_sql || '  TIPO_OPERACAO  NUMBER(1),';
	v_sql := v_sql || '  ETAPA          NUMBER(3) DEFAULT 1,';
	v_sql := v_sql || '  DATA           Date default SYSDATE,';
	v_sql := v_sql || '  ID             NUMBER  NOT NULL,';
	v_sql := v_sql || '  CONSTRAINT pk_MANU_INTEGRACAO PRIMARY KEY (ID))';
	Executar(v_sql);

	v_sql := 'create UNIQUE index IDX_MANU_INTEGRACAO on MANU_INTEGRACAO (CONTEUDO) tablespace GLOBUS_INDEX';
	Executar(v_sql);
	
	v_sql := '';
	v_sql := v_sql || 'create table manu_carga_inicial(';
	v_sql := v_sql || '  TABLE_NAME VARCHAR2(30) not null,';
	v_sql := v_sql || '  DATA_INICIAL       DATE default SYSDATE,';
	v_sql := v_sql || '  DATA_FINAL         DATE,';
	v_sql := v_sql || '  carga_inicial      NUMBER(1) DEFAULT 0,';
	v_sql := v_sql || '  tipo_Operacao      NUMBER(1) DEFAULT 0,';
	v_sql := v_sql || '  Qtde               NUMBER,';
	v_sql := v_sql || '  CONSTRAINT pk_manu_carga_inicial PRIMARY KEY (table_name))';
	Executar(v_sql);

	v_sql := '';
	v_sql := v_sql || 'create table manu_condicao(';
	v_sql := v_sql || '  TABLE_NAME          VARCHAR2(30) not null,';
	v_sql := v_sql || '  Cond_Carga_inicial  VARCHAR2(4000),';
	v_sql := v_sql || '  CONSTRAINT pk_manu_condicao PRIMARY KEY (table_name))';
	Executar(v_sql);
	
	v_sql := 'ALTER TABLE man_os ADD(Fechamento_manu VARCHAR2(1))';
	Executar(v_sql);	

	v_sql := 'create or replace type T_Manu_Colunas Is Table Of Varchar2(30)';
	Executar(v_sql);


	v_sql := 'CREATE SEQUENCE SEQ_MANU_INTEGRACAO MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 20 ORDER';
	Executar(v_sql);

	v_sql := 'Insert Into CTR_CADASTROSISTEMAS (sistema, nomedosistema) Values(''360'',''MANU360'')';
	Executar(v_sql);

END;