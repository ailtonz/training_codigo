DECLARE @TMP VARCHAR(MAX)

SET @TMP ='INSERT INTO [CONSOLIDADO].[TB_HISTORICO] 
	 (
		[ID_CONSOLIDADO]
	   ,[ID_SEMANA]
	   ,[ID_FOCO_FEEDBACK]
	   ,[ID_TIPO_PAGAMENTO]
	   ,[ID_ANALISTA]
	   ,[TIME_STAMP]
	   ,[DT_FOLLOW]
	   ,[DT_CONTATO]
	   ,[DT_PAGAMENTO]
	   ,[VALOR_PAGO]
	   ,[VALOR_AJUSTE]   
	   ,[RESPONSAVEL]
	   ,[RE_PROBLEMA]
	   ,[RE_ACAO]
	   ,[HISTORICO_DETALHADO]
	   ,[CBPM]
	   ,[ID_PORTAL_DEMANDA]
	   ,[NUMERO_BOLETO]
	   ,[DATA_EMISSAO_BOLETO]
	   ,[ID_GESTAO_CONTA]
	   ,[OBS]
	 )
	 SELECT
		 ID
		,(SELECT ID FROM AUXILIAR.TB_STATUS_CAR WHERE STATUS = 1)
		, CONVERT(bigint, 10 ) 
		, CONVERT(bigint, 1) 
		,9
		,GETDATE()
		, CONVERT(date, 2017-02-10, 103)
		, CONVERT(date, 2017-02-08, 103) 
		, CONVERT(date, 2017-02-08,  103)
		,[SALDO_CAR]
		,0
		,Replace(Responsável,'';'','')
		,Replace(Descrição do Problema,'';'','')			
		,Replace(Plano de Ação,'';'','')			
		,CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE())) + ' - ' + Replace(Historico Detalhado ,'';'','')
		,null
		,CONVERT(bigint, ''null'')
		,CONVERT(bigint, ''null'')
		,CONVERT(date,''null'', 103)
		,CONVERT(bigint, ''null'') 
		,Replace(''##### AILTON ####'','';'','')
	 FROM
		[APP_WEB].[VW_FILTRO_DINAMICO] WHERE ( ID_ANALISTA = 9 OR ID_ANALISTA_TMP = 9) AND RAIZ_GRUPO = ''4060701190'' and ID_TIPO IN (7,9) and ID_AREA_OFENSORA IN (1,2,3,7)
'

EXEC @TMP