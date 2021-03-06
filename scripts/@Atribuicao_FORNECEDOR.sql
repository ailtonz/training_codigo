/****** ATRIBUIÇÃO DE FORNECEDORES  ******/
/****** ATRIBUIÇÃO DE FORNECEDORES  ******/
/****** ATRIBUIÇÃO DE FORNECEDORES  ******/

--#######################################################

/****** ATRIBUIÇÃO MANUAL ********/
/****** ATRIBUIÇÃO MANUAL ********/
/****** ATRIBUIÇÃO MANUAL ********/

-- ########
-- CONSULTA
-- ########

	SELECT 
		DISTINCT
		[CONTA]
		,DT_PROCESS
		,[DT_PROCESS]
		,[FORNECEDOR] 
		--*
	FROM [DB_SISCOB].[CONSOLIDADO].[TB_CONSOLIDADO]
	WHERE 
		conta='2144471677' and DT_PROCESS='2017-01-24'
		--fornecedor = null

-- #####################
-- ATRIBUIÇÃO UNITARIA
-- #####################

	update [DB_SISCOB].[CONSOLIDADO].[TB_CONSOLIDADO]
	set 
		fornecedor = null
	where 
		conta='2144471677' and DT_PROCESS='2017-01-24'

-- #####################
-- ATRIBUIÇÃO LISTAGEM
-- #####################

	--update C
	--	set 
	--		C.fornecedor = TMP.[VIVO_CARTEIRA#FORNECEDOR]

	--	FROM [DB_SISCOB].[CONSOLIDADO].[TB_CONSOLIDADO] C 
	--	INNER JOIN [DB_SISCOB].[TRANSITO].[TMP_VALIDA_MOVEL_CORRIGIR_FORNECEDOR] TMP 
	--	ON 
	--		TMP.CONTA = C.CONTA 
	--	AND 
	--		TMP.DT_PROCESS = C.DT_PROCESS

/****** ATUALIZAR TAMBEM A VIVO CARTEIRA ********/
/****** ATUALIZAR TAMBEM A VIVO CARTEIRA ********/
/****** ATUALIZAR TAMBEM A VIVO CARTEIRA ********/

-- ########
-- CONSULTA
-- ########

	SELECT 
		DT_CORTE
		,DT_PROCESS
		,[CONTA]
		,[DT_PROCESS]
		,[FORNECEDOR]
	FROM [DB_SISCOB].[AUXILIAR].[VW_VIVO_CARTEIRA]
	where 
		conta='2144471677' and DT_PROCESS='24/01/2017'

-- #####################
-- ATRIBUIÇÃO UNITARIA
-- #####################

	update [DB_SISCOB].[AUXILIAR].[VW_VIVO_CARTEIRA]
	set 
		fornecedor = null
	where 
		conta='2144471677' and DT_PROCESS='24/01/2017'

-- #####################
-- ATRIBUIÇÃO LISTAGEM
-- #####################

	--update V
	--	set 
	--		V.FORNECEDOR = TMP.[VIVO_CARTEIRA#FORNECEDOR]

	--	FROM [DB_SISCOB].[AUXILIAR].[VW_VIVO_CARTEIRA] V 
	--	INNER JOIN [DB_SISCOB].[TRANSITO].[TMP_VALIDA_MOVEL_CORRIGIR_FORNECEDOR] TMP 
	--	ON 
	--		TMP.CONTA = V.CONTA 
	--	AND 
	--		TMP.DT_PROCESS = CONVERT(DATE,V.DT_PROCESS,103)




/****** DESATRIBUIR O GRUPO ********/
 

-- #####################
-- ATRIBUIÇÃO UNITARIA
-- #####################

	update [DB_SISCOB].[CONSOLIDADO].[TB_CONSOLIDADO] set FORNECEDOR =  NULL

	  WHERE
			ID_PERIODO = 11
			AND ID_SEGMENTO = 2
			AND RAIZ_GRUPO = '18033552' 


	update [DB_SISCOB].[AUXILIAR].[VW_VIVO_CARTEIRA] set FORNECEDOR =  NULL

	  --WHERE
			--ID_PERIODO = 11
			--AND ID_SEGMENTO = 2
			--AND RAIZ_GRUPO = '18033552' 


-- #####################
-- ATRIBUIÇÃO LISTAGEM
-- #####################

	-- TB_CONSOLIDADO
	update C
		set 
			C.fornecedor = NULL

		FROM [DB_SISCOB].[CONSOLIDADO].[TB_CONSOLIDADO] C 
		INNER JOIN [DB_SISCOB].[TRANSITO].[TMP_VALIDA_MOVEL_EXCLUIR_FORNECEDOR] TMP 
		ON 
			TMP.CONTA = C.CONTA 
		AND 
			TMP.DT_PROCESS = C.DT_PROCESS

		WHERE
			ID_PERIODO = 11
			AND ID_SEGMENTO = 2


	-- VW_VIVO_CARTEIRA
	update V
		set 
			V.fornecedor = NULL
		--SELECT COUNT(*)
		FROM [DB_SISCOB].[AUXILIAR].[VW_VIVO_CARTEIRA] V 
		INNER JOIN [DB_SISCOB].[TRANSITO].[TMP_VALIDA_MOVEL_EXCLUIR_FORNECEDOR] TMP 
		ON 
			TMP.CONTA = V.CONTA 
		AND 
			TMP.DT_PROCESS = CONVERT(DATE,V.DT_PROCESS,103)

			

