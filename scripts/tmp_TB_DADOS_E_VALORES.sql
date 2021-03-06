/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[ID_CONSOLIDADO]
      ,[ID_STATUS_CAR]
      ,[PROCV]
      ,[SALDO_CAR]
      ,[SALDO_PDD]
      ,[SALDO_FX_ENT]
      ,[SALDO_TERCEIROS]
      ,[SALDO_WO]
      ,[NV_FX_FECHO]
      ,[NV_FX_FORNECE]
      ,[NV_FX_ARRECADA]
      ,[QTD_REG_AGRUPADO]
      ,[AGING_ATUAL]
      ,[AGING_ORIGINAL]
      ,[FAIXA_ATUAL]
      ,[FAIXA_ORIGINAL]
      ,[VENC_ATUAL]
      ,[VENC_ORIGINAL]
      ,[AGING_CORTE]
      ,[FAIXA_CORTE]
      ,[SEG_DESCR]
      ,[ID_NV_FX_FECHO]
      ,[ID_NV_FX_FORNECE]
      ,[ID_NV_FX_ARRECADA]
  FROM [DB_SISCOB].[TRANSITO].[tmp_TB_DADOS_E_VALORES]


  
--DROP TABLE [DB_SISCOB].[TRANSITO].[tmp_TB_DADOS_E_VALORES]
--GO

--CREATE TABLE [DB_SISCOB].[TRANSITO].[tmp_TB_DADOS_E_VALORES] (
--[ID] bigint NOT NULL,
--[ID_CONSOLIDADO] bigint,
--[ID_STATUS_CAR] bigint,
--[PROCV] varchar(100),
--[SALDO_CAR] decimal(18,2),
--[SALDO_PDD] decimal(18,2),
--[SALDO_FX_ENT] decimal(18,2),
--[SALDO_TERCEIROS] decimal(18,2),
--[SALDO_WO] decimal(18,2),
--[NV_FX_FECHO] varchar(20),
--[NV_FX_FORNECE] varchar(20),
--[NV_FX_ARRECADA] varchar(20),
--[QTD_REG_AGRUPADO] bigint,
--[AGING_ATUAL] varchar(50),
--[AGING_ORIGINAL] varchar(50),
--[FAIXA_ATUAL] varchar(50),
--[FAIXA_ORIGINAL] varchar(50),
--[VENC_ATUAL] date,
--[VENC_ORIGINAL] date,
--[AGING_CORTE] varchar(30),
--[FAIXA_CORTE] varchar(30),
--[SEG_DESCR] varchar(20),
--[ID_NV_FX_FECHO] int,
--[ID_NV_FX_FORNECE] int,
--[ID_NV_FX_ARRECADA] int
--)
--GO
