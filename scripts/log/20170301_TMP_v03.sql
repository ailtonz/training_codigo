/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Filial]
      ,[CodCliente]
      ,[LojaCliente]
      ,[NotaFiscal]
      ,[Serie]
      ,[Parcela]
      ,[Tipo]
      ,[TipoDoc]
      ,[RecPag]
      ,[DtMovimento]
      ,[DtDigitacao]
      ,[MotBaixa]
      ,[Historico]
      ,[CodBanco]
      ,[CodAgencia]
      ,[CodConta]
      ,[VlJuros]
      ,[VlMulta]
      ,[VlCorrecao]
      ,[VlDesconto]
      ,[VlMovimento]
      ,[DtGeracao]
  FROM [DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[tmp_TELECOM]
  where titulo in (
  'DAW000011',
'V43008364'
  )