SELECT 

		--Tabela Consolidado
		--================================================================================
		C.PROCV
		,C.NV_FX_FORNECE												AS FAIXA_FORNECEDOR
		,C.NV_FX_FECHO													AS FAIXA_FECHO
		,CONVERT(VARCHAR(10),CONVERT(DATE,C.VENC_ATUAL,106),103)		AS VENC_ATUAL
		,CONVERT(VARCHAR(10),CONVERT(DATE,C.VENC_ORIGINAL,106),103)		AS VENC_ORIGINAL
		,CONVERT(VARCHAR(10),CONVERT(DATE,C.[DT_PROCESS],106),103)		AS DT_PROCESS
		,C.ANOMES
		,C.DIA_VENCIMENTO												AS DIA_VENCIMENTO_LOTE
		,C.NUMERO_LOTE
		,C.VALOR_LOTE	
		,CONVERT(VARCHAR(10),CONVERT(DATE,C.DTCORTE,106),103)			AS DTCORTE
		,C.CICLO
		,C.UF
		,C.STATUS
		,C.CLASSE
		,C.SEGMENTO_GERENCIA
		,C.GN
		,C.GV
		,C.DIRETOR
		,C.ANALISTA_TLF_VIVO
		,C.INTRAGOV
		,C.INTERCOMPANY
		,C.TASK_FORCE
		,C.SEG_DESCR
		,C.PARCELAMENTO
		,C.CONTA_BONUS
		,C.FORNECEDOR
		,C.REGRA_PDD
		,C.FAIXA_CORTE
		,C.PROVISAO
		,C.[SITUACAO_SERVICO]
		,C.ENDERECO
		,C.ID_NV_FX_ARRECADA
		,C.ID_SEGMENTO
		,C.RAIZ_GRUPO
		,C.NOME_GRUPO													AS GRUPO
		,C.RAIZ_CPF_CNPJ												AS RAIZ
		,C.CPF_CNPJ														AS CNPJ
		,C.CLIENTE														AS NOME
		,C.RAZAO_SOCIAL													AS NOME_CLIENTE
		,C.TIPO	
		,C.EMPRESA
		,C.CONTA
		,C.TEL
		,C.LOCAL
		,C.TERMINAL
		,C.DV
		,C.NRC
		,C.CLASSERV
		,C.TITULO
		,C.FILIAL
		,C.LJ_CLI
		,C.COD_CLI
		,C.DOCUMENTO_SAP
		,C.DOC_FAT
		,C.N_DOC_DE_PARA_ATLYS
		,C.NOTA_FISCAL
		,C.QTD_REG_AGRUPADO
	
		--TB_CONSUMO_SISCOB
		--================================================================================

		,CS.ID_CONSOLIDADO	AS ID
		
		,CS.ID_ANALISTA
		,CS.ID_ANALISTA_TMP

		,CASE 
			WHEN CS.ID_STATUS_ESCALATION = 1 THEN 'BAIXADO'
			WHEN CS.ID_STATUS_ESCALATION = 2 THEN 'EM ANDAMENTO'
			WHEN CS.ID_STATUS_ESCALATION = 3 THEN 'ATENCAO'
			WHEN CS.ID_STATUS_ESCALATION = 4 THEN 'PENDENTE'
		 END AS ESCALATION
	 
		--TBL_USUARIOS
		--================================================================================	 
	
	,(
		SELECT U.fname  + space(1) + U.lname	
		FROM [APP_WEB].[TBL_USUARIOS] U WITH (INDEX (PK__TBL_USUA__D2D14637174B6B0E))
		WHERE U.id_user = CS.ID_ANALISTA
		) AS NOME_ANALISTA
	,(
		SELECT U.area
		FROM [APP_WEB].[TBL_USUARIOS] U WITH (INDEX (PK__TBL_USUA__D2D14637174B6B0E))
		WHERE U.id_user = CS.ID_ANALISTA
		) AS ID_EQUIPE
	,(
		SELECT U.fname  + space(1) + U.lname
		FROM [APP_WEB].[TBL_USUARIOS] U WITH (INDEX (PK__TBL_USUA__D2D14637174B6B0E))
		WHERE U.id_user = CS.ID_ANALISTA_TMP
		) AS NOME_ANALISTA_TMP
	,(
		SELECT UA.fname + space(1) + UA.lname	
		FROM [APP_WEB].[TBL_USUARIOS] U WITH (INDEX (PK__TBL_USUA__D2D14637174B6B0E))
		WHERE U.id_user = h.ID_ANALISTA
		) AS USUARIO_ATUALIZACAO	
	
		--,AN.fname + space(1) + AN.lname									AS NOME_ANALISTA
		--,AN.area														AS ID_EQUIPE
		--,ANT.fname + space(1) + ANT.lname								AS NOME_ANALISTA_TMP
		--,UA.fname + space(1) + UA.lname									AS USUARIO_ATUALIZACAO
		--LEFT  JOIN	[APP_WEB].[TBL_USUARIOS]				UA	ON H.ID_ANALISTA			= UA.id_user
		--LEFT  JOIN	[APP_WEB].[TBL_USUARIOS]				AN	ON CS.ID_ANALISTA			= AN.id_user
		--LEFT  JOIN	[APP_WEB].[TBL_USUARIOS]				ANT	ON CS.ID_ANALISTA_TMP		= ANT.id_user
		
	
	
		--TB_HISTORICO
		--================================================================================	
		
		,(
		SELECT H.VALOR_PAGO
		FROM [CONSOLIDADO].[TB_HISTORICO] H
		WHERE H.ID = CS.ID_HISTORICO_ATUAL
		) AS VALOR_PAGO
		
		,(
		SELECT H.VALOR_AJUSTE
		FROM [CONSOLIDADO].[TB_HISTORICO] H
		WHERE H.ID = CS.ID_HISTORICO_ATUAL
		) AS VALOR_AJUSTE
		
		,(
		SELECT H.OBS
		FROM [CONSOLIDADO].[TB_HISTORICO] H
		WHERE H.ID = CS.ID_HISTORICO_ATUAL
		) AS OBS

		,(
		SELECT H.ID_GESTAO_CONTA
		FROM [CONSOLIDADO].[TB_HISTORICO] H
		WHERE H.ID = CS.ID_HISTORICO_ATUAL
		) AS ID_GESTAO_CONTA
		
		,(
		SELECT H.ID_PORTAL_DEMANDA
		FROM [CONSOLIDADO].[TB_HISTORICO] H
		WHERE H.ID = CS.ID_HISTORICO_ATUAL
		) AS ID_PORTAL_DEMANDA
		
		,(
		SELECT H.CBPM
		FROM [CONSOLIDADO].[TB_HISTORICO] H
		WHERE H.ID = CS.ID_HISTORICO_ATUAL
		) AS CBPM
		
		,(
		SELECT H.NUMERO_BOLETO
		FROM [CONSOLIDADO].[TB_HISTORICO] H
		WHERE H.ID = CS.ID_HISTORICO_ATUAL
		) AS NUMERO_BOLETO
		
		,(
		SELECT H.DATA_EMISSAO_BOLETO
		FROM [CONSOLIDADO].[TB_HISTORICO] H
		WHERE H.ID = CS.ID_HISTORICO_ATUAL
		) AS DATA_EMISSAO_BOLETO
		
		,(
		SELECT H.GESTAO_CONTA
		FROM [CONSOLIDADO].[TB_HISTORICO] H
		WHERE H.ID = CS.ID_HISTORICO_ATUAL
		) AS GESTAO_CONTA
		
		,(
		SELECT CONVERT(VARCHAR(10), CONVERT(DATE, H.DT_PAGAMENTO, 106), 103)
		FROM [CONSOLIDADO].[TB_HISTORICO] H
		WHERE H.ID = CS.ID_HISTORICO_ATUAL
		) AS DT_PAGTO

		,(
		SELECT CONVERT(VARCHAR(10), CONVERT(DATE, H.DT_AJUSTE, 106), 103)
		FROM [CONSOLIDADO].[TB_HISTORICO] H
		WHERE H.ID = CS.ID_HISTORICO_ATUAL
		) AS DT_AJUSTE

		,(
		SELECT CONVERT(VARCHAR(10), CONVERT(DATE, H.DT_FOLLOW, 106), 103)
		FROM [CONSOLIDADO].[TB_HISTORICO] H
		WHERE H.ID = CS.ID_HISTORICO_ATUAL
		) AS DT_FOLLOW

		,(
		SELECT [AUXILIAR].[FN_FORMATAR_TEXTO](H.RE_PROBLEMA)
		FROM [CONSOLIDADO].[TB_HISTORICO] H
		WHERE H.ID = CS.ID_HISTORICO_ATUAL
		) AS RESUMO_EXECUTIVO_PROBLEMA
		
		,(
		SELECT [AUXILIAR].[FN_FORMATAR_TEXTO](H.RE_ACAO)
		FROM [CONSOLIDADO].[TB_HISTORICO] H
		WHERE H.ID = CS.ID_HISTORICO_ATUAL
		) AS RESUMO_EXECUTIVO_ACAO
		
		,(
		SELECT [AUXILIAR].[FN_FORMATAR_TEXTO](H.HISTORICO_DETALHADO)
		FROM [CONSOLIDADO].[TB_HISTORICO] H
		WHERE H.ID = CS.ID_HISTORICO_ATUAL
		) AS HISTORICO_DETALHADO
		
		,(
		SELECT [AUXILIAR].[FN_FORMATAR_TEXTO](H.RESPONSAVEL)
		FROM [CONSOLIDADO].[TB_HISTORICO] H
		WHERE H.ID = CS.ID_HISTORICO_ATUAL
		) AS RESPONSAVEL

		,(
		SELECT CONVERT(VARCHAR(10),CONVERT(DATE,H.DT_ABERTURA,106),103)
		FROM [CONSOLIDADO].[TB_HISTORICO] H
		WHERE H.ID = CS.ID_HISTORICO_ATUAL
		) AS DT_ABERTURA

		,(
		SELECT CONVERT(VARCHAR(10),CONVERT(DATE,H.DT_ENCERRAMENTO,106),103)
		FROM [CONSOLIDADO].[TB_HISTORICO] H
		WHERE H.ID = CS.ID_HISTORICO_ATUAL
		) AS DT_ENCERRAMENTO

		,(
		SELECT CONVERT(VARCHAR(10),CONVERT(DATE,H.DT_CONTATO,106),103)
		FROM [CONSOLIDADO].[TB_HISTORICO] H
		WHERE H.ID = CS.ID_HISTORICO_ATUAL
		) AS DT_CONTATO

		,(
		SELECT CONVERT(VARCHAR(10),CONVERT(DATE,H.TIME_STAMP,106),103)
		FROM [CONSOLIDADO].[TB_HISTORICO] H
		WHERE H.ID = CS.ID_HISTORICO_ATUAL
		) AS DT_ULT_ALTERACAO		
		

		--TB_ANALISE_CONTA
		--================================================================================	

		,(
		SELECT CONVERT(VARCHAR(10),CONVERT(DATE,AC.PENDENTE_DATA,106),103)
		FROM [AUXILIAR].[TB_ANALISE_CONTA] AC
		WHERE AC.ID = CS.ID_ANALISE_CONTA
		) AS PENDENTE_DATA_ANALISE_CONTA	

		,(
		SELECT CONVERT(VARCHAR(10),CONVERT(DATE,AC.CONCLUIDO_DATA,106),103)
		FROM [AUXILIAR].[TB_ANALISE_CONTA] AC
		WHERE AC.ID = CS.ID_ANALISE_CONTA
		) AS CONCLUIDO_DATA_ANALISE_CONTA	

		,(
		SELECT CONVERT(VARCHAR(10),CONVERT(DATE,AC.REABERTO_DATA,106),103)
		FROM [AUXILIAR].[TB_ANALISE_CONTA] AC
		WHERE AC.ID = CS.ID_ANALISE_CONTA
		) AS REABERTO_DATA_ANALISE_CONTA			
				
		,(
		SELECT AC.CONCLUIDO_ID
		FROM [AUXILIAR].[TB_ANALISE_CONTA] AC
		WHERE AC.ID = CS.ID_ANALISE_CONTA
		) AS CONCLUIDO_ID_ANALISE_CONTA		

		,(
		SELECT AC.CONCLUIDO_ID
		FROM [AUXILIAR].[TB_ANALISE_CONTA] AC
		WHERE AC.ID = CS.ID_ANALISE_CONTA
		) AS REABERTO_ID_ANALISE_CONTA


		--TB_FOCO_AREA_OFENSORA
		--================================================================================	

		,(
		SELECT AA.FOCO
		FROM [AUXILIAR].[TB_FOCO_AREA_OFENSORA] AA
		WHERE AA.ID = H.ID_FOCO_FEEDBACK
		) AS FEEDBACK

		,(
		SELECT AC.AREA_OFENSORA
		FROM [AUXILIAR].[TB_FOCO_AREA_OFENSORA] AA
		WHERE AA.ID = H.ID_FOCO_FEEDBACK
		) AS AREA_OFENSORA		

		,(
		SELECT AC.ID
		FROM [AUXILIAR].[TB_FOCO_AREA_OFENSORA]	AA
		WHERE AA.ID = H.ID_FOCO_FEEDBACK
		) AS ID_FEEDBACK

		,(
		SELECT AA.ID_AREA_OFENSORA
		FROM [AUXILIAR].[TB_FOCO_AREA_OFENSORA] AA
		WHERE AA.ID = H.ID_FOCO_FEEDBACK
		) AS ID_AREA_OFENSORA

		--TB_TIPO_PAGAMENTO  >>> TB_HISTORICO ([AUXILIAR].TB_TIPO_PAGAMENTO	TA ON [CONSOLIDADO].[TB_HISTORICO].ID_TIPO_PAGAMENTO = TA.ID)
		--================================================================================	


		,SELECT
				,(
				SELECT AC.DESCRICAO
				FROM [AUXILIAR].[TB_TIPO_PAGAMENTO] TA
				WHERE TA.ID = H_TP_PG.ID_TIPO_PAGAMENTO
				) AS ID_TIPO_PAGAMENTO		

				,(
				SELECT TA.ID
				FROM [AUXILIAR].[TB_TIPO_PAGAMENTO]	TA
				WHERE TA.ID = H_TP_PG.ID_TIPO_PAGAMENTO
				) AS ID

				from 
				(
					SELECT H.ID_TIPO_PAGAMENTO  FROM [CONSOLIDADO].[TB_HISTORICO] H WHERE H.ID = CS.ID_HISTORICO_ATUAL
					) AS H_TP_PG

		
		
		--,AA.FOCO														AS FEEDBACK
		--,AA.AREA_OFENSORA												AS AREA_OFENSORA
		--,AA.ID															AS ID_FEEDBACK

		--,AA.ID_AREA_OFENSORA	
		--,TA.DESCRICAO													AS TIPO_PAGTO
		--,TA.ID															AS ID_TIPO_PAGAMENTO
		
		
		
		--LEFT  JOIN  [CONSOLIDADO].[TB_HISTORICO]			H   ON H.ID 					= CS.ID_HISTORICO_ATUAL		
		--LEFT  JOIN  [AUXILIAR].[TB_FOCO_AREA_OFENSORA]  	AA	ON H.ID_FOCO_FEEDBACK		= AA.ID		
		--LEFT  JOIN	[AUXILIAR].[TB_TIPO_PAGAMENTO]			TA  ON H.ID_TIPO_PAGAMENTO		= TA.ID
		--LEFT  JOIN	[AUXILIAR].[TB_ANALISE_CONTA]			AC  ON CS.ID_ANALISE_CONTA		= AC.ID
		
		
		
	
		--TB_TIPO_PAGAMENTO
		--================================================================================		
	
		,(
		SELECT V1.NV_FX_ARRECADA
		FROM [CONSOLIDADO].[TB_DADOS_E_VALORES] V1
		WHERE V1.ID = CS.ID_VALORES_26
		) AS NV_FX_ARRECADA

		,(
		SELECT V1.SALDO_CAR
		FROM [CONSOLIDADO].[TB_DADOS_E_VALORES] V1
		WHERE V1.ID = CS.ID_VALORES_26
		) AS NV_FX_ARRECADA

		,(
		SELECT ISNULL(V1.SALDO_FX_ENT,0) + ISNULL(V1.SALDO_PDD,0) AS SOMA_FXE_PDD_26
		FROM [CONSOLIDADO].[TB_DADOS_E_VALORES] V1
		WHERE V1.ID = CS.ID_VALORES_26
		) AS SOMA_FXE_PDD_26



		--,V1.NV_FX_ARRECADA												AS FAIXA_ARRECADA_INICIAL
		--,V1.SALDO_CAR													AS SALDO_CAR_26
		--,ISNULL(V1.SALDO_FX_ENT,0) + ISNULL(V1.SALDO_PDD,0)				AS SOMA_FXE_PDD_26
		
		,(
		SELECT V2.SALDO_CAR											AS SALDO_CAR_05
		FROM [CONSOLIDADO].[TB_DADOS_E_VALORES] V2
		WHERE V2.ID = CS.ID_VALORES_05
		) AS SALDO_CAR_05

		,(
		SELECT ISNULL(V2.SALDO_FX_ENT,0) + ISNULL(V2.SALDO_PDD,0)	AS SOMA_FXE_PDD_05
		FROM [CONSOLIDADO].[TB_DADOS_E_VALORES] V2
		WHERE V2.ID = CS.ID_VALORES_05
		) AS SOMA_FXE_PDD_05		


		--,V2.SALDO_CAR													AS SALDO_CAR_05
		--,ISNULL(V2.SALDO_FX_ENT,0) + ISNULL(V2.SALDO_PDD,0)				AS SOMA_FXE_PDD_05

		,(
		SELECT V3.SALDO_CAR											AS SALDO_CAR_14
		FROM [CONSOLIDADO].[TB_DADOS_E_VALORES] V3
		WHERE V3.ID = CS.ID_VALORES_14
		) AS SALDO_CAR_14

		,(
		SELECT ISNULL(V3.SALDO_FX_ENT,0) + ISNULL(V3.SALDO_PDD,0)	AS SOMA_FXE_PDD_14
		FROM [CONSOLIDADO].[TB_DADOS_E_VALORES] V3
		WHERE V3.ID = CS.ID_VALORES_14
		) AS SOMA_FXE_PDD_14		


		--,V3.SALDO_CAR													AS SALDO_CAR_14
		--,ISNULL(V3.SALDO_FX_ENT,0) + ISNULL(V4.SALDO_PDD,0)				AS SOMA_FXE_PDD_14
		
		,(
		SELECT V4.SALDO_CAR											AS SALDO_CAR_21
		FROM [CONSOLIDADO].[TB_DADOS_E_VALORES] V4
		WHERE V4.ID = CS.ID_VALORES_21
		) AS SALDO_CAR_21

		,(
		SELECT ISNULL(V4.SALDO_FX_ENT,0) + ISNULL(V4.SALDO_PDD,0)	AS SOMA_FXE_PDD_21
		FROM [CONSOLIDADO].[TB_DADOS_E_VALORES] V4
		WHERE V4.ID = CS.ID_VALORES_21
		) AS SOMA_FXE_PDD_21	


		--,V4.SALDO_CAR													AS SALDO_CAR_21
		--,ISNULL(V4.SALDO_FX_ENT,0) + ISNULL(V4.SALDO_PDD,0)				AS SOMA_FXE_PDD_21
		

		,(
		SELECT V5.SALDO_CAR											AS SALDO_CAR_25
		FROM [CONSOLIDADO].[TB_DADOS_E_VALORES] V5
		WHERE V5.ID = CS.ID_VALORES_25
		) AS SALDO_CAR_25

		,(
		SELECT ISNULL(V5.SALDO_FX_ENT,0) + ISNULL(V5.SALDO_PDD,0)	AS SOMA_FXE_PDD_25
		FROM [CONSOLIDADO].[TB_DADOS_E_VALORES] V5
		WHERE V5.ID = CS.ID_VALORES_25
		) AS SOMA_FXE_PDD_25	


		--,V5.SALDO_CAR													AS SALDO_CAR_25
		--,ISNULL(V5.SALDO_FX_ENT,0) + ISNULL(V5.SALDO_PDD,0)				AS SOMA_FXE_PDD_25

		,(
		SELECT VA.SALDO_CAR											AS FAIXA_ARRECADA_ATUAL
		FROM [CONSOLIDADO].[TB_DADOS_E_VALORES] VA
		WHERE VA.ID = CS.ID_VALOR_ATUAL
		) AS FAIXA_ARRECADA_ATUAL

		,(
		SELECT ISNULL(VA.SALDO_FX_ENT,0) + ISNULL(VA.SALDO_PDD,0)	AS SALDO_TOTAL
		FROM [CONSOLIDADO].[TB_DADOS_E_VALORES] VA
		WHERE VA.ID = CS.ID_VALOR_ATUAL
		) AS SALDO_TOTAL

		
		--,VA.NV_FX_ARRECADA												AS FAIXA_ARRECADA_ATUAL
		--,VA.SALDO_CAR													AS SALDO_TOTAL



		,(
		SELECT 
			CASE 
				WHEN VA.SALDO_CAR IS NOT NULL THEN 
					VA.SALDO_CAR - ISNULL(PG.VALOR_PAGTO,0) -  ISNULL(PG.VALOR_AJUSTE,0)
				ELSE 0 
			 END AS	SALDO_ATUAL

		FROM [CONSOLIDADO].[TB_DADOS_E_VALORES] VA
		WHERE VA.ID = CS.ID_VALOR_ATUAL
		) AS SALDO_ATUAL

		,(
		SELECT VA.ID_NV_FX_FORNECE	AS ID_FORNECEDOR
		FROM [CONSOLIDADO].[TB_DADOS_E_VALORES] VA
		WHERE VA.ID = CS.ID_VALOR_ATUAL
		) AS ID_FORNECEDOR


		--,CASE 
		--	WHEN VA.SALDO_CAR IS NOT NULL THEN 
		--		VA.SALDO_CAR - ISNULL(PG.VALOR_PAGTO,0) -  ISNULL(PG.VALOR_AJUSTE,0)
		--	ELSE 0 
		-- END AS	SALDO_ATUAL 

		--,VA.ID_NV_FX_FORNECE	AS ID_FORNECEDOR

		,(
		SELECT VN.SALDO_CAR		AS SALDO_CAR_30
		FROM [CONSOLIDADO].[TB_DADOS_E_VALORES] VN
		WHERE VN.ID = CS.ID_VALORES_30
		) AS ID_FORNECEDOR

		,(
		SELECT ISNULL(VN.SALDO_FX_ENT,0) + ISNULL(VN.SALDO_PDD,0) AS SOMA_FXE_PDD_30
		FROM [CONSOLIDADO].[TB_DADOS_E_VALORES] VN
		WHERE VN.ID = CS.ID_VALORES_30
		) AS SOMA_FXE_PDD_30		



		--,VN.SALDO_CAR													AS SALDO_CAR_30
		--,ISNULL(VN.SALDO_FX_ENT,0) + ISNULL(VN.SALDO_PDD,0)				AS SOMA_FXE_PDD_30
		
		--LEFT  JOIN  [CONSOLIDADO].[TB_DADOS_E_VALORES]  	V1	ON CS.ID_VALORES_26			= V1.ID
		--LEFT  JOIN  [CONSOLIDADO].[TB_DADOS_E_VALORES]  	V2	ON CS.ID_VALORES_05			= V2.ID
		--LEFT  JOIN  [CONSOLIDADO].[TB_DADOS_E_VALORES]  	V3	ON CS.ID_VALORES_14			= V3.ID
		--LEFT  JOIN  [CONSOLIDADO].[TB_DADOS_E_VALORES]  	V4	ON CS.ID_VALORES_21			= V4.ID
		--LEFT  JOIN  [CONSOLIDADO].[TB_DADOS_E_VALORES]  	V5	ON CS.ID_VALORES_25			= V5.ID
		--LEFT  JOIN  [CONSOLIDADO].[TB_DADOS_E_VALORES]  	VA	ON CS.ID_VALOR_ATUAL		= VA.ID
		--LEFT  JOIN  [CONSOLIDADO].[TB_DADOS_E_VALORES]  	VN	ON CS.ID_VALORES_30			= VN.ID		
		

		--TB_TIPO_PAGAMENTO
		--================================================================================		
	/*
		,(
		SELECT VN.SALDO_CAR		AS SALDO_CAR_30
		FROM [CONSOLIDADO].[TB_DADOS_E_VALORES] VN
		WHERE VN.ID = CS.ID_VALORES_30
		) AS ID_FORNECEDOR

		,(
		SELECT ISNULL(VN.SALDO_FX_ENT,0) + ISNULL(VN.SALDO_PDD,0) AS SOMA_FXE_PDD_30
		FROM [CONSOLIDADO].[TB_DADOS_E_VALORES] VN
		WHERE VN.ID = CS.ID_VALORES_30
		) AS SOMA_FXE_PDD_30
*/


		,ISNULL(PG.VALOR_PAGTO,0)										AS VALOR_PAGAMENTO
		,ISNULL(PG.VALOR_AJUSTE,0)										AS VALOR_AJUSTE
		,PG.dt_atrib
		LEFT  JOIN	[AUXILIAR].[TB_PAGTO_AJUSTE]			PG  ON CS.ID_PGTO_AJUSTE		= PG.ID

		--TB_TIPO_PAGAMENTO
		--================================================================================		
		
		
		
		

	
		
		--TB_TIPO_PAGAMENTO
		--================================================================================		
		
		,SG.SEGMENTO		AS AREA_ATUACAO
		INNER JOIN  [AUXILIAR].[TB_SEGMENTO]				SG	ON SG.ID					= C.ID_SEGMENTO
		
		--TB_TIPO_PAGAMENTO
		--================================================================================		

		,SC.ID					AS ID_ESCALATION
		,SC.DESCRICAO_STATUS
		LEFT  JOIN  [AUXILIAR].[TB_STATUS_ESCALATION]   	SC	ON CS.ID_STATUS_ESCALATION  = SC.ID
		
		--TB_TIPO_PAGAMENTO
		--================================================================================		
		
		,A.gestor				AS ID_LIDER
		,A.gestor2				AS ID_COOREDENADOR 	
		LEFT  JOIN  [APP_WEB].[TBL_AREAS]					A	ON AN.area					= A.id_area
		
		--TB_TIPO
		--================================================================================		
		
		,TP.ID					AS ID_TIPO	
		INNER JOIN  [AUXILIAR].[TB_TIPO]					TP  ON C.ID_TIPO                = TP.ID



  FROM 
					[CONSOLIDADO].[TB_CONSUMO_SISCOB]		CS
		INNER JOIN  [CONSOLIDADO].[TB_CONSOLIDADO]			C	ON C.ID						= CS.ID_CONSOLIDADO 
		
		
		INNER JOIN	[AUXILIAR].[TB_PERIODO]					P   ON P.ID						= C.ID_PERIODO
		LEFT  JOIN	[AUXILIAR].[TB_JURIDICO]				J   ON CS.ID_JURIDICO			= J.ID
			

		WHERE
		C.ID_PERIODO = (SELECT MAX(ID) FROM [AUXILIAR].[TB_PERIODO])
