Create Table Tabela_Teste(
       Campo1 number,
       Campo2 number,
       Campo3 number,
       Campo4 NUMBER
        );
INSERT INTO Tabela_Teste (Campo1,Campo2,Campo3,Campo4)  VALUES (1,12,13,14);
INSERT INTO Tabela_Teste (Campo1,Campo2,Campo3,Campo4)  VALUES (2,22,23,24);
INSERT INTO Tabela_Teste  (Campo1,Campo2,Campo3,Campo4)  VALUES (3,32,33,34);
       
//------------------------ Criando tipo
CREATE OR REPLACE TYPE TYPE_OBJETO_TESTE AS OBJECT
( 
  COLUNA1        NUMBER,
  COLUNA2        NUMBER
);
CREATE OR REPLACE TYPE TYPE_TABLE_TESTE AS TABLE OF TYPE_OBJETO_TESTE;

//------------------------ Criando função
CREATE OR REPLACE FUNCTION FC_RETORNAR( P_Campo1 NUMBER) RETURN TYPE_TABLE_TESTE AS
  V_RETORNO TYPE_TABLE_TESTE;

  CURSOR C_DADOS IS
            SELECT a.Campo1 + a.Campo2 AS Campo1
                         ,  a.Campo3 + a.Campo4 AS Campo2
            FROM Tabela_Teste a
            WHERE a.Campo1 = P_Campo1 ;
BEGIN
     IF  (P_Campo1 = 0)          THEN
          RAISE_APPLICATION_ERROR(
                                  	-20000,                                                               ---- NUMERO DO ERRO ORACLE
                               			'Parametro não pode ser 0');                       ---- MENSAGEM    
     END IF;

  V_RETORNO := TYPE_TABLE_TESTE();


  FOR R_DADOS IN C_DADOS LOOP
    V_RETORNO.EXTEND;
    V_RETORNO(V_RETORNO.COUNT) := TYPE_OBJETO_TESTE(
	                             R_DADOS.Campo1,
                               R_DADOS.Campo2);
  END LOOP;
  
  RETURN V_RETORNO;
END;
//------------------------ Exemplo de utilização

Select * From Table(FC_RETORNAR(1))  
Select * From Table(FC_RETORNAR(0))  