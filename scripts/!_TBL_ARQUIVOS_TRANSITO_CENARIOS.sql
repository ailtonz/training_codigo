/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [id]
      ,[nm_arquivo]
      ,[diretorio]
      ,[inativo]
      ,[QUERY_RESUMO]
      ,[ID_ANALISTA]
      ,[DATA_SOLICITACAO]
  FROM [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_CENARIOS]
  WHERE nm_arquivo LIKE '%4005014109%'
  ORDER BY ID DESC