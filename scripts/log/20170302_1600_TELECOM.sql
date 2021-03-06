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


--#######################################
--#######################################
--#######################################


SELECT 
	concat(convert(varchar(20),serie), convert(varchar(20),NotaFiscal) , convert(varchar(20),Parcela)) AS Titulo
	,CodCliente
	,LojaCliente
	,DtMovimento
	,[DTmovimento] AS DATA_MOVIMENTO

	,REPLACE(CONVERT(VARCHAR(20), VlJuros), ',', '.')  AS VlJuros
	,REPLACE(CONVERT(VARCHAR(20), VlMulta), ',', '.')  AS VlMulta
	,REPLACE(CONVERT(VARCHAR(20), VlCorrecao), ',', '.')  AS VlCorrecao
	,REPLACE(CONVERT(VARCHAR(20), VlDesconto), ',', '.')  AS VlDesconto
	,REPLACE(CONVERT(VARCHAR(20), VlMovimento), ',', '.')  AS VlMovimento
	
	--,Sum([VlMovimento] - [VlDesconto] - [VlCorrecao] - [VlMulta] - [Vljuros]) AS VlPago

INTO  [DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[tmp_TELECOM_v02]
FROM [DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[tmp_TELECOM]

SELECT TOP 10 * FROM [DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[tmp_TELECOM_v02]

--#######################################
--#######################################
--#######################################

SELECT  
	[Titulo]
	,[CodCliente]
	,[LojaCliente]
	--,Sum(convert(decimal(10,2), ISNULL([VlJuros],0))) AS SomaDeVlMulta 
	--, Sum(CAST(ISNULL([VlJuros],0) AS DECIMAL(10,2))) AS SomaDeVlMulta 

	--,Sum(convert(decimal(10,2), [VlMulta])) AS SomaDeVlMulta 
	,Sum(convert(decimal(10,2), [VlCorrecao])) AS SomaDeVlCorrecao 
	--,Sum(convert(decimal(10,2), [VlDesconto])) AS SomaDeVlDesconto 
	--,Sum(convert(decimal(10,2), [VlMovimento])) AS SomaDeVlMovimento 
FROM [DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[tmp_TELECOM_v02]
group by
	[Titulo]
	,[CodCliente]
	,[LojaCliente]




