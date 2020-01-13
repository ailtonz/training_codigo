	--SELECT 
	--	AJUSTES.CONTA AS CONTA
	--	, MAX(AJ_ATLYS.DATA) AS DT_CORTE
	--	, Sum(AJUSTES.Valor) AS VALOR_AJUSTE
	--	, CONCAT(AJUSTES.SERIE,AJUSTES.NotaFiscal,AJUSTES.Parcela, AJUSTES.codCliente,AJUSTES.LojaCliente) AS CHAVE 
	--	INTO [DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[TELECOM]
	--FROM
	--	[DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[tmp_TELECOM] AJUSTES
	--GROUP BY 
	--	AJUSTES.CONTA
	--	,AJUSTES.[PROCESS]

--WHEN TI.ID_TIPO = 2 Then ISNULL(FI.TITULO,'') + ISNULL(FI.DTCONTA ,'') + TI.RAIZ_CPF_CNPJ

--,Right([DTmovimento], 2) & "/" & Mid([DtMovimento], 5, 2) & "/" & Left([dtMovimento], 4) AS DATA_MOVIMENTO

SELECT concat([serie], [NotaFiscal] , [Parcela]) AS Titulo
	,CodCliente
	,LojaCliente
	,DtMovimento
	,[DTmovimento] AS DATA_MOVIMENTO
	,Sum(VlJuros) AS SomaDeVlJuros
	,Sum(VlMulta) AS SomaDeVlMulta
	,Sum(VlCorrecao) AS SomaDeVlCorrecao
	,Sum(VlDesconto) AS SomaDeVlDesconto
	,Sum(VlMovimento) AS SomaDeVlMovimento
	,Sum([VlMovimento] - [VlDesconto] - [VlCorrecao] - [VlMulta] - [Vljuros]) AS VlPago

-- INTO 00_PAGAMENTOS_AJUSTES_ATELECOM_AGRUPADO

FROM [DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[tmp_TELECOM]

GROUP BY concat([serie], [NotaFiscal] , [Parcela])
	,CodCliente
	,LojaCliente
	,DtMovimento
	,[DTmovimento]
HAVING (((DtMovimento) > '20161221') AND ((Sum(VlMovimento)) > 0));