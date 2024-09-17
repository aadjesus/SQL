Create Or Replace Trigger Teste_MAN_OSPREVISTO
  After Insert Or Update Or Delete On MAN_OSPREVISTO
  For Each Row
Declare
Begin
     IF (Updating AND
		     nvl(:New.CODINTOS                ,0)   = nvl(:New.CODINTOS                ,0)   AND
		     nvl(:New.SEQSERVOSPREV           ,0)   = nvl(:New.SEQSERVOSPREV           ,0)   AND
		     nvl(:New.DESCRCOMPLOSPREV        ,0)   = nvl(:New.DESCRCOMPLOSPREV        ,0)   AND
		     nvl(:New.CODIGOPLANREV           ,0)   = nvl(:New.CODIGOPLANREV           ,0)   AND
		     nvl(:New.CODIGOGRPDEFEITO        ,0)   = nvl(:New.CODIGOGRPDEFEITO        ,0)   AND
		     nvl(:New.CODIGOGRPSERVI          ,0)   = nvl(:New.CODIGOGRPSERVI          ,0)   AND
		     nvl(:New.CODIGOCADSERVI          ,0)   = nvl(:New.CODIGOCADSERVI          ,0)   AND
		     nvl(:New.QTDEEXECSERV            ,0)   = nvl(:New.QTDEEXECSERV            ,0)   AND
		     nvl(:New.CODORIGOS               ,0)   = nvl(:New.CODORIGOS               ,0)   AND
		     nvl(:New.CODINTPROAUT            ,0)   = nvl(:New.CODINTPROAUT            ,0)   AND
		     nvl(:New.CODIGODEFEITO           ,0)   = nvl(:New.CODIGODEFEITO           ,0)   AND
		     nvl(:New.CODIGOTPOPERSERVI       ,0)   = nvl(:New.CODIGOTPOPERSERVI       ,0)   AND
		     nvl(:New.EXECUTADOOSPREV         ,'-') = nvl(:New.EXECUTADOOSPREV         ,'-') AND
		     nvl(:New.DEFREPETIDO             ,'-') = nvl(:New.DEFREPETIDO             ,'-') AND
		     nvl(:New.DEFPENDENTE             ,'-') = nvl(:New.DEFPENDENTE             ,'-') AND
		     nvl(:New.SITUACAODEFEITO         ,'-') = nvl(:New.SITUACAODEFEITO         ,'-') AND
		     nvl(:New.DEFEITOLIBERADO         ,'-') = nvl(:New.DEFEITOLIBERADO         ,'-') AND
		     nvl(:New.SERVDEFPARCIALFINALIZADO,'-') = nvl(:New.SERVDEFPARCIALFINALIZADO,'-') AND
		     nvl(:New.CRIADOMANU              ,'-') = nvl(:New.CRIADOMANU              ,'-'))
    Then
        DBMS_OUTPUT.PUT_LINE('retorno');
        Return;
    End If;

    DBMS_OUTPUT.PUT_LINE('fim');
end;
 
/
