/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [id]
      ,[NM_ARQUIVO]
      ,[DIRETORIO]
      ,[QUERY_RESUMO]
      ,[ID_ANALISTA]
      ,[DATA_SOLICITACAO]
  FROM [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_SEGMENTO] order by id desc;


 -- update s
 -- set 
	--s.nm_arquivo = '1VPE.xml'
	--,s.diretorio = '//172.16.0.11/siscob/SEGMENTO/'
	--,s.QUERY_RESUMO = ''
 -- FROM [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_SEGMENTO] s
 -- where id=8;

 --delete from [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_SEGMENTO] where id=9

  SELECT TOP 1 [NM_ARQUIVO],[DIRETORIO],[QUERY_RESUMO] FROM [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_SEGMENTO] WHERE [ID_ANALISTA] = 1 ORDER BY ID DESC;