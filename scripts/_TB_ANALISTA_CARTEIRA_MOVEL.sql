USE [DB_SISCOB]
GO

INSERT INTO [AUXILIAR].[TB_ANALISTA_CARTEIRA_MOVEL]
           ([RAIZ]
           ,[RAZAO_SOCIAL]
           ,[RAIZ_GRUPO]
           ,[NOME_GRUPO]
           ,[GN]
           ,[GV]
           ,[DIRETOR]
           ,[SEGMENTO_CARTEIRA]
           ,[TASK_FORCE]
           ,[ID_ANALISTA]
           ,[ID_ANALISTA_TMP]
           ,[DT_ATUALIZACAO]
           ,[STATUS]
           ,[ID_USER_ATUALIZACAO])
SELECT 
      [RAIZ]
      ,[RAZAO_SOCIAL]
      ,[RAIZ_GRUPO]
      ,[NOME_GRUPO]
      ,[GN]
      ,[GV]
      ,[DIRETOR]
      ,[SEGMENTO_CARTEIRA]
      ,[TASK_FORCE]
      ,[ID_ANALISTA]
      ,[ID_ANALISTA_TMP]
      ,[DT_ATUALIZACAO]
      ,[STATUS]
	  ,[ID_USER_ATUALIZACAO]
  FROM [DB_SISCOB].[TRANSITO].[tmp_TB_ANALISTA_CARTEIRA_MOVEL]
GO


