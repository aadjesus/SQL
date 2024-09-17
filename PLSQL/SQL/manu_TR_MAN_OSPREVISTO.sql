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

  Pr_Manu_Insert_Json_1('MAN_OS', v_Json);
End TR_Manu_OSPREVISTO_2;
