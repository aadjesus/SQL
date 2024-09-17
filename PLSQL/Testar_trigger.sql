CREATE OR REPLACE PROCEDURE Testar_Trigger is 
Begin
     begin
     Dbms_Output.Put_Line('xxxx - inicio ');
     update BGM_APROVEME set DATA_APROVACAO=sysdate, STATUS_APROVACAO='R', SISTEMA_APROVADOR='APROVE_ME', USUARIO_APROVADOR='ISADORA', ID_EXTERNO_MOTIVO='0xCCBF27CCC96711ACE053050010ACA1D2', 
     JUSTIFICATIVAREPROVACAO=  'A requisição foi reprovada em lote.'
     where ID_EXTERNO= 'CD8AB68533A9404FE053050010AC8171';
     Dbms_Output.Put_Line('xxxx - fim ');
     
     EXCEPTION
				WHEN OTHERS THEN
          Dbms_Output.Put_Line('xxxx - erro ');
					Dbms_Output.Put_Line( SQLERRM);
			END;


End; -- Testar_Trigger


