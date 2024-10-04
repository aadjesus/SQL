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
);
/

Create Index IDXmanu_integracao_2
                 On manu_integracao_2(table_name, data )  
                 Tablespace GLOBUS_INDEX ;
/


CREATE OR REPLACE PROCEDURE Pr_Manu_Insert_Json_2(
       p_Nome_Tabela   IN VARCHAR2,
       p_Json          IN VARCHAR2) IS
   v_erro Varchar2(2000);
BEGIN

  BEGIN
    INSERT INTO Manu_Integracao_2(
                Table_Name,
                Conteudo,
                Transaction_Id
          ) VALUES (
                p_Nome_Tabela,
                Chr(123) || p_Json || Chr(125),
                Dbms_Transaction.Local_Transaction_Id);
  EXCEPTION
    WHEN OTHERS THEN
         v_erro := Sqlerrm;
         INSERT INTO Manu_Integracao_2(Table_Name, Transaction_Id, erro) VALUES (p_Nome_Tabela, Dbms_Transaction.Local_Transaction_Id, v_erro);
  END;
END Pr_Manu_Insert_Json_2;
/


Create Or Replace Trigger TR_Manu_OS_2
  After Insert Or Update Or Delete On MAN_OS
  For Each Row
Declare
  v_Json   Varchar2(4000);
  v_Alterado    Varchar2(4000);
  Operacao INTEGER;
