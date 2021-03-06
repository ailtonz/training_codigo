/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 
FORNECEDOR
,i.DT_PROCESS
		,w.[ID]
      ,[ID_IMPORT_MOVEL]
      ,[PROCV]
      ,[ID_FX_FECHO]
      ,[ID_FX_FORNECE]
      ,[ID_FX_ARRECADA]
      ,[GRUPO_ANALISE]
      ,[INTERCOMPANY]
      ,[QTD_REG_AGRUPADO]
      ,w.[SALDO_CAR]
      ,w.[SALDO_PDD]
      ,w.[SALDO_FX_ENT]
      ,w.[AGING_ATUAL]
      ,w.[AGING_ORIGINAL]
      ,w.[FAIXA_ATUAL]
      ,w.[FAIXA_ORIGINAL]
      ,w.[VENC_ATUAL]
      ,w.[VENC_ORIGINAL]
      ,w.[AGING_CORTE]
      ,w.[FAIXA_CORTE]
      ,[MC]
      ,[MC2]
      ,[DIAS_POST]
      ,[MAIOR_01_COBRAVEL]
      ,[SEGMENTO_GERENCIA]
      ,[ANOMES]
      ,[ANALISE_CONTA]
      ,[CARTEIRA]
      ,[FORNECEDOR]
      ,[ANALISTA_TLF_VIVO]
      ,[OK]
      ,[RAIZ_GRUPO]
      ,w.[RAIZ_CPF_CNPJ]
      ,[NOME_GRUPO]
      ,[RAZAO_SOCIAL]
      ,[TASK_FORCE]
      ,[GN]
      ,[GV]
      ,[DIRETOR]
      ,[SITUACAO_SERVICO]
      ,[CHECK_CAR]
  FROM 
  
  [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL_WEB] W
  inner join [DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT] i on w.ID_IMPORT_MOVEL = i.id

  where w.OK = 1
  and i.CONTA = '0030936416'