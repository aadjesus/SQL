/*
Create Table Manu_Integracao_2(
 SESSION_USER 		Varchar2(100)     DEFAULT SYS_CONTEXT('USERENV','SESSION_USER')		
,OS_USER 			    Varchar2(100)     DEFAULT SYS_CONTEXT('USERENV','OS_USER')			        
,HOST 				    Varchar2(100)     DEFAULT SYS_CONTEXT('USERENV','HOST')				      
,TERMINAL 			  Varchar2(100)     DEFAULT SYS_CONTEXT('USERENV','TERMINAL')			    
,IP_ADDRESS 		  Varchar2(100)     DEFAULT SYS_CONTEXT('USERENV','IP_ADDRESS')				  
,SESSIONID 			  Varchar2(100)     DEFAULT SYS_CONTEXT('USERENV','SESSIONID')			  
,CLIENT_INFO 		  Varchar2(100)     DEFAULT SYS_CONTEXT('USERENV','CLIENT_INFO')		    
,MODULE 			    Varchar2(100)     DEFAULT SYS_CONTEXT('USERENV','MODULE')					    
,ACTION 			    Varchar2(100)     DEFAULT SYS_CONTEXT('USERENV','ACTION')					    
,CURRENT_SQL 		  Varchar2(100)     DEFAULT SYS_CONTEXT('USERENV','CURRENT_SQL')     
,NETWORK_PROTOCOL Varchar2(100)     DEFAULT SYS_CONTEXT('USERENV','NETWORK_PROTOCOL')	
,conteudo  			  Varchar2(4000)
,table_name 		  varchar2(30) 
,transaction_id 	varchar2(20)     
,erro             Varchar2(4000)                   
,data             date                DEFAULT sysdate              
,alterado  			  Varchar2(4000)
,TIPO_OPERACAO    number(1)
);

Create Unique Index IDXmanu_integracao_2
                 On manu_integracao_2(TIPO_OPERACAO, table_name, conteudo )  
                 Tablespace GLOBUS_INDEX ;


Create Unique Index IDXmanu_integracao_2
                 On manu_integracao_2(data, transaction_id)  
                 Tablespace GLOBUS_INDEX                 ;
*/

CREATE OR REPLACE PROCEDURE Pr_Manu_Insert_Json_1(
       p_TIPO_OPERACAO IN NUMBER,
       p_Nome_Tabela   IN VARCHAR2,
       p_Json          IN VARCHAR2,
       p_alterado      IN VARCHAR2) IS
   v_erro Varchar2(2000);
BEGIN
  IF (p_TIPO_OPERACAO = 1 AND p_alterado IS null) THEN
     RETURN;
  END IF; 
  
  BEGIN
    INSERT INTO Manu_Integracao_2(
                TIPO_OPERACAO, 
                Conteudo,
                alterado, 
                Table_Name, 
                Transaction_Id
          ) VALUES (
                p_TIPO_OPERACAO, 
                Chr(123) || p_Json || Chr(125),
                p_alterado, 
                p_Nome_Tabela, 
                Dbms_Transaction.Local_Transaction_Id);  
  EXCEPTION
    WHEN OTHERS THEN
         v_erro := Sqlerrm;
         INSERT INTO Manu_Integracao_2(Conteudo, Transaction_Id, erro) VALUES (sys_guid(), Dbms_Transaction.Local_Transaction_Id, v_erro);
  END;
END Pr_Manu_Insert_Json_1;
