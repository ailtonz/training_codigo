USE [DB_SISCOB]
GO

INSERT INTO [CONSOLIDADO].[TB_DADOS_E_VALORES]
           ([ID_CONSOLIDADO]
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
           ,[ID_NV_FX_ARRECADA])

SELECT 
      [ID_CONSOLIDADO]
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



GO