Begin
  IF Inserting THEN
    Operacao := 0;
  ELSIF Updating THEN
    Operacao := 1;
  ELSE
    Operacao := 2;
  END IF;
  

  Begin
  	if (nvl(:Old.ATUALI_INICIAL               ,'x'    ) != nvl(:New.ATUALI_INICIAL                ,'x'    )) Then v_Alterado := v_Alterado ||', ATUALI_INICIAL ('				  || TO_CHAR(:New.ATUALI_INICIAL                 ) 							||' / ' || TO_CHAR(:Old.ATUALI_INICIAL                 ) || ')' ; END IF;
  	if (nvl(:Old.BAIXADAOSCODBARRA            ,'x'    ) != nvl(:New.BAIXADAOSCODBARRA             ,'x'    )) Then v_Alterado := v_Alterado ||', BAIXADAOSCODBARRA ('              || TO_CHAR(:New.BAIXADAOSCODBARRA              ) 							||' / ' || TO_CHAR(:Old.BAIXADAOSCODBARRA              ) || ')' ; END IF;  
  	if (nvl(:Old.CODCUSTO                     ,0      ) != nvl(:New.CODCUSTO                      ,0      )) Then v_Alterado := v_Alterado ||', CODCUSTO ('                       || TO_CHAR(:New.CODCUSTO                       ) 							||' / ' || TO_CHAR(:Old.CODCUSTO                       ) || ')' ; END IF;
  	if (nvl(:Old.CODIGOEMPRESA                ,0      ) != nvl(:New.CODIGOEMPRESA                 ,0      )) Then v_Alterado := v_Alterado ||', CODIGOEMPRESA ('                  || TO_CHAR(:New.CODIGOEMPRESA                  ) 							||' / ' || TO_CHAR(:Old.CODIGOEMPRESA                  ) || ')' ; END IF;
  	if (nvl(:Old.CODIGOFL                     ,0      ) != nvl(:New.CODIGOFL                      ,0      )) Then v_Alterado := v_Alterado ||', CODIGOFL ('                       || TO_CHAR(:New.CODIGOFL                       ) 							||' / ' || TO_CHAR(:Old.CODIGOFL                       ) || ')' ; END IF;
  	if (nvl(:Old.CODIGOFORN                   ,0      ) != nvl(:New.CODIGOFORN                    ,0      )) Then v_Alterado := v_Alterado ||', CODIGOFORN ('                     || TO_CHAR(:New.CODIGOFORN                     ) 							||' / ' || TO_CHAR(:Old.CODIGOFORN                     ) || ')' ; END IF;
  	if (nvl(:Old.CODIGOGA                     ,0      ) != nvl(:New.CODIGOGA                      ,0      )) Then v_Alterado := v_Alterado ||', CODIGOGA ('                       || TO_CHAR(:New.CODIGOGA                       ) 							||' / ' || TO_CHAR(:Old.CODIGOGA                       ) || ')' ; END IF;
  	if (nvl(:Old.CODIGOINTCOMPO               ,0      ) != nvl(:New.CODIGOINTCOMPO                ,0      )) Then v_Alterado := v_Alterado ||', CODIGOINTCOMPO ('                 || TO_CHAR(:New.CODIGOINTCOMPO                 ) 							||' / ' || TO_CHAR(:Old.CODIGOINTCOMPO                 ) || ')' ; END IF;
  	if (nvl(:Old.CODIGOINTMOTOR               ,0      ) != nvl(:New.CODIGOINTMOTOR                ,0      )) Then v_Alterado := v_Alterado ||', CODIGOINTMOTOR ('                 || TO_CHAR(:New.CODIGOINTMOTOR                 ) 							||' / ' || TO_CHAR(:Old.CODIGOINTMOTOR                 ) || ')' ; END IF;
  	if (nvl(:Old.CODIGOVEIC                   ,0      ) != nvl(:New.CODIGOVEIC                    ,0      )) Then v_Alterado := v_Alterado ||', CODIGOVEIC ('                     || TO_CHAR(:New.CODIGOVEIC                     ) 							||' / ' || TO_CHAR(:Old.CODIGOVEIC                     ) || ')' ; END IF;
  	if (nvl(:Old.CODINTAUTSOC                 ,0      ) != nvl(:New.CODINTAUTSOC                  ,0      )) Then v_Alterado := v_Alterado ||', CODINTAUTSOC ('                   || TO_CHAR(:New.CODINTAUTSOC                   ) 							||' / ' || TO_CHAR(:Old.CODINTAUTSOC                   ) || ')' ; END IF;
  	if (nvl(:Old.CODINTFUNC                   ,0      ) != nvl(:New.CODINTFUNC                    ,0      )) Then v_Alterado := v_Alterado ||', CODINTFUNC ('                     || TO_CHAR(:New.CODINTFUNC                     ) 							||' / ' || TO_CHAR(:Old.CODINTFUNC                     ) || ')' ; END IF;
  	if (nvl(:Old.CODINTFUNCFECHAMENTOOS       ,0      ) != nvl(:New.CODINTFUNCFECHAMENTOOS        ,0      )) Then v_Alterado := v_Alterado ||', CODINTFUNCFECHAMENTOOS ('         || TO_CHAR(:New.CODINTFUNCFECHAMENTOOS         ) 							||' / ' || TO_CHAR(:Old.CODINTFUNCFECHAMENTOOS         ) || ')' ; END IF;
  	if (nvl(:Old.CODINTFUNCSOC                ,0      ) != nvl(:New.CODINTFUNCSOC                 ,0      )) Then v_Alterado := v_Alterado ||', CODINTFUNCSOC ('                  || TO_CHAR(:New.CODINTFUNCSOC                  ) 							||' / ' || TO_CHAR(:Old.CODINTFUNCSOC                  ) || ')' ; END IF;
  	if (nvl(:Old.CODINTLINHA                  ,0      ) != nvl(:New.CODINTLINHA                   ,0      )) Then v_Alterado := v_Alterado ||', CODINTLINHA ('                    || TO_CHAR(:New.CODINTLINHA                    ) 							||' / ' || TO_CHAR(:Old.CODINTLINHA                    ) || ')' ; END IF;
  	if (nvl(:Old.CODINTNF                     ,0      ) != nvl(:New.CODINTNF                      ,0      )) Then v_Alterado := v_Alterado ||', CODINTNF ('                       || TO_CHAR(:New.CODINTNF                       ) 							||' / ' || TO_CHAR(:Old.CODINTNF                       ) || ')' ; END IF;
  	if (nvl(:Old.CODINTOS                     ,0      ) != nvl(:New.CODINTOS                      ,0      )) Then v_Alterado := v_Alterado ||', CODINTOS ('                       || TO_CHAR(:New.CODINTOS                       ) 							||' / ' || TO_CHAR(:Old.CODINTOS                       ) || ')' ; END IF;
  	if (nvl(:Old.CODINTOSAGRE                 ,0      ) != nvl(:New.CODINTOSAGRE                  ,0      )) Then v_Alterado := v_Alterado ||', CODINTOSAGRE ('                   || TO_CHAR(:New.CODINTOSAGRE                   ) 							||' / ' || TO_CHAR(:Old.CODINTOSAGRE                   ) || ')' ; END IF;
  	if (nvl(:Old.CODINTOSFECHAPN              ,0      ) != nvl(:New.CODINTOSFECHAPN               ,0      )) Then v_Alterado := v_Alterado ||', CODINTOSFECHAPN ('                || TO_CHAR(:New.CODINTOSFECHAPN                ) 							||' / ' || TO_CHAR(:Old.CODINTOSFECHAPN                ) || ')' ; END IF;
  	if (nvl(:Old.CODINTPROAUT                 ,0      ) != nvl(:New.CODINTPROAUT                  ,0      )) Then v_Alterado := v_Alterado ||', CODINTPROAUT ('                   || TO_CHAR(:New.CODINTPROAUT                   ) 							||' / ' || TO_CHAR(:Old.CODINTPROAUT                   ) || ')' ; END IF;
  	if (nvl(:Old.CODINTPROAUTFECHAMENTOOS     ,0      ) != nvl(:New.CODINTPROAUTFECHAMENTOOS      ,0      )) Then v_Alterado := v_Alterado ||', CODINTPROAUTFECHAMENTOOS ('       || TO_CHAR(:New.CODINTPROAUTFECHAMENTOOS       ) 							||' / ' || TO_CHAR(:Old.CODINTPROAUTFECHAMENTOOS       ) || ')' ; END IF;
  	if (nvl(:Old.CODORIGOS                    ,0      ) != nvl(:New.CODORIGOS                     ,0      )) Then v_Alterado := v_Alterado ||', CODORIGOS ('                      || TO_CHAR(:New.CODORIGOS                      ) 							||' / ' || TO_CHAR(:Old.CODORIGOS                      ) || ')' ; END IF;
  	if (nvl(:Old.CODSENTIDO                   ,0      ) != nvl(:New.CODSENTIDO                    ,0      )) Then v_Alterado := v_Alterado ||', CODSENTIDO ('                     || TO_CHAR(:New.CODSENTIDO                     ) 							||' / ' || TO_CHAR(:Old.CODSENTIDO                     ) || ')' ; END IF;
  	if (nvl(:Old.COD_CHECKLIST_PROLOG         ,0      ) != nvl(:New.COD_CHECKLIST_PROLOG          ,0      )) Then v_Alterado := v_Alterado ||', COD_CHECKLIST_PROLOG ('           || TO_CHAR(:New.COD_CHECKLIST_PROLOG           ) 							||' / ' || TO_CHAR(:Old.COD_CHECKLIST_PROLOG           ) || ')' ; END IF;
  	if (nvl(:Old.COD_LOCALIDADE_DESTINO       ,0      ) != nvl(:New.COD_LOCALIDADE_DESTINO        ,0      )) Then v_Alterado := v_Alterado ||', COD_LOCALIDADE_DESTINO ('         || TO_CHAR(:New.COD_LOCALIDADE_DESTINO         ) 							||' / ' || TO_CHAR(:Old.COD_LOCALIDADE_DESTINO         ) || ')' ; END IF;
  	if (nvl(:Old.COD_LOCALIDADE_ORIGEM        ,0      ) != nvl(:New.COD_LOCALIDADE_ORIGEM         ,0      )) Then v_Alterado := v_Alterado ||', COD_LOCALIDADE_ORIGEM ('          || TO_CHAR(:New.COD_LOCALIDADE_ORIGEM          ) 							||' / ' || TO_CHAR(:Old.COD_LOCALIDADE_ORIGEM          ) || ')' ; END IF;
  	if (nvl(:Old.COD_SERVDIARIA               ,'x'    ) != nvl(:New.COD_SERVDIARIA                ,'x'    )) Then v_Alterado := v_Alterado ||', COD_SERVDIARIA ('                 || TO_CHAR(:New.COD_SERVDIARIA                 ) 							||' / ' || TO_CHAR(:Old.COD_SERVDIARIA                 ) || ')' ; END IF;
  	if (nvl(:Old.CONDICAOOS                   ,'x'    ) != nvl(:New.CONDICAOOS                    ,'x'    )) Then v_Alterado := v_Alterado ||', CONDICAOOS ('                     || TO_CHAR(:New.CONDICAOOS                     ) 							||' / ' || TO_CHAR(:Old.CONDICAOOS                     ) || ')' ; END IF;
  	if (nvl(:Old.DATAABERTURAOS               ,sysdate) != nvl(:New.DATAABERTURAOS                ,sysdate)) Then v_Alterado := v_Alterado ||', DATAABERTURAOS ('                 || TO_CHAR(:New.DATAABERTURAOS                 , 'DD-MM-YYYY HH24:MI:SS') ||' / ' || TO_CHAR(:Old.DATAABERTURAOS                 , 'DD-MM-YYYY HH24:MI:SS') || ')' ; END IF;
  	if (nvl(:Old.DATAATUALDAABERTURAOS        ,sysdate) != nvl(:New.DATAATUALDAABERTURAOS         ,sysdate)) Then v_Alterado := v_Alterado ||', DATAATUALDAABERTURAOS ('          || TO_CHAR(:New.DATAATUALDAABERTURAOS          , 'DD-MM-YYYY HH24:MI:SS') ||' / ' || TO_CHAR(:Old.DATAATUALDAABERTURAOS          , 'DD-MM-YYYY HH24:MI:SS') || ')' ; END IF;
  	if (nvl(:Old.DATACANCELAMENTOOS           ,sysdate) != nvl(:New.DATACANCELAMENTOOS            ,sysdate)) Then v_Alterado := v_Alterado ||', DATACANCELAMENTOOS ('             || TO_CHAR(:New.DATACANCELAMENTOOS             , 'DD-MM-YYYY HH24:MI:SS') ||' / ' || TO_CHAR(:Old.DATACANCELAMENTOOS             , 'DD-MM-YYYY HH24:MI:SS') || ')' ; END IF;
  	if (nvl(:Old.DATAEMISSAOOS                ,sysdate) != nvl(:New.DATAEMISSAOOS                 ,sysdate)) Then v_Alterado := v_Alterado ||', DATAEMISSAOOS ('                  || TO_CHAR(:New.DATAEMISSAOOS                  , 'DD-MM-YYYY HH24:MI:SS') ||' / ' || TO_CHAR(:Old.DATAEMISSAOOS                  , 'DD-MM-YYYY HH24:MI:SS') || ')' ; END IF;
  	if (nvl(:Old.DATAFECHAMENTOOS             ,sysdate) != nvl(:New.DATAFECHAMENTOOS              ,sysdate)) Then v_Alterado := v_Alterado ||', DATAFECHAMENTOOS ('               || TO_CHAR(:New.DATAFECHAMENTOOS               , 'DD-MM-YYYY HH24:MI:SS') ||' / ' || TO_CHAR(:Old.DATAFECHAMENTOOS               , 'DD-MM-YYYY HH24:MI:SS') || ')' ; END IF;
  	if (nvl(:Old.DATAHORAULTALTERACAOORIGEMOS ,sysdate) != nvl(:New.DATAHORAULTALTERACAOORIGEMOS  ,sysdate)) Then v_Alterado := v_Alterado ||', DATAHORAULTALTERACAOORIGEMOS ('   || TO_CHAR(:New.DATAHORAULTALTERACAOORIGEMOS   , 'DD-MM-YYYY HH24:MI:SS') ||' / ' || TO_CHAR(:Old.DATAHORAULTALTERACAOORIGEMOS   , 'DD-MM-YYYY HH24:MI:SS') || ')' ; END IF;
  	if (nvl(:Old.DATARECOLHIDA                ,sysdate) != nvl(:New.DATARECOLHIDA                 ,sysdate)) Then v_Alterado := v_Alterado ||', DATARECOLHIDA ('                  || TO_CHAR(:New.DATARECOLHIDA                  , 'DD-MM-YYYY HH24:MI:SS') ||' / ' || TO_CHAR(:Old.DATARECOLHIDA                  , 'DD-MM-YYYY HH24:MI:SS') || ')' ; END IF;
  	if (nvl(:Old.DATARETORNOPROGRAMADO        ,sysdate) != nvl(:New.DATARETORNOPROGRAMADO         ,sysdate)) Then v_Alterado := v_Alterado ||', DATARETORNOPROGRAMADO ('          || TO_CHAR(:New.DATARETORNOPROGRAMADO          , 'DD-MM-YYYY HH24:MI:SS') ||' / ' || TO_CHAR(:Old.DATARETORNOPROGRAMADO          , 'DD-MM-YYYY HH24:MI:SS') || ')' ; END IF;
  	if (nvl(:Old.DATA_HORA                    ,sysdate) != nvl(:New.DATA_HORA                     ,sysdate)) Then v_Alterado := v_Alterado ||', DATA_HORA ('                      || TO_CHAR(:New.DATA_HORA                      , 'DD-MM-YYYY HH24:MI:SS') ||' / ' || TO_CHAR(:Old.DATA_HORA                      , 'DD-MM-YYYY HH24:MI:SS') || ')' ; END IF;
  	if (nvl(:Old.EMITIDO                      ,'x'    ) != nvl(:New.EMITIDO                       ,'x'    )) Then v_Alterado := v_Alterado ||', EMITIDO ('                        || TO_CHAR(:New.EMITIDO                        ) 							||' / ' || TO_CHAR(:Old.EMITIDO                        ) || ')' ; END IF;
  	if (nvl(:Old.ENDSOCOS                     ,'x'    ) != nvl(:New.ENDSOCOS                      ,'x'    )) Then v_Alterado := v_Alterado ||', ENDSOCOS ('                       || TO_CHAR(:New.ENDSOCOS                       ) 							||' / ' || TO_CHAR(:Old.ENDSOCOS                       ) || ')' ; END IF;
  	if (nvl(:Old.EXECUCAO_MANU                ,'x'    ) != nvl(:New.EXECUCAO_MANU                 ,'x'    )) Then v_Alterado := v_Alterado ||', EXECUCAO_MANU ('                  || TO_CHAR(:New.EXECUCAO_MANU                  ) 							||' / ' || TO_CHAR(:Old.EXECUCAO_MANU                  ) || ')' ; END IF;
  	if (nvl(:Old.FECHAMENTO_MANU              ,'x'    ) != nvl(:New.FECHAMENTO_MANU               ,'x'    )) Then v_Alterado := v_Alterado ||', FECHAMENTO_MANU ('                || TO_CHAR(:New.FECHAMENTO_MANU                ) 							||' / ' || TO_CHAR(:Old.FECHAMENTO_MANU                ) || ')' ; END IF;
  	if (nvl(:Old.FUNC_PRAZOGARANTIA           ,0      ) != nvl(:New.FUNC_PRAZOGARANTIA            ,0      )) Then v_Alterado := v_Alterado ||', FUNC_PRAZOGARANTIA ('             || TO_CHAR(:New.FUNC_PRAZOGARANTIA             ) 							||' / ' || TO_CHAR(:Old.FUNC_PRAZOGARANTIA             ) || ')' ; END IF;
  	if (nvl(:Old.HORAABERTURAOS               ,sysdate) != nvl(:New.HORAABERTURAOS                ,sysdate)) Then v_Alterado := v_Alterado ||', HORAABERTURAOS ('                 || TO_CHAR(:New.HORAABERTURAOS                 , 'DD-MM-YYYY HH24:MI:SS') ||' / ' || TO_CHAR(:Old.HORAABERTURAOS                 , 'DD-MM-YYYY HH24:MI:SS') || ')' ; END IF;
  	if (nvl(:Old.HORAEMISSAOOS                ,sysdate) != nvl(:New.HORAEMISSAOOS                 ,sysdate)) Then v_Alterado := v_Alterado ||', HORAEMISSAOOS ('                  || TO_CHAR(:New.HORAEMISSAOOS                  , 'DD-MM-YYYY HH24:MI:SS') ||' / ' || TO_CHAR(:Old.HORAEMISSAOOS                  , 'DD-MM-YYYY HH24:MI:SS') || ')' ; END IF;
  	if (nvl(:Old.HORAENTREGA1                 ,sysdate) != nvl(:New.HORAENTREGA1                  ,sysdate)) Then v_Alterado := v_Alterado ||', HORAENTREGA1 ('                   || TO_CHAR(:New.HORAENTREGA1                   , 'DD-MM-YYYY HH24:MI:SS') ||' / ' || TO_CHAR(:Old.HORAENTREGA1                   , 'DD-MM-YYYY HH24:MI:SS') || ')' ; END IF;
  	if (nvl(:Old.HORAENTREGA2                 ,sysdate) != nvl(:New.HORAENTREGA2                  ,sysdate)) Then v_Alterado := v_Alterado ||', HORAENTREGA2 ('                   || TO_CHAR(:New.HORAENTREGA2                   , 'DD-MM-YYYY HH24:MI:SS') ||' / ' || TO_CHAR(:Old.HORAENTREGA2                   , 'DD-MM-YYYY HH24:MI:SS') || ')' ; END IF;
  	if (nvl(:Old.HORAFECHAMENTOOS             ,sysdate) != nvl(:New.HORAFECHAMENTOOS              ,sysdate)) Then v_Alterado := v_Alterado ||', HORAFECHAMENTOOS ('               || TO_CHAR(:New.HORAFECHAMENTOOS               , 'DD-MM-YYYY HH24:MI:SS') ||' / ' || TO_CHAR(:Old.HORAFECHAMENTOOS               , 'DD-MM-YYYY HH24:MI:SS') || ')' ; END IF;
  	if (nvl(:Old.HORARETORNOPROGRAMADO        ,sysdate) != nvl(:New.HORARETORNOPROGRAMADO         ,sysdate)) Then v_Alterado := v_Alterado ||', HORARETORNOPROGRAMADO ('          || TO_CHAR(:New.HORARETORNOPROGRAMADO          , 'DD-MM-YYYY HH24:MI:SS') ||' / ' || TO_CHAR(:Old.HORARETORNOPROGRAMADO          , 'DD-MM-YYYY HH24:MI:SS') || ')' ; END IF;
  	if (nvl(:Old.KMEXECUCAOOS                 ,0      ) != nvl(:New.KMEXECUCAOOS                  ,0      )) Then v_Alterado := v_Alterado ||', KMEXECUCAOOS ('                   || TO_CHAR(:New.KMEXECUCAOOS                   ) 							||' / ' || TO_CHAR(:Old.KMEXECUCAOOS                   ) || ')' ; END IF;
  	if (nvl(:Old.MEDIDA_FREIO                 ,0      ) != nvl(:New.MEDIDA_FREIO                  ,0      )) Then v_Alterado := v_Alterado ||', MEDIDA_FREIO ('                   || TO_CHAR(:New.MEDIDA_FREIO                   ) 							||' / ' || TO_CHAR(:Old.MEDIDA_FREIO                   ) || ')' ; END IF;
  	if (nvl(:Old.MOTIVOCANCELAMENTOOS         ,'x'    ) != nvl(:New.MOTIVOCANCELAMENTOOS          ,'x'    )) Then v_Alterado := v_Alterado ||', MOTIVOCANCELAMENTOOS ('           || TO_CHAR(:New.MOTIVOCANCELAMENTOOS           ) 							||' / ' || TO_CHAR(:Old.MOTIVOCANCELAMENTOOS           ) || ')' ; END IF;
  	if (nvl(:Old.NROPLANO                     ,0      ) != nvl(:New.NROPLANO                      ,0      )) Then v_Alterado := v_Alterado ||', NROPLANO ('                       || TO_CHAR(:New.NROPLANO                       ) 							||' / ' || TO_CHAR(:Old.NROPLANO                       ) || ')' ; END IF;
  	if (nvl(:Old.NUMEROOS                     ,0      ) != nvl(:New.NUMEROOS                      ,0      )) Then v_Alterado := v_Alterado ||', NUMEROOS ('                       || TO_CHAR(:New.NUMEROOS                       ) 							||' / ' || TO_CHAR(:Old.NUMEROOS                       ) || ')' ; END IF;
  	if (nvl(:Old.NUMSETORESGERADOOS           ,0      ) != nvl(:New.NUMSETORESGERADOOS            ,0      )) Then v_Alterado := v_Alterado ||', NUMSETORESGERADOOS ('             || TO_CHAR(:New.NUMSETORESGERADOOS             ) 							||' / ' || TO_CHAR(:Old.NUMSETORESGERADOOS             ) || ')' ; END IF;
  	if (nvl(:Old.OBSERVACAOOS                 ,'x'    ) != nvl(:New.OBSERVACAOOS                  ,'x'    )) Then v_Alterado := v_Alterado ||', OBSERVACAOOS ('                   || TO_CHAR(:New.OBSERVACAOOS                   ) 							||' / ' || TO_CHAR(:Old.OBSERVACAOOS                   ) || ')' ; END IF;
  	if (nvl(:Old.OSABERTAWSTERCEIRO           ,'x'    ) != nvl(:New.OSABERTAWSTERCEIRO            ,'x'    )) Then v_Alterado := v_Alterado ||', OSABERTAWSTERCEIRO ('             || TO_CHAR(:New.OSABERTAWSTERCEIRO             ) 							||' / ' || TO_CHAR(:Old.OSABERTAWSTERCEIRO             ) || ')' ; END IF;
  	if (nvl(:Old.OSBLOQUEADA                  ,'x'    ) != nvl(:New.OSBLOQUEADA                   ,'x'    )) Then v_Alterado := v_Alterado ||', OSBLOQUEADA ('                    || TO_CHAR(:New.OSBLOQUEADA                    ) 							||' / ' || TO_CHAR(:Old.OSBLOQUEADA                    ) || ')' ; END IF;
  	if (nvl(:Old.OSJAIMPRESSAAUTO             ,'x'    ) != nvl(:New.OSJAIMPRESSAAUTO              ,'x'    )) Then v_Alterado := v_Alterado ||', OSJAIMPRESSAAUTO ('               || TO_CHAR(:New.OSJAIMPRESSAAUTO               ) 							||' / ' || TO_CHAR(:Old.OSJAIMPRESSAAUTO               ) || ')' ; END IF;
  	if (nvl(:Old.OSPARAFECHAMENTOPN           ,'x'    ) != nvl(:New.OSPARAFECHAMENTOPN            ,'x'    )) Then v_Alterado := v_Alterado ||', OSPARAFECHAMENTOPN ('             || TO_CHAR(:New.OSPARAFECHAMENTOPN             ) 							||' / ' || TO_CHAR(:Old.OSPARAFECHAMENTOPN             ) || ')' ; END IF;
  	if (nvl(:Old.OS_FECH_PROLOG               ,'x'    ) != nvl(:New.OS_FECH_PROLOG                ,'x'    )) Then v_Alterado := v_Alterado ||', OS_FECH_PROLOG ('                 || TO_CHAR(:New.OS_FECH_PROLOG                 ) 							||' / ' || TO_CHAR(:Old.OS_FECH_PROLOG                 ) || ')' ; END IF;
  	if (nvl(:Old.OS_GRAV_PROLOG               ,'x'    ) != nvl(:New.OS_GRAV_PROLOG                ,'x'    )) Then v_Alterado := v_Alterado ||', OS_GRAV_PROLOG ('                 || TO_CHAR(:New.OS_GRAV_PROLOG                 ) 							||' / ' || TO_CHAR(:Old.OS_GRAV_PROLOG                 ) || ')' ; END IF;
  	if (nvl(:Old.OS_PROLOG                    ,'x'    ) != nvl(:New.OS_PROLOG                     ,'x'    )) Then v_Alterado := v_Alterado ||', OS_PROLOG ('                      || TO_CHAR(:New.OS_PROLOG                      ) 							||' / ' || TO_CHAR(:Old.OS_PROLOG                      ) || ')' ; END IF;
  	if (nvl(:Old.PARTNER                      ,'x'    ) != nvl(:New.PARTNER                       ,'x'    )) Then v_Alterado := v_Alterado ||', PARTNER ('                        || TO_CHAR(:New.PARTNER                        ) 							||' / ' || TO_CHAR(:Old.PARTNER                        ) || ')' ; END IF;
  	if (nvl(:Old.PRAZOENTREGA1                ,sysdate) != nvl(:New.PRAZOENTREGA1                 ,sysdate)) Then v_Alterado := v_Alterado ||', PRAZOENTREGA1 ('                  || TO_CHAR(:New.PRAZOENTREGA1                  , 'DD-MM-YYYY HH24:MI:SS') ||' / ' || TO_CHAR(:Old.PRAZOENTREGA1                  , 'DD-MM-YYYY HH24:MI:SS') || ')' ; END IF;
  	if (nvl(:Old.PRAZOENTREGA2                ,sysdate) != nvl(:New.PRAZOENTREGA2                 ,sysdate)) Then v_Alterado := v_Alterado ||', PRAZOENTREGA2 ('                  || TO_CHAR(:New.PRAZOENTREGA2                  , 'DD-MM-YYYY HH24:MI:SS') ||' / ' || TO_CHAR(:Old.PRAZOENTREGA2                  , 'DD-MM-YYYY HH24:MI:SS') || ')' ; END IF;
  	if (nvl(:Old.SERVICOINTEXTOS              ,'x'    ) != nvl(:New.SERVICOINTEXTOS               ,'x'    )) Then v_Alterado := v_Alterado ||', SERVICOINTEXTOS ('                || TO_CHAR(:New.SERVICOINTEXTOS                ) 							||' / ' || TO_CHAR(:Old.SERVICOINTEXTOS                ) || ')' ; END IF;
  	if (nvl(:Old.SOCORROOS                    ,'x'    ) != nvl(:New.SOCORROOS                     ,'x'    )) Then v_Alterado := v_Alterado ||', SOCORROOS ('                      || TO_CHAR(:New.SOCORROOS                      ) 							||' / ' || TO_CHAR(:Old.SOCORROOS                      ) || ')' ; END IF;
  	if (nvl(:Old.TIPOCONTROLEOS               ,'x'    ) != nvl(:New.TIPOCONTROLEOS                ,'x'    )) Then v_Alterado := v_Alterado ||', TIPOCONTROLEOS ('                 || TO_CHAR(:New.TIPOCONTROLEOS                 ) 							||' / ' || TO_CHAR(:Old.TIPOCONTROLEOS                 ) || ')' ; END IF;
  	if (nvl(:Old.TIPOOS                       ,'x'    ) != nvl(:New.TIPOOS                        ,'x'    )) Then v_Alterado := v_Alterado ||', TIPOOS ('                         || TO_CHAR(:New.TIPOOS                         ) 							||' / ' || TO_CHAR(:Old.TIPOOS                         ) || ')' ; END IF;
  	if (nvl(:Old.TIPOSERVICOOSMOTCPN          ,'x'    ) != nvl(:New.TIPOSERVICOOSMOTCPN           ,'x'    )) Then v_Alterado := v_Alterado ||', TIPOSERVICOOSMOTCPN ('            || TO_CHAR(:New.TIPOSERVICOOSMOTCPN            ) 							||' / ' || TO_CHAR(:Old.TIPOSERVICOOSMOTCPN            ) || ')' ; END IF;
  	if (nvl(:Old.USUARIO                      ,'x'    ) != nvl(:New.USUARIO                       ,'x'    )) Then v_Alterado := v_Alterado ||', USUARIO ('                        || TO_CHAR(:New.USUARIO                        ) 							||' / ' || TO_CHAR(:Old.USUARIO                        ) || ')' ; END IF;
  	if (nvl(:Old.USUARIOABERTURAOS            ,'x'    ) != nvl(:New.USUARIOABERTURAOS             ,'x'    )) Then v_Alterado := v_Alterado ||', USUARIOABERTURAOS ('              || TO_CHAR(:New.USUARIOABERTURAOS              ) 							||' / ' || TO_CHAR(:Old.USUARIOABERTURAOS              ) || ')' ; END IF;
  	if (nvl(:Old.USUARIOCANCELAMENTOOS        ,'x'    ) != nvl(:New.USUARIOCANCELAMENTOOS         ,'x'    )) Then v_Alterado := v_Alterado ||', USUARIOCANCELAMENTOOS ('          || TO_CHAR(:New.USUARIOCANCELAMENTOOS          ) 							||' / ' || TO_CHAR(:Old.USUARIOCANCELAMENTOOS          ) || ')' ; END IF;
  	if (nvl(:Old.USUARIOFECHAMENTOOS          ,'x'    ) != nvl(:New.USUARIOFECHAMENTOOS           ,'x'    )) Then v_Alterado := v_Alterado ||', USUARIOFECHAMENTOOS ('            || TO_CHAR(:New.USUARIOFECHAMENTOOS            ) 							||' / ' || TO_CHAR(:Old.USUARIOFECHAMENTOOS            ) || ')' ; END IF;
  	if (nvl(:Old.VLRMAOOBRATERCOS             ,0      ) != nvl(:New.VLRMAOOBRATERCOS              ,0      )) Then v_Alterado := v_Alterado ||', VLRMAOOBRATERCOS ('               || TO_CHAR(:New.VLRMAOOBRATERCOS               ) 							||' / ' || TO_CHAR(:Old.VLRMAOOBRATERCOS               ) || ')' ; END IF;
  	if (nvl(:Old.VLRPECASTERCOS               ,0      ) != nvl(:New.VLRPECASTERCOS                ,0      )) Then v_Alterado := v_Alterado ||', VLRPECASTERCOS ('                 || TO_CHAR(:New.VLRPECASTERCOS                 ) 							||' / ' || TO_CHAR(:Old.VLRPECASTERCOS                 ) || ')' ; END IF;
  Exception
  	When Others Then
  		v_Alterado := v_Alterado ||', ERRO: '|| Sqlerrm;
  End;   

  v_Json := '''codintos'': "' || (Case When Deleting Then :Old.CODINTOS Else :New.CODINTOS End) || '", ' ||  
   '''Operacao'': "' || Operacao   || '",' || 
   '''Alterado'': "' || v_Alterado || '"';

  Pr_Manu_Insert_Json_2('MAN_OS', v_Json); 
End TR_Manu_OS;
/

Create Or Replace Trigger TR_Manu_OSPREVISTO_2
  After Insert Or Update Or Delete On MAN_OSPREVISTO
  For Each Row
Declare
  v_Json   		Varchar2(4000);
  v_Alterado    Varchar2(4000);
  Operacao 		INTEGER;
Begin
  IF Inserting THEN
    Operacao := 0;
  ELSIF Updating THEN
    Operacao := 1;
  ELSE
    Operacao := 2;
  END IF;

  Begin
		if (nvl(:Old.DATACANCELAMENTOOS ,sysdate)    != nvl(:New.DATACANCELAMENTOOS ,sysdate))    Then v_Alterado := v_Alterado ||', DATACANCELAMENTOOS ('       || TO_CHAR(:New.DATACANCELAMENTOOS , 'DD-MM-YYYY HH24:MI:SS') ||' / ' || TO_CHAR(:Old.DATACANCELAMENTOOS , 'DD-MM-YYYY HH24:MI:SS') || ')' ; END IF;
		if (nvl(:Old.CODINTFUNC ,0 )                 != nvl(:New.CODINTFUNC ,0 ))                 Then v_Alterado := v_Alterado ||', CODINTFUNC ('               || TO_CHAR(:New.CODINTFUNC )                                  ||' / ' || TO_CHAR(:Old.CODINTFUNC )                                  || ')' ; END IF;
		if (nvl(:Old.CODINTOS ,0 )                   != nvl(:New.CODINTOS ,0 ))                   Then v_Alterado := v_Alterado ||', CODINTOS ('                 || TO_CHAR(:New.CODINTOS )                                    ||' / ' || TO_CHAR(:Old.CODINTOS )                                    || ')' ; END IF;
		if (nvl(:Old.CODINTPROAUT ,0 )               != nvl(:New.CODINTPROAUT ,0 ))               Then v_Alterado := v_Alterado ||', CODINTPROAUT ('             || TO_CHAR(:New.CODINTPROAUT )                                ||' / ' || TO_CHAR(:Old.CODINTPROAUT )                                || ')' ; END IF;
		if (nvl(:Old.CODIGOCADSERVI ,0 )             != nvl(:New.CODIGOCADSERVI ,0 ))             Then v_Alterado := v_Alterado ||', CODIGOCADSERVI ('           || TO_CHAR(:New.CODIGOCADSERVI )                              ||' / ' || TO_CHAR(:Old.CODIGOCADSERVI )                              || ')' ; END IF;
		if (nvl(:Old.CODIGODEFEITO ,0 )              != nvl(:New.CODIGODEFEITO ,0 ))              Then v_Alterado := v_Alterado ||', CODIGODEFEITO ('            || TO_CHAR(:New.CODIGODEFEITO )                               ||' / ' || TO_CHAR(:Old.CODIGODEFEITO )                               || ')' ; END IF;
		if (nvl(:Old.CODIGOGRPDEFEITO ,0 )           != nvl(:New.CODIGOGRPDEFEITO ,0 ))           Then v_Alterado := v_Alterado ||', CODIGOGRPDEFEITO ('         || TO_CHAR(:New.CODIGOGRPDEFEITO )                            ||' / ' || TO_CHAR(:Old.CODIGOGRPDEFEITO )                            || ')' ; END IF;
		if (nvl(:Old.CODIGOGRPSERVI ,0 )             != nvl(:New.CODIGOGRPSERVI ,0 ))             Then v_Alterado := v_Alterado ||', CODIGOGRPSERVI ('           || TO_CHAR(:New.CODIGOGRPSERVI )                              ||' / ' || TO_CHAR(:Old.CODIGOGRPSERVI )                              || ')' ; END IF;
		if (nvl(:Old.CODIGOPLANREV ,0 )              != nvl(:New.CODIGOPLANREV ,0 ))              Then v_Alterado := v_Alterado ||', CODIGOPLANREV ('            || TO_CHAR(:New.CODIGOPLANREV )                               ||' / ' || TO_CHAR(:Old.CODIGOPLANREV )                               || ')' ; END IF;
		if (nvl(:Old.CODIGOSUPERVISAO ,0 )           != nvl(:New.CODIGOSUPERVISAO ,0 ))           Then v_Alterado := v_Alterado ||', CODIGOSUPERVISAO ('         || TO_CHAR(:New.CODIGOSUPERVISAO )                            ||' / ' || TO_CHAR(:Old.CODIGOSUPERVISAO )                            || ')' ; END IF;
		if (nvl(:Old.CODIGOTPOPERSERVI ,0 )          != nvl(:New.CODIGOTPOPERSERVI ,0 ))          Then v_Alterado := v_Alterado ||', CODIGOTPOPERSERVI ('        || TO_CHAR(:New.CODIGOTPOPERSERVI )                           ||' / ' || TO_CHAR(:Old.CODIGOTPOPERSERVI )                           || ')' ; END IF;
		if (nvl(:Old.CODIGO_SOLUCAO ,0 )             != nvl(:New.CODIGO_SOLUCAO ,0 ))             Then v_Alterado := v_Alterado ||', CODIGO_SOLUCAO ('           || TO_CHAR(:New.CODIGO_SOLUCAO )                              ||' / ' || TO_CHAR(:Old.CODIGO_SOLUCAO )                              || ')' ; END IF;
		if (nvl(:Old.CODORIGOS ,0 )                  != nvl(:New.CODORIGOS ,0 ))                  Then v_Alterado := v_Alterado ||', CODORIGOS ('                || TO_CHAR(:New.CODORIGOS )                                   ||' / ' || TO_CHAR(:Old.CODORIGOS )                                   || ')' ; END IF;
		if (nvl(:Old.QTDEEXECSERV ,0 )               != nvl(:New.QTDEEXECSERV ,0 ))               Then v_Alterado := v_Alterado ||', QTDEEXECSERV ('             || TO_CHAR(:New.QTDEEXECSERV )                                ||' / ' || TO_CHAR(:Old.QTDEEXECSERV )                                || ')' ; END IF;
		if (nvl(:Old.CODSETOR ,0 )                   != nvl(:New.CODSETOR ,0 ))                   Then v_Alterado := v_Alterado ||', CODSETOR ('                 || TO_CHAR(:New.CODSETOR )                                    ||' / ' || TO_CHAR(:Old.CODSETOR )                                    || ')' ; END IF;
		if (nvl(:Old.SEQSERVOSPREV ,0 )              != nvl(:New.SEQSERVOSPREV ,0 ))              Then v_Alterado := v_Alterado ||', SEQSERVOSPREV ('            || TO_CHAR(:New.SEQSERVOSPREV )                               ||' / ' || TO_CHAR(:Old.SEQSERVOSPREV )                               || ')' ; END IF;
		if (nvl(:Old.KMCOMPONENTEOSPREV ,0 )         != nvl(:New.KMCOMPONENTEOSPREV ,0 ))         Then v_Alterado := v_Alterado ||', KMCOMPONENTEOSPREV ('       || TO_CHAR(:New.KMCOMPONENTEOSPREV )                          ||' / ' || TO_CHAR(:Old.KMCOMPONENTEOSPREV )                          || ')' ; END IF;
		if (nvl(:Old.NUMORIGEMOSPREV ,0 )            != nvl(:New.NUMORIGEMOSPREV ,0 ))            Then v_Alterado := v_Alterado ||', NUMORIGEMOSPREV ('          || TO_CHAR(:New.NUMORIGEMOSPREV )                             ||' / ' || TO_CHAR(:Old.NUMORIGEMOSPREV )                             || ')' ; END IF;
		if (nvl(:Old.CRIADOMANU ,'x' )               != nvl(:New.CRIADOMANU ,'x' ))               Then v_Alterado := v_Alterado ||', CRIADOMANU ('               || TO_CHAR(:New.CRIADOMANU )                                  ||' / ' || TO_CHAR(:Old.CRIADOMANU )                                  || ')' ; END IF;
		if (nvl(:Old.DEFEITOLIBERADO ,'x' )          != nvl(:New.DEFEITOLIBERADO ,'x' ))          Then v_Alterado := v_Alterado ||', DEFEITOLIBERADO ('          || TO_CHAR(:New.DEFEITOLIBERADO )                             ||' / ' || TO_CHAR(:Old.DEFEITOLIBERADO )                             || ')' ; END IF;
		if (nvl(:Old.DEFPENDENTE ,'x' )              != nvl(:New.DEFPENDENTE ,'x' ))              Then v_Alterado := v_Alterado ||', DEFPENDENTE ('              || TO_CHAR(:New.DEFPENDENTE )                                 ||' / ' || TO_CHAR(:Old.DEFPENDENTE )                                 || ')' ; END IF;
		if (nvl(:Old.DEFREPETIDO ,'x' )              != nvl(:New.DEFREPETIDO ,'x' ))              Then v_Alterado := v_Alterado ||', DEFREPETIDO ('              || TO_CHAR(:New.DEFREPETIDO )                                 ||' / ' || TO_CHAR(:Old.DEFREPETIDO )                                 || ')' ; END IF;
		if (nvl(:Old.SERVDEFPARCIALFINALIZADO ,'x' ) != nvl(:New.SERVDEFPARCIALFINALIZADO ,'x' )) Then v_Alterado := v_Alterado ||', SERVDEFPARCIALFINALIZADO('  || TO_CHAR(:New.SERVDEFPARCIALFINALIZADO)                     ||' / ' || TO_CHAR(:Old.SERVDEFPARCIALFINALIZADO)                     || ')' ; END IF;
		if (nvl(:Old.SITUACAODEFEITO ,'x' )          != nvl(:New.SITUACAODEFEITO ,'x' ))          Then v_Alterado := v_Alterado ||', SITUACAODEFEITO ('          || TO_CHAR(:New.SITUACAODEFEITO )                             ||' / ' || TO_CHAR(:Old.SITUACAODEFEITO )                             || ')' ; END IF;
		if (nvl(:Old.USUARIOCANCELAMENTOOS ,'x' )    != nvl(:New.USUARIOCANCELAMENTOOS ,'x' ))    Then v_Alterado := v_Alterado ||', USUARIOCANCELAMENTOOS ('    || TO_CHAR(:New.USUARIOCANCELAMENTOOS )                       ||' / ' || TO_CHAR(:Old.USUARIOCANCELAMENTOOS )                       || ')' ; END IF;
		if (nvl(:Old.EXECUTADOOSPREV ,'x' )          != nvl(:New.EXECUTADOOSPREV ,'x' ))          Then v_Alterado := v_Alterado ||', EXECUTADOOSPREV ('          || TO_CHAR(:New.EXECUTADOOSPREV )                             ||' / ' || TO_CHAR(:Old.EXECUTADOOSPREV )                             || ')' ; END IF;
		if (nvl(:Old.COMPLEMENTODEFEITO ,'x' )       != nvl(:New.COMPLEMENTODEFEITO ,'x' ))       Then v_Alterado := v_Alterado ||', COMPLEMENTODEFEITO ('       || TO_CHAR(:New.COMPLEMENTODEFEITO )                          ||' / ' || TO_CHAR(:Old.COMPLEMENTODEFEITO )                          || ')' ; END IF;
		if (nvl(:Old.DESCRCOMPLOSPREV ,'x' )         != nvl(:New.DESCRCOMPLOSPREV ,'x' ))         Then v_Alterado := v_Alterado ||', DESCRCOMPLOSPREV ('         || TO_CHAR(:New.DESCRCOMPLOSPREV )                            ||' / ' || TO_CHAR(:Old.DESCRCOMPLOSPREV )                            || ')' ; END IF;
		if (nvl(:Old.MOTIVOCANCELAMENTOOS ,'x' )     != nvl(:New.MOTIVOCANCELAMENTOOS ,'x' ))     Then v_Alterado := v_Alterado ||', MOTIVOCANCELAMENTOOS ('     || TO_CHAR(:New.MOTIVOCANCELAMENTOOS )                        ||' / ' || TO_CHAR(:Old.MOTIVOCANCELAMENTOOS )                        || ')' ; END IF;
  Exception
  	When Others Then
  		v_Alterado := v_Alterado ||', ERRO: '|| Sqlerrm;
  End;

  v_Json := '''codintos'': "' || (Case When Deleting Then :Old.CODINTOS Else :New.CODINTOS End) || '", ' ||
   '''Operacao'': "' || Operacao   || '",' ||
   '''Alterado'': "' || v_Alterado || '"';

  Pr_Manu_Insert_Json_2('MAN_OS_PREVISTO', v_Json);
End TR_Manu_OSPREVISTO_2;
/