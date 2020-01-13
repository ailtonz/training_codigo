USE [DB_SISCOB]
GO

INSERT INTO [AUXILIAR].[TB_ANALISTA_CARTEIRA_FIXA]
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
           )
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
      ,getdate() as DT_ATUALIZACAO
      ,[STATUS]
  FROM [DB_SISCOB].[TRANSITO].[tmp_TB_ANALISTA_CARTEIRA_FIXA]


GO


