declare 
	@MAN_GRUPODESERVICO    	int,
	@MAN_TIPOOPERACAOSERVI 	int,
	@MAN_PLANODEREVISAO    	int,
	@MAN_CADDEFEITOS       	int,
	@FLP_SETOR             	int,
	@MAN_CADASTRODESERVICOS	int,
	@CTR_EMPAUTORIZADAS    	int,
	@CTR_CADEMP            	int,
	@CTR_FILIAL            	int,
	@EST_PARAMETRO         	int,
	@CTR_GARAGEM           	int,
	@CTR_FILIAL_GAR        	int,
	@CTR_CADLOCAL          	int,
	@ABA_CADTIPOOLEOCOMBO  	int,
	@MOT_MODELOMOTOR       	int,
	@FRT_CADVEICULOS       	int,
	@MAN_SENHAFUNC         	int 
	
begin
	set @MAN_GRUPODESERVICO    	= 0;
	set @MAN_TIPOOPERACAOSERVI 	= 0;
	set @MAN_PLANODEREVISAO    	= 0;
	set @MAN_CADDEFEITOS       	= 0;
	set @FLP_SETOR             	= 0;
	set @MAN_CADASTRODESERVICOS	= 0;
	set @CTR_EMPAUTORIZADAS    	= 0;
	set @CTR_CADEMP            	= 0;
	set @CTR_FILIAL            	= 0;
	set @EST_PARAMETRO         	= 0;
	set @CTR_GARAGEM           	= 0;
	set @CTR_FILIAL_GAR        	= 0;
	set @CTR_CADLOCAL          	= 0;
	set @ABA_CADTIPOOLEOCOMBO  	= 0;
	set @MOT_MODELOMOTOR       	= 0;
	set @FRT_CADVEICULOS       	= 0;
	set @MAN_SENHAFUNC         	= 0;	

	set @MAN_GRUPODESERVICO     = (select count(*) from GrupoServico where TenantId = 1) ;
	set @MAN_TIPOOPERACAOSERVI 	= (select count(*) from TipoDeOperacao where TenantId = 1) ;
	set @MAN_PLANODEREVISAO    	= (select count(*) from PlanoDeRevisao where TenantId = 1) ;
	set @MAN_CADDEFEITOS       	= (select count(*) from Defeito where TenantId = 1) ;
	set @FLP_SETOR             	= (select count(*) from Setor where TenantId = 1) ;
	set @MAN_CADASTRODESERVICOS	= (select count(*) from Servico where TenantId = 1) ;
	set @CTR_EMPAUTORIZADAS    	= (select count(*) from EmpresaAutorizada where TenantId = 1) ;
	set @CTR_CADEMP            	= (select count(*) from Empresa where TenantId = 1) ;
	set @CTR_FILIAL            	= (select count(*) from Filial where TenantId = 1) ;
	set @EST_PARAMETRO         	= 0;
	set @CTR_GARAGEM           	= (select count(*) from Garagem where TenantId = 1) ;
	set @CTR_FILIAL_GAR        	= 0;
	set @CTR_CADLOCAL          	= (select count(*) from Local where TenantId = 1) ;
	set @ABA_CADTIPOOLEOCOMBO  	= (select count(*) from Oleo where TenantId = 1) ;
	set @MOT_MODELOMOTOR       	= (select count(*) from ModeloMotor where TenantId = 1) ;
	set @FRT_CADVEICULOS       	= (select count(*) from Veiculo where TenantId = 1) ;
	set @MAN_SENHAFUNC         	= (select count(*) from Funcionario where TenantId = 1) ;	

	print 'GrupoServico: '		+ CAST(@MAN_GRUPODESERVICO     AS varchar(4));
	print 'TipoDeOperacao: '	+ CAST(@MAN_TIPOOPERACAOSERVI  AS varchar(4));
	print 'PlanoDeRevisao: '	+ CAST(@MAN_PLANODEREVISAO     AS varchar(4));
	print 'Defeito: '			+ CAST(@MAN_CADDEFEITOS        AS varchar(4));
	print 'Setor: '				+ CAST(@FLP_SETOR              AS varchar(4));
	print 'Servico: '			+ CAST(@MAN_CADASTRODESERVICOS AS varchar(4));
	print 'EmpresaAutorizada: ' + CAST(@CTR_EMPAUTORIZADAS     AS varchar(4));
	print 'Empresa: '			+ CAST(@CTR_CADEMP             AS varchar(4));
	print 'Filial: '			+ CAST(@CTR_FILIAL             AS varchar(4));
	print 'Parametro: '			+ CAST(@EST_PARAMETRO          AS varchar(4));
	print 'Garagem: '			+ CAST(@CTR_GARAGEM            AS varchar(4));
	print 'Filial Garagem: '	+ CAST(@CTR_FILIAL_GAR         AS varchar(4));
	print 'Local: '				+ CAST(@CTR_CADLOCAL           AS varchar(4));
	print 'Oleo: '				+ CAST(@ABA_CADTIPOOLEOCOMBO   AS varchar(4));
	print 'ModeloMotor: '		+ CAST(@MOT_MODELOMOTOR        AS varchar(4));
	print 'Veiculo: '			+ CAST(@FRT_CADVEICULOS        AS varchar(4));
	print 'Funcionario: '		+ CAST(@MAN_SENHAFUNC          AS varchar(4));
	print 'Total:'				+ CAST(@MAN_GRUPODESERVICO + @MAN_TIPOOPERACAOSERVI	+@MAN_PLANODEREVISAO	+@MAN_CADDEFEITOS	+@FLP_SETOR	+@MAN_CADASTRODESERVICOS	+@CTR_EMPAUTORIZADAS	+@CTR_CADEMP	+@CTR_FILIAL	+@EST_PARAMETRO+@CTR_GARAGEM+@CTR_FILIAL_GAR	+@CTR_CADLOCAL	+@ABA_CADTIPOOLEOCOMBO	+@MOT_MODELOMOTOR	+@FRT_CADVEICULOS	+@MAN_SENHAFUNC AS varchar(4));
end;