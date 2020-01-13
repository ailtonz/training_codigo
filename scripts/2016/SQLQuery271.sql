/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[PROCESSO_CAR]
      ,[NOME_ARQUIVO]
      ,[CAR_PERIODO]
      ,[STATUS]
      ,[DT_PROCESSAMENTO]
      ,[DT_PROCESSAMENTO_FIM]
  FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR]

  update [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR] set [NOME_ARQUIVO] = '[FILE_CAR].[FILE_CAR].[PRC_001_REGRA_ENREQUECIMENTO_FIXA_WEB]' where id = 28

  update [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR] set STATUS = 0 where id > 25

  