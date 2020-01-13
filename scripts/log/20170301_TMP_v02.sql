SELECT  top 10
	[Titulo]
	,[CodCliente]
	,[LojaCliente]
	--,Sum(convert(decimal(10,2), [VlJuros])) AS SomaDeVlJuros 
	,Sum(convert(decimal(10,2), [VlMulta])) AS SomaDeVlMulta 
	,Sum(convert(decimal(10,2), [VlCorrecao])) AS SomaDeVlCorrecao 
	,Sum(convert(decimal(10,2), [VlDesconto])) AS SomaDeVlDesconto 
	,Sum(convert(decimal(10,2), [VlMovimento])) AS SomaDeVlMovimento 
FROM [DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[tmp_TELECOM_v02]
group by
	[Titulo]
	,[CodCliente]
	,[LojaCliente]



select *
FROM [DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[tmp_TELECOM_v02] 
  where titulo in (
  'DAW000011',
'V43008364'
  )

group by [VlJuros]
order by [VlJuros] 