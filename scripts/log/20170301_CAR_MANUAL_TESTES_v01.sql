--update [DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[TMP_CAR_MANUAL_v06]
--  set [Valor_Fat_2] = [Valor_Fat]

--drop table  [DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[CAR_MANUAL_v06]
--SELECT 
--	AJUSTE.NF AS CONTA
--	, ISNULL(AJUSTE.[Emissao],0) AS DT_CORTE
--	,CASE 
--		WHEN 
--			ISNULL(AJUSTE.Canc,0) > 0  THEN 0
--		ELSE 
--			ISNULL(AJUSTE.VALOR_FAT,0) 
--	END AS VALOR_PAGTO
--	, ISNULL(AJUSTE.Canc,0)  AS VALOR_AJUSTE
--	, CONCAT(REPLICATE('0',8-LEN(AJUSTE.Raiz)),AJUSTE.Raiz, REPLICATE('0',10-LEN(AJUSTE.[nf])),AJUSTE.[nf], RIGHT(CONVERT(CHAR(10),AJUSTE.[Emissao],103),7),AJUSTE.VALOR_FAT) AS CHAVE

--	--, CONCAT(REPLICATE('0',8-LEN(AJUSTE.Raiz)),AJUSTE.Raiz, REPLICATE('0',10-LEN(AJUSTE.[nf])),AJUSTE.[nf], RIGHT(CONVERT(CHAR(10),AJUSTE.[Emissao],103),7),ISNULL(REPLACE(AJUSTE.VALOR_FAT,'.',''),'')) AS CHAVE
--INTO [DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[CAR_MANUAL_v06]
--FROM
--[DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[TMP_CAR_MANUAL_v06] AJUSTE

--alter schema TRANSITO_PAGAMENTO_AJUSTE transfer transito.TMP_CAR_MANUAL_v06

/****** PAGAMENTO E AJUSTES  ******/
SELECT 
	[CONTA]
	,[DT_CORTE]
	,[CHAVE] 
	,[VALOR_PAGTO] as [VALOR_PAGTO]
	,[VALOR_AJUSTE] as [VALOR_AJUSTE]
FROM 
[DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[CAR_MANUAL_v06]
where 
[VALOR_PAGTO] = '2379650.01' --- 88888881000000005104/20152379650,01


/****** CONSOLIDADO  ******/
SELECT TOP 1000 [ID],[ID_SEGMENTO],[SEG_DESCR]
	,[NOTA_FISCAL]
	,[CONTA]
	,[PROCV]
	,[SALDO_CAR]
	FROM [DB_SISCOB].[CONSOLIDADO].[TB_CONSOLIDADO]
	WHERE  ID_TIPO=3 and [SEG_DESCR] not like '%VPG%'
	AND NOTA_FISCAL='0000000051'