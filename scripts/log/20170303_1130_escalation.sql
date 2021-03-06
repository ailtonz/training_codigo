/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[DESCRICAO_STATUS]
  FROM [DB_SISCOB_HML].[AUXILIAR].[TB_STATUS_ESCALATION]

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[RAIZ_GRUPO]
      ,[ID_USER_1_NIVEL]
      ,[QTDE_DIAS_1_NIVEL]
      ,[ID_USER_2_NIVEL]
      ,[QTDE_DIAS_2_NIVEL]
      ,[ID_USER_3_NIVEL]
      ,[QTDE_DIAS_3_NIVEL]
      ,[INATIVO]
      ,[DT_CADASTRO]
      ,[DT_ALTERACAO]
      ,[USER_ALTER]
  FROM [DB_SISCOB_HML].[AUXILIAR].[TB_CADASTRO_ESCALATION]

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[ID_CADASTRO]
      ,[DT_ENVIO]
  FROM [DB_SISCOB_HML].[AUXILIAR].[TB_LOG_ENVIO_EMAIL]


  /****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[RAIZ_GRUPO_S_N]
      ,[RAIZES]
      ,[EMAIL]
      ,[ID_ANALISTA]
      ,[DT_CADASTRO]
      ,[INATIVO]
      ,[PERIODICIDADE_DIAS]
      ,[RAIZ_GRUPO]
      ,[DT_INATIVO]
      ,[ID_ANALISTA_INATIVOU]
      ,[DT_ALTERACAO]
      ,[ID_ANALISTA_ALTERACAO]
      ,[HistoricoAc]
      ,[DT_INICIANDO_EM]
      ,[SUSPENSO]
      ,[SEGMENTO_ID]
  FROM [DB_SISCOB_HML].[AUXILIAR].[TB_CADASTRO_ENVIO_EMAIL] where id=20