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
  FROM [DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[tmp_ATELECOM]

  update [DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[tmp_ATELECOM] 
  set 
	[VlMovimento] = replace([VlMovimento],',','.')
	,[VlCorrecao] = replace([VlCorrecao],',','.')


  	SELECT 
		AJUSTE.[NotaFiscal] AS CONTA
		, ISNULL(AJUSTE.[DtMovimento],0) AS DT_CORTE
		,CASE 
			WHEN 
				ISNULL(AJUSTE.[VlCorrecao],0) > 0  THEN 0
			ELSE 
				ISNULL(AJUSTE.[VlMovimento],0) 
		END AS VALOR_PAGTO
		--, SUM(ISNULL(AJUSTE.VALOR_FAT,0)) AS VALOR_PAGTO
		--, ISNULL(AJUSTE.[VlCorrecao],0)  AS VALOR_AJUSTE
		, CONCAT(AJUSTE.[NotaFiscal], CONVERT(DATE,AJUSTE.[DtMovimento]),ISNULL(REPLACE(AJUSTE.[VlMovimento],'.',''),'')) AS CHAVE
		--INTO [DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[ATELECOM]
	FROM
		[DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[tmp_ATELECOM] AJUSTE
		--WHEN TI.ID_TIPO = 2 Then ISNULL(FI.TITULO,'') + ISNULL(FI.DTCONTA ,'') + TI.RAIZ_CPF_CNPJ