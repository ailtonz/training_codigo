/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1 [ID]
      ,[ID_IMPORT_FIXA]
      ,[ID_FX_FECHO]
      ,[ID_FX_ARRECADA]
      ,[SPEEDY_PROVIDER]
      ,[LOCAL]
      ,[TERMINAL]
      ,[DV]
      ,[ID_TIPO]
      ,[PROCV]
      ,[NUMERO_LOTE]
      ,[DIA_VENCIMENTO]
      ,[VALOR_LOTE]
      ,[INTRAGOV]
      ,[INTERCOMPANY]
      ,[QTD_REG_AGRUPADO]
      ,[SALDO_CAR]
      ,[SALDO_PDD]
      ,[SALDO_FX_ENT]
      ,[SALDO_TERCEIROS]
      ,[SALDO_WO]
      ,[OK]
      ,[RAIZ_GRUPO]
      ,[NOME_GRUPO]
      ,[RAZAO_SOCIAL]
      ,[RAIZ_CPF_CNPJ]
      ,[TASK_FORCE]
      ,[GN]
      ,[GV]
      ,[DIRETOR]
      ,[NRC]
      ,[N_DOC_DE_PARA_ATLYS]
      ,[SITUACAO_SERVICO]
      ,[CHECK_CAR]
      ,[ID_NEW]
	  into  [DB_SISCOB].[TRANSITO].[tmp_TB_TRATAMENTO_FIXA_v161121_1218]
  FROM [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA]

--################################################################

  --truncate table [DB_SISCOB].[TRANSITO].[tmp_TB_TRATAMENTO_FIXA_v161121_1218]

--################################################################

   select * from [DB_SISCOB].[TRANSITO].[tmp_TB_TRATAMENTO_FIXA_v161121_1218]

--################################################################

   SET IDENTITY_INSERT [DB_SISCOB].[TRANSITO].[tmp_TB_TRATAMENTO_FIXA_v161121_1218] off

--################################################################

BULK INSERT [DB_SISCOB].[TRANSITO].[tmp_TB_TRATAMENTO_FIXA_v161121_1218]
FROM 'Z:\_siscob\_TRANSITO\161121\TB_TRATAMENTO_FIXA\TB_TRATAMENTO_FIXA.TXT'
WITH
(
FIRSTROW = 1,
FIELDTERMINATOR = ';',  --CSV field delimiter
ROWTERMINATOR = '\n',   --Use to shift the control to next row
TABLOCK
)

--################################################################

SELECT BulkColumn
FROM OPENROWSET (BULK 'Z:\_siscob\_TRANSITO\161121\TB_TRATAMENTO_FIXA\TB_TRATAMENTO_FIXA.TXT', SINGLE_CLOB) MyFile

--################################################################


CREATE TABLE [DB_SISCOB].[TRANSITO].[tmp_TB_TRATAMENTO_FIXA_v161121_1218](
	[ID] [bigint] NOT NULL,
	[ID_IMPORT_FIXA] [bigint] NOT NULL,
	[NV_FX_FECHO] [varchar](20) NULL,
	[NV_FX_ARRECADA] [varchar](20) NULL,
	[SPEEDY_PROVIDER] [char](3) NULL,
	[LOCAL] [varchar](5) NULL,
	[TERMINAL] [varchar](10) NULL,
	[DV] [char](1) NULL,
	[TIPO] [varchar](15) NULL,
	[PROCV] [varchar](100) NULL,
	[NUMERO_LOTE] [varchar](20) NULL,
	[DIA_VENCIMENTO] [char](2) NULL,
	[VALOR_LOTE] [decimal](18, 2) NULL,
	[INTRAGOV] [char](3) NULL,
	[INTERCOMPANY] [char](3) NULL,
	[QTD_REG_AGRUPADO] [bigint] NULL,
	[SALDO_CAR] [decimal](18, 2) NULL,
	[SALDO_PDD] [decimal](18, 2) NULL,
	[SALDO_FX_ENT] [decimal](18, 2) NULL,
	[SALDO_TERCEIROS] [decimal](18, 2) NULL,
	[SALDO_WO] [decimal](18, 2) NULL,
	[OK] [char](3) NULL,
	[RAIZ_GRUPO] [varchar](20) NULL,
	[NOME_GRUPO] [varchar](100) NULL,
	[RAZAO_SOCIAL] [varchar](100) NULL,
	[RAIZ_CPF_CNPJ] [varchar](10) NULL,
	[TASK_FORCE] [char](3) NULL,
	[GN] [varchar](100) NULL,
	[GV] [varchar](100) NULL,
	[DIRETOR] [varchar](100) NULL,
	[NRC] [varchar](11) NULL,
	[N_DOC_DE_PARA_ATLYS] [varchar](100) NULL,
	[SITUACAO_SERVICO] [varchar](30) NULL,
) ON [PRIMARY]