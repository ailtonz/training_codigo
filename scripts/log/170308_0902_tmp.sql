 -- update [DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[tmp_ATELECOM] 
 -- set 
	--[VlMovimento] = replace([VlMovimento],',','.')
	--,[VlCorrecao] = replace([VlCorrecao],',','.')
	--,[VlDesconto] = replace([VlDesconto],',','.')


SELECT 
	AJUSTE.NotaFiscal AS CONTA
	, ISNULL(AJUSTE.DtMovimento,0) AS DT_CORTE
	,CASE 
		WHEN 
			convert(decimal(10,2),AJUSTE.VlCorrecao) + convert(decimal(10,2),AJUSTE.VlDesconto) > 0  THEN 0
		ELSE 
			convert(decimal(10,2),AJUSTE.VlMovimento)
	END AS VALOR_PAGTO

	, convert(decimal(10,2),AJUSTE.VlCorrecao) + convert(decimal(10,2),AJUSTE.VlDesconto)  AS VALOR_AJUSTE
	, CONCAT(AJUSTE.NotaFiscal, AJUSTE.CodCliente, AJUSTE.LojaCliente) AS CHAVE

	--INTO [DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[ATELECOM]

FROM
	[DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[tmp_ATELECOM] AJUSTE

	--alter table [DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[tmp_ATELECOM] alter table VlDesconto 