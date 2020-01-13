/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[PROCESSO_CAR]
      ,[NOME_ARQUIVO]
      ,[CAR_PERIODO]
      ,[STATUS]
      ,[DT_PROCESSAMENTO]
      ,[DT_PROCESSAMENTO_FIM]
  FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR]  
  
  --where [PROCESSO_CAR] like  '%DESCOMPACTACAO_CAR%'

  order by id desc

-- #############
-- START INICIAL 
-- #############

INSERT INTO [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR] 
(
		[PROCESSO_CAR]
	,[NOME_ARQUIVO]
	,[CAR_PERIODO]
	,[STATUS]
	,[DT_PROCESSAMENTO]
)

VALUES
('DESCOMPACTACAO_CAR'
	,(SELECT 'PROCESSAMENTO_20170226.7Z' as NOME_ARQUIVO )
	,(SELECT '26' as CAR_PERIODO)
	,0
	,GETDATE()
)











