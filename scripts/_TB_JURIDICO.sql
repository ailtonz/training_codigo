USE [DB_SISCOB]
GO

INSERT INTO [AUXILIAR].[TB_JURIDICO]
           ([RAIZ]
           ,[CONTA]
           ,[POLO_ATIVO_PASSIVO]
           ,[DT_IMPORTACAO]
           ,[CHAVE])
SELECT 
      [RAIZ]
      ,[CONTA]
      ,[POLO_ATIVO_PASSIVO]
      ,[DT_IMPORTACAO]
      ,[CHAVE]
  FROM [DB_SISCOB].[TRANSITO].[tmp_TB_JURIDICO]
GO


