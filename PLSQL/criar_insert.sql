declare
  PROCEDURE Incluir(P_TABELA VARCHAR2, P_JSON VARCHAR2) IS 
  BEGIN
       DBMS_OUTPUT.PUT_LINE(
               'INSERT INTO Manu_Integracao(Id, Transaction_Id, Tipo_Operacao, Table_Name, Conteudo) ' ||
		           '     SELECT Seq_Manu_Integracao.NEXTVAL'||
			         '          , Dbms_Transaction.Local_Transaction_Id'||
			         '          , -3'||
			         '          , '''|| P_TABELA ||''''||
			         '          , Chr(123) ||' || P_JSON || ' || Chr(125) AS Conteudo '|| 
               '      FROM ' || P_TABELA ||
               '');     
  end;  
begin
     Incluir('MAN_GrupoDeServico'
            ,'''codigogrpservi''     ||'':''''||' || 'codigogrpservi'     ||'||'','||
             '''descricaogrpservi''  ||'':''''||' || 'descricaogrpservi'  ||'||'','||
             '''utilizacaogrpservi'' ||'':''''||' || 'utilizacaogrpservi' ||''''

            
                 
                 );
end;

--INSERT INTO Manu_Integracao(Id, Transaction_Id, Tipo_Operacao, Table_Name, Conteudo)      
--  SELECT Seq_Manu_Integracao.NEXTVAL          
--       , Dbms_Transaction.Local_Transaction_Id          
--       , -3          
--       , 'MAN_GrupoDeServico'          
--       , Chr(123) ||'codigogrpservi':'codigogrpservi','descricaogrpservi':'descricaogrpservi','utilizacaogrpservi':'utilizacaogrpservi' || Chr(125) AS Conteudo       FROM MAN_GrupoDeServico