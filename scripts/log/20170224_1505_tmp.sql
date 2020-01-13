SELECT top 10
	PG_ATLYS.Conta
	, Max(PG_ATLYS.dt_atribuicao) AS MaxDedt_atribuicao
	, Sum(PG_ATLYS.Valor) AS SomaDeValor
	--, PG_ATLYS.recebivel
	, PG_ATLYS.dt_corte
	, 4 AS TIPO
	, CONCAT(PG_ATLYS.Conta, CONVERT(DATE,PG_ATLYS.dt_corte)) as procv
FROM 
	[DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[00_PAGAMENTOS_ATLYS] PG_ATLYS
GROUP BY 
	PG_ATLYS.Conta
	,PG_ATLYS.recebivel
	,PG_ATLYS.dt_corte;


	--ALTER TABLE 
	--[DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[00_PAGAMENTOS_ATLYS]
	--ALTER COLUMN CONTA VARCHAR(255)


--INSERT INTO [DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[00_PAGAMENTOS_ATLYS_2]
--(
--[Conta]
--      ,[CNPJ]
--      ,[dt_atribuicao]
--      ,[dt_vecto]
--      ,[dt_corte]
--      ,[Valor]
--      ,[raiz]
--      ,[recebivel]
--      ,[CLASSE]

--) 
--SELECT 
--[Conta]
--      ,[CNPJ]
--      ,[dt_atribuicao]
--      ,[dt_vecto]
--      ,[dt_corte]
--      ,[Valor]
--      ,[raiz]
--      ,[recebivel]
--      ,[CLASSE]
--	FROM [DB_SISCOB_HML].[TRANSITO_PAGAMENTO_AJUSTE].[00_PAGAMENTOS_ATLYS]


