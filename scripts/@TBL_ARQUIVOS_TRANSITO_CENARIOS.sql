/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [id]
      ,[nm_arquivo]
      ,[diretorio]
      ,[inativo]
	  ,[QUERY_RESUMO]
 FROM [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_CENARIOS] order by [id] desc--where [QUERY_RESUMO] is not null


  --INSERT INTO [APP_WEB].[TBL_ARQUIVOS_TRANSITO_CENARIOS]
  --         ([nm_arquivo]
  --         ,[diretorio]
  --         )
  --   VALUES
  --         ('CENARIO_MODELO.xlsx'
  --         ,'\\172.16.0.11\siscob\CENARIO/'
  --         )






--USE [DB_SISCOB]
--GO

--/****** Object:  Table [APP_WEB].[TBL_ARQUIVOS]    Script Date: 11/23/2016 9:54:34 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--SET ANSI_PADDING ON
--GO

--CREATE TABLE [APP_WEB].[TBL_ARQUIVOS_TRANSITO_CENARIOS](
--	[id] [int] IDENTITY(1,1) NOT NULL,
--	[nm_arquivo] [varchar](300) NULL,
--	[diretorio] [varchar](300) NULL,
--	[inativo] [int] NULL,
--PRIMARY KEY CLUSTERED 
--(
--	[id] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]

--GO

--SET ANSI_PADDING OFF
--GO


