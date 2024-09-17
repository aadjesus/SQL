CREATE OR REPLACE PROCEDURE Pr_Manu_Carga_Inicial (v_Tipo_Operacao      INTEGER DEFAULT 0) IS
	TYPE t_Array_Rec IS RECORD(
		 Table_Name    VARCHAR2(30)
		,Criar_Trigger BOOLEAN
		,Nome_Json     VARCHAR2(30)
		,Colunas       t_Manu_Colunas
		,Carga_Inicial BOOLEAN
		,Tipo_Operacao INTEGER);

	TYPE t_Array_Tab IS TABLE OF t_Array_Rec INDEX BY BINARY_INTEGER;
	v_Lista_Tab t_Array_Tab;
	v_Index     NUMBER;

	PROCEDURE Add_Tab(p_Table_Name         VARCHAR2
						  ,p_Colunas            t_Manu_Colunas DEFAULT t_Manu_Colunas()
						  ,p_Criar_Trigger      BOOLEAN DEFAULT TRUE
						  ,p_Exec_Carga_Inicial BOOLEAN DEFAULT TRUE
						  ,p_Tipo_Operacao      INTEGER DEFAULT -1
						  ,p_Nome_Json          VARCHAR2 DEFAULT '') IS
	BEGIN
		v_Index := v_Index + 1;
		v_Lista_Tab(v_Index).Table_Name := Upper(TRIM(p_Table_Name));
		v_Lista_Tab(v_Index).Nome_Json := Upper(p_Nome_Json);
		v_Lista_Tab(v_Index).Criar_Trigger := p_Criar_Trigger;
		v_Lista_Tab(v_Index).Carga_Inicial := p_Exec_Carga_Inicial;
		v_Lista_Tab(v_Index).Colunas := p_Colunas;
		v_Lista_Tab(v_Index).Tipo_Operacao := p_Tipo_Operacao;		
	END;

	PROCEDURE Criar_Lista IS
	BEGIN
		v_Index := 0;
		Add_Tab('MAN_GRUPODESERVICO    ', t_Manu_Colunas('codigogrpservi', 'descricaogrpservi', 'utilizacaogrpservi'));
		Add_Tab('MAN_TIPOOPERACAOSERVI ', t_Manu_Colunas('codigotpoperservi', 'descricaotpoperservi'));
		Add_Tab('MAN_PLANODEREVISAO    ', t_Manu_Colunas('codigoplanrev', 'descricaoplanrev', 'trocaoleoplanrev', 'trocaoleocxcambio', 'trocaoleocxdif'));
		Add_Tab('MAN_CADDEFEITOS       ', t_Manu_Colunas('codigogrpservi', 'codigodefeito', 'descricaodefeito', 'tempoprevdefeito'));
		Add_Tab('FLP_SETOR             ', t_Manu_Colunas('codsetor', 'descsetor'));
		Add_Tab('MAN_CADASTRODESERVICOS', t_Manu_Colunas('codigogrpservi', 'codigocadservi', 'descricaocadservi', 'tempoexecucaocadservi', 'servicoativo'));
		Add_Tab('CTR_EMPAUTORIZADAS    ', t_Manu_Colunas('codintempaut', 'rsocialempresa', 'nomefantasiaempresa'));
		Add_Tab('CTR_CADEMP            ', t_Manu_Colunas('codigoempresa', 'codintempaut'));
		Add_Tab('CTR_FILIAL            ', t_Manu_Colunas('codigoempresa', 'codigofl', 'codintempaut'));
		Add_Tab('EST_PARAMETRO         ', t_Manu_Colunas('Funcmultiempresaparam', 'Codigoempresa', 'Codigofl'), TRUE, TRUE, 1);
		Add_Tab('CTR_GARAGEM           ', t_Manu_Colunas('codigoga', 'nomega'));
		Add_Tab('CTR_FILIAL_GAR        ', t_Manu_Colunas('codigoempresa', 'codigofl', 'codigoga'));
		Add_Tab('CTR_CADLOCAL          ', t_Manu_Colunas('codigolocal', 'codigoempresa', 'codigofl', 'codigoga', 'descricaolocal'));
		Add_Tab('ABA_CADTIPOOLEOCOMBO  ', t_Manu_Colunas('codigotpoleo', 'descricaotpoleo', 'tipotpoleo','codigoempresa', 'codigofl'));
		Add_Tab('MOT_MODELOMOTOR       ', t_Manu_Colunas('codigomodmotor'), TRUE, TRUE, 3);
		Add_Tab('MOT_ASSOCTPOLCBMODMOT ', t_Manu_Colunas('codigomodmotor'), TRUE, FALSE, 3, 'MOT_MODELOMOTOR');
		Add_Tab('FRT_CADVEICULOS       ', t_Manu_Colunas('codigoveic', 'codigoempresa', 'codigofl', 'codigoga', 'prefixoveic', 'placaatualveic', 'condicaoveic', 'capac_cxcambio', 'capac_cxdiferencial', 'codigomodmotor'));
		Add_Tab('MAN_SENHAFUNC         ', t_Manu_Colunas(), FALSE);
		Add_Tab('EST_QTDEMATMARCA      ', t_Manu_Colunas(), FALSE, TRUE, 1);
		Add_Tab('MAN_OS                ', t_Manu_Colunas('codintos'), TRUE, FALSE, 3);
		Add_Tab('MAN_OSPREVISTO        ', t_Manu_Colunas('codintos'), TRUE, FALSE, 3, 'MAN_OS');
		Add_Tab('MAN_PARAM             ', t_Manu_Colunas('botrevogarvisibleman_param', 'codigoempresa', 'codigofl'), TRUE, TRUE, 1);
	END;
BEGIN
	IF NOT Fc_Manu_Validarsistema() THEN
		RETURN;
	END IF;

	Criar_Lista();
	FOR i IN 1 .. v_Lista_Tab.COUNT
	LOOP
		IF v_Lista_Tab(i).Criar_Trigger
			AND NOT Fc_Manu_Criar_Trigger(v_Lista_Tab(i).Table_Name, v_Lista_Tab(i).Colunas, v_Lista_Tab(i).Nome_Json, v_Lista_Tab(i).Tipo_Operacao) THEN
			Continue;
		END IF;

		IF v_Lista_Tab(i).Tipo_Operacao = -1 THEN
			v_Lista_Tab(i).Tipo_Operacao := v_Tipo_Operacao;
		END IF;
		
		Pr_Manu_Carga_Inicial_Tabela(v_Lista_Tab(i).Table_Name, v_Lista_Tab(i).Carga_Inicial, v_Lista_Tab(i).Tipo_Operacao);
	END LOOP;
END Pr_Manu_Carga_Inicial;