USE [DB_SISCOB]
GO

INSERT INTO [AUXILIAR].[TB_PAGTO_AJUSTE]
           ([VALOR_PAGTO]
           ,[VALOR_AJUSTE]
           ,[CONTA]
           ,[DT_PROCESS]
           ,[DT_IMPORTACAO]
           ,[dt_atrib])
SELECT 
      [VALOR_PAGTO]
      ,[VALOR_AJUSTE]
      ,[CONTA]
      ,[DT_PROCESS]
      ,[DT_IMPORTACAO]
      ,[dt_atrib]
  FROM [DB_SISCOB].[TRANSITO].[tmp_TB_PAGTO_AJUSTE]
GO


