CREATE OR REPLACE TRIGGER TR_MTK_ATUALIZAR_TICKET
		BEFORE UPDATE ON SII_SAS
		FOR EACH ROW
DECLARE
	   Pragma Autonomous_Transaction;
       PROCEDURE ATUALIZAR_TICKET(
								p_Id MTK_TICKET.ID%TYPE, 
								p_Id_Operador_Responsavel MTK_TICKET.ID_OPERADOR%TYPE, 
								p_Id_Operador_Contato MTK_TICKET.ID_OPERADOR_CONTATO%TYPE, 
								p_StatusSas SII_SAS.STATUSSAS%TYPE,
								p_OldStatusSas SII_SAS.STATUSSAS%TYPE) IS
								v_Status MTK_TICKET.Status%TYPE;
								v_Descricao MTK_TRAMITE.Descricao%TYPE;
								v_DescricaoNotificacao MTK_NOTIFICACAO.DESCRICAO%TYPE;
								v_TipoNotificacao MTK_NOTIFICACAO.TIPO%TYPE;
								v_qtd_sas_nao_finalizadas NUMBER(8);
								v_qtd_sas_nao_aprovadas NUMBER(8);
                v_Privado MTK_TRAMITE.Privado%TYPE;
				v_NomeAnalista MTK_OPERADOR.NOME%TYPE;
				v_Id_Operador_Notificacao MTK_TICKET.ID_OPERADOR%TYPE;
				V_INCLUIR_ANEXO           BOOLEAN;
				V_ID_TRAMITE              MTK_TRAMITE.ID%TYPE;
				vTipoAtualizacao          VARCHAR2(15);
  
				CURSOR ANEXOS IS
				  SELECT A.DOCTO_ANEXO, A.ARQUIVO_ANEXO
					FROM SII_SAS_VIDEOS A
                   WHERE A.TIPOSASSIM = :NEW.TIPOSASSIM
                     AND A.CODIGOSAS = :NEW.CODIGOSAS
                     AND A.TIPO_DOCTO = 2;
                C_ANEXOS ANEXOS% ROWTYPE;

       BEGIN
            v_Privado := 'N';
			v_NomeAnalista := '';
			V_INCLUIR_ANEXO := FALSE;	
            
            IF p_StatusSas = '98' THEN --Pré Cad. - Cliente
               v_Status := 4; --Pendente cliente
               v_Descricao := '<div>Prezado cliente.</div><div><br></div><div>Informamos que o PSE n° ' || TO_CHAR(:New.Codigosas) || ' está <b>aguardando o seu detalhamento</b> para que possamos dar andamento ao processo de adequação.</div><div>Para fazer o detalhamento e a liberação do PSE para Praxio, favor acessar o PSE online, através do endereço: http://bgmrodotec.com.br/pseonline/</div><div><br></div><div>Atencionsamente.</div><div><br></div><div>Praxio - Direções conectadas ao futuro</div>';
               v_DescricaoNotificacao := 'Ticket atualizado';
               v_TipoNotificacao := 3;
			   v_Id_Operador_Notificacao := p_Id_Operador_Contato;
               
            ELSIF p_StatusSas = '03' THEN --Ag. Aprovação do orçamento
               v_Status := 4; --Pendente cliente
               v_Descricao := '<div>Prezado cliente.</div><div><br></div><div>Salientamos que o PSE n° ' || TO_CHAR(:New.Codigosas) || ' encontra-se <b>aguardando aprovação de orçamento</b>.</div><div>Caso não tenha recebido a proposta comercial, pedimos a gentileza de entrar em contato com a Samantha Silva (samantha.silva@praxio.com.br) do setor comercial.</div><div><br></div><div>Atenciosamente.</div><div><br></div><div>Praxio - Direções conectadas ao futuro</div>';
               v_DescricaoNotificacao := 'Ticket atualizado';
               v_TipoNotificacao := 3;
			   v_Id_Operador_Notificacao := p_Id_Operador_Contato;
               
            ELSIF p_StatusSas = '12' THEN --Entregue ao Cliente

                  --Calcular se alguma adequação ainda nao foi entregue ao cliente
                  BEGIN
                  SELECT 
                         COUNT(*) INTO v_qtd_sas_nao_finalizadas
                  FROM MTK_TICKET T   
                  INNER JOIN MTK_TICKET_SAS TS ON
                  TS.ID_TICKET = T.ID  
                  INNER JOIN SII_SAS S ON
				  S.Codigosas = TS.Codigo_Sas AND
                  S.Tiposassim = TS.TIPO_SAS_SIM  
                  WHERE T.ID = p_Id AND S.Statussas <> '12' and 
                  (S.Codigosas || S.Tiposassim <> :New.Codigosas || :New.Tiposassim );
                  END;

				  vTipoAtualizacao := '';
                  IF (:NEW.TP_ATUALIZACAO = 'C') THEN
                    vTipoAtualizacao := '(COMPLETA)';
                  ELSE
                    vTipoAtualizacao := '(PARCIAL)';
				  END IF;

				  IF (v_qtd_sas_nao_finalizadas > 0 ) THEN --Nem todas as adequações foram entregues
    					v_Status := 5; --Aguardando Adequação
						V_DESCRICAO := '<div>Prezado cliente.</div><div><br></div><div>Informamos que a adequação n° ' || TO_CHAR(:NEW.CODIGOSAS) ||
                                     ' foi entregue. Favor efetuar a atualização ' || vTipoAtualizacao ||
                                     ' e realizar os testes.</div><div>Caso o seu ambiente Globus esteja hospedado no Cloud, pedimos para contatar o nosso setor de TI para combinarem o melhor horário para que a nossa equipe possa realizar essa atualização.</div><div>A(s) demais adequações associadas a esse ticket serão entregues em breve.</div><div><br></div><div>Atenciosamente.</div><div><br></div><div>Praxio - Direções conectadas ao futuro</div>';
    					v_DescricaoNotificacao := 'Ticket atualizado';
						v_TipoNotificacao := 3;
						v_Id_Operador_Notificacao := p_Id_Operador_Contato;
						V_INCLUIR_ANEXO           := TRUE;
				  ELSIF (v_qtd_sas_nao_finalizadas = 0 ) THEN --Se todas as adequações foram entregues
      					 --Se todas as adequações foram entregues
			      		 --v_Status := 4; --Pendente cliente
						 V_STATUS                  := 4; --Pendente cliente
						 V_DESCRICAO               := '<div>Prezado cliente.</div><div><br></div><div>Informamos que a adequação nº ' ||
						    						 TO_CHAR(:NEW.CODIGOSAS) ||
													 ' foi entregue. Favor efetuar a atualização '||vTipoAtualizacao||' e realizar os testes.</div><div>O ticket permanecerá aberto por mais alguns dias. Aguardamos o seu feedback sobre o resultado do teste.</div><div>Caso o seu ambiente Globus esteja hospedado no Cloud, pedimos para contatar o nosso setor de TI para combinarem o melhor horário para que a nossa equipe possa realizar essa atualização.</div><div><br></div><div>Atenciosamente.</div><div><br></div><div>Praxio - Direções conectadas ao futuro</div>';
						 V_DESCRICAONOTIFICACAO    := 'Ticket atualizado';
						 V_TIPONOTIFICACAO         := 3;
						 V_ID_OPERADOR_NOTIFICACAO := P_ID_OPERADOR_CONTATO;
						 V_INCLUIR_ANEXO           := TRUE;
    		      END IF;

			ELSIF p_StatusSas = '04' THEN --Cancelado
               
				Begin
					Select Nome
					Into v_NomeAnalista
					From MTK_OPERADOR
					Where Id = p_Id_Operador_Responsavel;
				Exception
					When Others Then
							v_NomeAnalista := 'analista';
				End;
			   
			   v_Status := 3; --Em andamento
               v_Descricao := '<div>Prezado(a) ' || v_NomeAnalista ||'.</div><div><br></div><div>Informamos que a adequação n° ' || TO_CHAR(:New.Codigosas) || ' foi cancelada. Favor avaliar que ação deve ser tomada para conclusão deste atendimento.</div><div><br></div><div>Atenciosamente.</div><div><br></div><div>Praxio - Direções conectadas ao futuro</div>';
               v_DescricaoNotificacao := 'Ticket atualizado';
               v_TipoNotificacao := 3;
               v_Privado := 'S';
			   v_Id_Operador_Notificacao := p_Id_Operador_Responsavel;

			   --03 - Aguardando aprovação de orçamento.
			   --05 - Cronograma (quando o orçamento é aprovado).
			ELSIF p_StatusSas = '05' AND p_OldStatusSas = '03' THEN
				Begin
					Select Nome
					Into v_NomeAnalista
					From MTK_OPERADOR
					Where Id = p_Id_Operador_Responsavel;
				Exception
					When Others Then
							v_NomeAnalista := 'analista';
				End;
			               
				--Calcular se alguma adequação ainda nao foi aprovado pelo cliente cliente
                BEGIN
                  SELECT 
                         COUNT(*) INTO v_qtd_sas_nao_aprovadas
                  FROM MTK_TICKET T   
                  INNER JOIN MTK_TICKET_SAS TS ON
                  TS.ID_TICKET = T.ID  
                  INNER JOIN SII_SAS S ON
				  S.Codigosas = TS.Codigo_Sas AND
                  S.Tiposassim = TS.TIPO_SAS_SIM  
                  WHERE T.ID = p_Id AND S.Statussas = '03' and 
                  (S.Codigosas || S.Tiposassim <> :New.Codigosas || :New.Tiposassim );
               END;   

			   IF (v_qtd_sas_nao_aprovadas > 0 ) THEN --Nem todas as adequações foram aprovadas
    				v_Status := 4; --Pendente Cliente
					v_Descricao := '<div>Prezado(a) cliente.</div><div><br></div><div>Informamos que a adequação n° ' || TO_CHAR(:New.Codigosas) || ', foi aprovada. Esse ticket permanecerá com o status "Pendente cliente" até que o orçamento de todos os PSEs sejam aprovados. </div><div><br></div><div>Atenciosamente.</div><div><br></div><div>Praxio - Direções conectadas ao futuro</div>';
    				v_DescricaoNotificacao := 'Ticket atualizado';
      				v_TipoNotificacao := 3;
					v_Privado := 'N';
					v_Id_Operador_Notificacao := p_Id_Operador_Responsavel;
			   ELSIF (v_qtd_sas_nao_aprovadas = 0 ) THEN --Se todas as adequações foram aprovadas
      				v_Status := 5; --Aguardando Adequação
					v_Descricao := '<div>Prezado(a) cliente.</div><div><br></div><div>Informamos que a adequação n° ' || TO_CHAR(:New.Codigosas) || ', foi aprovada. Esse ticket permanecerá com o status "Aguardando adequação" até que o PSE seja entregue. </div><div><br></div><div>Atenciosamente.</div><div><br></div><div>Praxio - Direções conectadas ao futuro</div>';
					v_DescricaoNotificacao := 'Ticket atualizado';
      				v_TipoNotificacao := 3;
					v_Privado := 'N';
					v_Id_Operador_Notificacao := p_Id_Operador_Responsavel;
			   END IF;                 
               
            END IF;       
        
    		UPDATE MTK_TICKET
    			SET Status = v_Status 
    		WHERE Id = p_Id;
    		
			V_ID_TRAMITE := SEQ_MTK_TRAMITE.NEXTVAL;

            --Inserindo o trâmite
            INSERT INTO MTK_TRAMITE
                   (Id,
                    Descricao,
                    Data_Hora,
                    Privado,
                    Id_Ticket,
                    Id_Operador,
                    Status_Atual, 
                    Escalado_N2)
            VALUES
                   (V_ID_TRAMITE,
                    v_Descricao,
                    SYSDATE,
                    v_Privado,
                    p_Id,
                    null,
                    v_Status,
                    'N');
              
			IF (NVL(v_Id_Operador_Notificacao, 0) <> 0 ) THEN
				--Notificação exibida ao logar 
				INSERT INTO MTK_NOTIFICACAO 
					   (Id,
						Descricao,
						Id_Ticket,
						Id_Operador,
						Tipo,
						Transporte,
						Lido)
				VALUES
					   (SEQ_MTK_NOTIFICACAO.Nextval,
						v_DescricaoNotificacao,
						p_Id,
						v_Id_Operador_Notificacao,
						v_TipoNotificacao,
						2,
						0); 
                      
				--Notificação a ser enviada por e-mail 
				INSERT INTO MTK_NOTIFICACAO 
					   (Id,
						Descricao,
						Id_Ticket,
						Id_Operador,
						Tipo,
						Transporte,
						Lido)
				VALUES
					   (SEQ_MTK_NOTIFICACAO.Nextval,
						v_DescricaoNotificacao,
						p_Id,
						v_Id_Operador_Notificacao,
						v_TipoNotificacao,
						3,
						0);
			END IF;
	         
			IF V_INCLUIR_ANEXO THEN
    
			  OPEN ANEXOS;
			  FETCH ANEXOS
				INTO C_ANEXOS;
    
			  WHILE (ANEXOS%FOUND) LOOP
      
				INSERT INTO MTK_ANEXO
				  (ID, ID_TRAMITE, ANEXO, TAMANHO, TIPO, NOME)
				VALUES
				  (SEQ_MTK_ANEXO.NEXTVAL,
				   V_ID_TRAMITE,
				   C_ANEXOS.ARQUIVO_ANEXO,
				   15,
				   'application/pdf',
				   C_ANEXOS.DOCTO_ANEXO);
      
				FETCH ANEXOS
				  INTO C_ANEXOS;
			  END LOOP;
			  CLOSE ANEXOS;
    
			END IF;                                               
       END; --PROCEDURE ATUALIZAR_TICKET
BEGIN
	IF (:New.StatusSas <> :Old.StatusSas) THEN --Somente executa na mudança de status
       IF :New.StatusSas = '98' OR :New.StatusSas = '03' OR :New.StatusSas = '12' OR :New.StatusSas = '04' OR (:New.StatusSas = '05' And :Old.StatusSas = '03')  Then
              FOR r IN (SELECT B.ID, B.ID_OPERADOR, B.ID_OPERADOR_CONTATO, B.STATUS FROM MTK_TICKET_SAS A 
						           INNER JOIN MTK_TICKET B ON A.ID_TICKET = B.ID 
						           WHERE A.Codigo_Sas = :New.Codigosas AND
                       A.TIPO_SAS_SIM = :New.Tiposassim) 
              LOOP
                  IF (r.STATUS <> 7) THEN
					           Atualizar_Ticket(r.ID, r.ID_OPERADOR, r.ID_OPERADOR_CONTATO ,:New.StatusSas, :Old.StatusSas);
                  END IF;
              END LOOP;   
       COMMIT;
       END IF;  
	END IF;   
END TR_MTK_ATUALIZAR_TICKET;

