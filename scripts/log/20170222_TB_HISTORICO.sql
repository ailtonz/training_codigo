/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[ID_CONSOLIDADO]
      ,[ID_SEMANA]
      ,[ID_FOCO_FEEDBACK]
      ,[ID_TIPO_PAGAMENTO]
      ,[ID_ANALISTA]
      ,[TIME_STAMP]
      ,[DT_FOLLOW]
      ,[DT_CONTATO]
      ,[DT_ENCERRAMENTO]
      ,[DT_ABERTURA]
      ,[DT_AJUSTE]
      ,[DT_PAGAMENTO]
      ,[VALOR_PAGO]
      ,[VALOR_AJUSTE]
      ,[LOTE]
      ,[GESTAO_CONTA]
      ,[RESPONSAVEL]
      ,[RESUMO_EXECUTIVO]
      ,[HISTORICO_DETALHADO]
      ,[STATUS]
      ,[RE_PROBLEMA]
      ,[RE_ACAO]
      ,[HD_ACUMULADO]
      ,[CBPM]
      ,[ID_PORTAL_DEMANDA]
      ,[NUMERO_BOLETO]
      ,[DATA_EMISSAO_BOLETO]
      ,[OBS]
      ,[ID_GESTAO_CONTA]
      ,[Periodo_Ativo]
  FROM [DB_SISCOB].[CONSOLIDADO].[TB_HISTORICO]
  where ID_CONSOLIDADO='7420818'
  order by id desc


 
 