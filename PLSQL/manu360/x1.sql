DECLARE
	p_Codintfunc      NUMBER;
	p_Dthistsal       DATE;
	p_Idhistsal       NUMBER(3);
	p_Codsindi        NUMBER(3);
	p_Codsetor        NUMBER(4);
	p_Codsecao        NUMBER(4);
	p_Coddepto        NUMBER(4);
	p_Codarea         NUMBER(4);
	p_Codfuncao       NUMBER(4);
	p_Codhora         NUMBER(4);
	p_Codescala       NUMBER(5);
	p_Codasmed        NUMBER(3);
	p_Cododont        NUMBER(3);
	p_Salbase         NUMBER(15, 2);
	p_Salaux1         NUMBER(15, 2);
	p_Salaux2         NUMBER(15, 2);
	p_Salaux3         NUMBER(15, 2);
	p_Salaux4         NUMBER(15, 2);
	p_Salaux5         NUMBER(15, 2);
	p_Salaux6         NUMBER(15, 2);
	p_Hrsemfuncao     NUMBER(2);
	p_Hrsemaux1funcao NUMBER(2);
	p_Hrsemaux2funcao NUMBER(2);
	p_Hrsemaux3funcao NUMBER(2);
	p_Hrsemaux4funcao NUMBER(2);
	p_Hrsemaux5funcao NUMBER(2);
	p_Hrsemaux6funcao NUMBER(2);
	p_Tpsalfuncao     VARCHAR2(1);
	p_Tpsalaux1funcao VARCHAR2(1);
	p_Tpsalaux2funcao VARCHAR2(1);
	p_Tpsalaux3funcao VARCHAR2(1);
	p_Tpsalaux4funcao VARCHAR2(1);
	p_Tpsalaux5funcao VARCHAR2(1);
	p_Tpsalaux6funcao VARCHAR2(1);
	p_Salmes          NUMBER;
	p_Salmesaux1      NUMBER;
	p_Salmesaux2      NUMBER;
	p_Salmesaux3      NUMBER;
	p_Salmesaux4      NUMBER;
	p_Salmesaux5      NUMBER;
	p_Salmesaux6      NUMBER;
	p_Salhor          NUMBER;
	p_Salhoraux1      NUMBER;
	p_Salhoraux2      NUMBER;
	p_Salhoraux3      NUMBER;
	p_Salhoraux4      NUMBER;
	p_Salhoraux5      NUMBER;
	p_Salhoraux6      NUMBER;
	p_Saldia          NUMBER;
	p_Saldiaaux1      NUMBER;
	p_Saldiaaux2      NUMBER;
	p_Saldiaaux3      NUMBER;
	p_Saldiaaux4      NUMBER;
	p_Saldiaaux5      NUMBER;
	p_Saldiaaux6      NUMBER;
	p_Codcargo        NUMBER;
	p_Codsindi2       NUMBER;
BEGIN
	Pr_Trazsalariofuncionario(3378,
									  p_Dthistsal,
									  p_Idhistsal,
									  p_Codsindi,
									  p_Codsetor,
									  p_Codsecao,
									  p_Coddepto,
									  p_Codarea,
									  p_Codfuncao,
									  p_Codhora,
									  p_Codescala,
									  p_Codasmed,
									  p_Cododont,
									  p_Salbase,
									  p_Salaux1,
									  p_Salaux2,
									  p_Salaux3,
									  p_Salaux4,
									  p_Salaux5,
									  p_Salaux6,
									  p_Hrsemfuncao,
									  p_Hrsemaux1funcao,
									  p_Hrsemaux2funcao,
									  p_Hrsemaux3funcao,
									  p_Hrsemaux4funcao,
									  p_Hrsemaux5funcao,
									  p_Hrsemaux6funcao,
									  p_Tpsalfuncao,
									  p_Tpsalaux1funcao,
									  p_Tpsalaux2funcao,
									  p_Tpsalaux3funcao,
									  p_Tpsalaux4funcao,
									  p_Tpsalaux5funcao,
									  p_Tpsalaux6funcao,
									  p_Salmes,
									  p_Salmesaux1,
									  p_Salmesaux2,
									  p_Salmesaux3,
									  p_Salmesaux4,
									  p_Salmesaux5,
									  p_Salmesaux6,
									  p_Salhor,
									  p_Salhoraux1,
									  p_Salhoraux2,
									  p_Salhoraux3,
									  p_Salhoraux4,
									  p_Salhoraux5,
									  p_Salhoraux6,
									  p_Saldia,
									  p_Saldiaaux1,
									  p_Saldiaaux2,
									  p_Saldiaaux3,
									  p_Saldiaaux4,
									  p_Saldiaaux5,
									  p_Saldiaaux6,
									  p_Codcargo,
									  p_Codsindi2);
	Dbms_Output.Put_Line(p_Salhor);

   SELECT max(dthistsal)
   INTO p_Dthistsal
  FROM Flp_Historicosalarial 
   WHERE Codintfunc = 3378;
   
	Dbms_Output.Put_Line(Func_Trazsalario(3378,p_Dthistsal,'H', 1));

END;


--SELECT SYSDATE FROM dual