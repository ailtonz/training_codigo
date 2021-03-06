/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[ID_CONSOLIDADO]
      ,[ID_SEMANA]
      ,[ID_FOCO_FEEDBACK]
      ,[ID_TIPO_PAGAMENTO]
      ,[ID_ANALISTA]
      ,[TIME_STAMP]
      ,[DT_FOLLOW]
      ,[DT_CONTATO]
      ,[DT_ENCERRAMENTO]
      ,[DT_ABERTURA]
      ,[DT_AJUSTE]
      ,[DT_PAGAMENTO]
      ,[VALOR_PAGO]
      ,[VALOR_AJUSTE]
      ,[LOTE]
      ,[GESTAO_CONTA]
      ,[RESPONSAVEL]
      ,[RESUMO_EXECUTIVO]
      ,[HISTORICO_DETALHADO]
      ,[STATUS]
      ,[RE_PROBLEMA]
      ,[RE_ACAO]
      ,[HD_ACUMULADO]
      ,[CBPM]
      ,[ID_PORTAL_DEMANDA]
      ,[NUMERO_BOLETO]
      ,[DATA_EMISSAO_BOLETO]
  FROM [DB_SISCOB].[TRANSITO].[tmp_TB_HISTORICO_v161121_1815]

-- [6] UPLOAD -> (24139896 row(s) affected) -> 00:04:57
BULK INSERT [DB_SISCOB].[TRANSITO].[tmp_TB_HISTORICO_v161121_1815]
FROM 'Z:\_siscob\_TRANSITO\161121\TB_HISTORICO\TB_HISTORICO.TXT'
WITH
(
	FIRSTROW = 1,
	FIELDTERMINATOR = ';',  --CSV field delimiter
	ROWTERMINATOR = '\n',   --Use to shift the control to next row
	TABLOCK
)
