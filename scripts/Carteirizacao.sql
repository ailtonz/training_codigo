USE [DB_SISCOB]
GO
/****** Object:  StoredProcedure [FILE_CAR].[PRC_014_ATUALIZAR_CARTEIRA_MOVEL]    Script Date: 09/05/2017 19:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- ==========================================================================
-- Author:		Alencar, Luiz
-- Create date: 2016-07-04
-- Obs> : Processo de Atualização da Tabela de Resumo
-- ==========================================================================
ALTER PROCEDURE [FILE_CAR].[PRC_014_ATUALIZAR_CARTEIRA_MOVEL] 
	@DIA_CAR CHAR(2)
AS
BEGIN
	
	DECLARE @DtBkp char(8) ; SET @DtBkp = (SELECT convert(varchar,year(getdate())) +  '_' + replicate('0',2-len(convert(varchar,(Month(getdate()) - 1)))) + convert(varchar,(Month(getdate()) - 1)))
	DECLARE @sql varchar(MAX)

	IF @DIA_CAR = '26'
		BEGIN
			TRUNCATE TABLE [AUXILIAR].[TB_ANALISTA_CARTEIRA_FIXA]
			TRUNCATE TABLE [AUXILIAR].[TB_ANALISTA_CARTEIRA_MOVEL]

			DECLARE @DtBkp char(8) ; SET @DtBkp = (SELECT convert(varchar,year(getdate())) +  '_' + replicate('0',2-len(convert(varchar,(Month(getdate()) - 1)))) + convert(varchar,(Month(getdate()) - 1)))
			DECLARE @sql varchar(MAX)
			SET @sql = 'SELECT DISTINCT 
									 RAIZ_GRUPO
									,ID_ANALISTA
									,ID_ANALISTA_TMP
						INTO #TMP_MOVEL
						
						FROM
							[BKP].[' + @DtBkp + '_TB_ANALISTA_CARTEIRA_MOVEL]
						WHERE
							ID_ANALISTA IS NOT NULL OR ID_ANALISTA_TMP IS NOT NULL;'

			SET @sql = @sql + ' UPDATE C
			SET  ID_ANALISTA		= #TMP_MOVEL.ID_ANALISTA
				,ID_ANALISTA_TMP	= #TMP_MOVEL.ID_ANALISTA_TMP
				,C.STATUS = 0
				,C.ID_USER_ATUALIZACAO = 140
  FROM
		[AUXILIAR].[TB_ANALISTA_CARTEIRA_MOVEL] C
		INNER JOIN #TMP_MOVEL								ON C.RAIZ_GRUPO = #TMP_MOVEL.RAIZ_GRUPO
  
  WHERE
		C.STATUS = 2;'

			EXEC (@sql)


			
			SET @sql = 'SELECT DISTINCT 
									 RAIZ_GRUPO
									,ID_ANALISTA
									,ID_ANALISTA_TMP
						INTO #TMP_FIXA
						
						FROM
							[BKP].[' + @DtBkp + '_TB_ANALISTA_CARTEIRA_FIXA]
						WHERE
							ID_ANALISTA IS NOT NULL OR ID_ANALISTA_TMP IS NOT NULL;'

				SET @sql = 	@sql + ' UPDATE C
			SET  ID_ANALISTA		= #TMP_FIXA.ID_ANALISTA
				,ID_ANALISTA_TMP	= #TMP_FIXA.ID_ANALISTA_TMP
				,C.STATUS = 0
				,C.ID_USER_ATUALIZACAO = 140
  FROM
		[AUXILIAR].[TB_ANALISTA_CARTEIRA_FIXA] C
		INNER JOIN #TMP_FIXA								ON C.RAIZ_GRUPO = #TMP_FIXA.RAIZ_GRUPO
  
  WHERE
		C.STATUS = 2;'
			EXEC (@sql)
		END

	ELSE
		BEGIN

			SELECT DISTINCT 
						RAIZ_GRUPO
						,ID_ANALISTA
						,ID_ANALISTA_TMP
			INTO #TMP_MOVEL
						
			FROM
				[AUXILIAR].[TB_ANALISTA_CARTEIRA_MOVEL]
			WHERE
				ID_ANALISTA IS NOT NULL OR ID_ANALISTA_TMP IS NOT NULL;


			SELECT DISTINCT 
						RAIZ_GRUPO
						,ID_ANALISTA
						,ID_ANALISTA_TMP
			INTO #TMP_FIXA
						
			FROM
				[AUXILIAR].[TB_ANALISTA_CARTEIRA_FIXA]
			WHERE
				ID_ANALISTA IS NOT NULL OR ID_ANALISTA_TMP IS NOT NULL;

		END

		--==============================================================================
	 	INSERT INTO [AUXILIAR].[TB_ANALISTA_CARTEIRA_MOVEL]
		(
			 RAIZ
			,RAIZ_GRUPO
			,NOME_GRUPO
			,SEGMENTO_CARTEIRA
			,TASK_FORCE
			,DT_ATUALIZACAO
			,STATUS
		)

		SELECT 
				C.RAIZ_CPF_CNPJ AS RAIZ
			   ,C.RAIZ_GRUPO
			   ,MAX(C.NOME_GRUPO) AS NOME_GRUPO	
			   ,max(C.SEGMENTO_GERENCIA) AS SEGMENTO_CARTEIRA
			   ,T.ID
			   ,GETDATE()
			   ,2
	   
		  FROM				 
							[CONSOLIDADO].[TB_CONSOLIDADO] C
				LEFT JOIN	[AUXILIAR].[TB_ANALISTA_CARTEIRA_MOVEL] CM ON C.RAIZ_CPF_CNPJ = CM.RAIZ
				INNER JOIN  [AUXILIAR].[TB_TASK_FORCE]  T ON C.TASK_FORCE = T.[DESCRICAO_TASK] 
		  WHERE
					C.ID_SEGMENTO = 2
				AND C.FORNECEDOR LIKE 'ACCENTURE%'
				--AND C.RAIZ_CPF_CNPJ NOT IN (SELECT RAIZ FROM )
				AND C.ID_PERIODO = (SELECT MAX(ID) FROM [DB_SISCOB].[AUXILIAR].[TB_PERIODO])
				AND CM.RAIZ IS NULL		
		  GROUP BY
				 C.RAIZ_CPF_CNPJ
				,C.RAIZ_GRUPO
				--,C.SEGMENTO_GERENCIA
				,T.ID
		  ORDER BY NOME_GRUPO;
		  --============================================================================================

  
  DECLARE @DtBkp char(8) ; SET @DtBkp = (SELECT convert(varchar,year(getdate())) +  '_' + replicate('0',2-len(convert(varchar,(Month(getdate()) - 1)))) + convert(varchar,(Month(getdate()) - 1)))
			DECLARE @sql varchar(MAX)
			SET @sql = 'SELECT DISTINCT 
									 RAIZ_GRUPO
									,ID_ANALISTA
									,ID_ANALISTA_TMP
						INTO #TMP_MOVEL
						
						FROM
							[BKP].[' + @DtBkp + '_TB_ANALISTA_CARTEIRA_MOVEL]
						WHERE
							ID_ANALISTA IS NOT NULL OR ID_ANALISTA_TMP IS NOT NULL;'



			EXEC (@sql)
			
  UPDATE C
			SET  ID_ANALISTA		= #TMP_MOVEL.ID_ANALISTA
				,ID_ANALISTA_TMP	= #TMP_MOVEL.ID_ANALISTA_TMP
				,C.STATUS = 0
				,C.ID_USER_ATUALIZACAO = 140
  FROM
		[AUXILIAR].[TB_ANALISTA_CARTEIRA_MOVEL] C
		INNER JOIN #TMP_MOVEL								ON C.RAIZ_GRUPO = #TMP_MOVEL.RAIZ_GRUPO
  
  WHERE
		C.STATUS = 2;

  DROP TABLE #TMP_MOVEL;



  INSERT INTO [AUXILIAR].[TB_ANALISTA_CARTEIRA_FIXA]
(
	 RAIZ
	,RAIZ_GRUPO
	,NOME_GRUPO
	,SEGMENTO_CARTEIRA
	,TASK_FORCE
	,DT_ATUALIZACAO
	,STATUS
)

SELECT 
	    C.RAIZ_CPF_CNPJ AS RAIZ
	   ,C.RAIZ_GRUPO
	   ,MAX(C.NOME_GRUPO) AS NOME_GRUPO	
	   ,max(C.SEG_DESCR) AS SEGMENTO_CARTEIRA
	   ,T.ID
	   ,GETDATE()
	   ,2
	   
  FROM				 
					[CONSOLIDADO].[TB_CONSOLIDADO] C
		LEFT JOIN	[AUXILIAR].[TB_ANALISTA_CARTEIRA_FIXA] CM ON C.RAIZ_CPF_CNPJ = CM.RAIZ
		INNER JOIN  [AUXILIAR].[TB_TASK_FORCE]  T ON C.TASK_FORCE = T.[DESCRICAO_TASK] 
  WHERE
		    C.ID_SEGMENTO = 1
		AND C.FORNECEDOR LIKE 'ACCENTURE%'
		--AND C.RAIZ_CPF_CNPJ NOT IN (SELECT RAIZ FROM )
		AND C.ID_PERIODO = (SELECT MAX(ID) FROM [DB_SISCOB].[AUXILIAR].[TB_PERIODO])
		AND CM.RAIZ IS NULL
		
  GROUP BY
		 C.RAIZ_CPF_CNPJ
		,C.RAIZ_GRUPO
		--,C.SEGMENTO_GERENCIA
		,T.ID
  ORDER BY NOME_GRUPO;


			
  UPDATE C
			SET  ID_ANALISTA		= #TMP_FIXA.ID_ANALISTA
				,ID_ANALISTA_TMP	= #TMP_FIXA.ID_ANALISTA_TMP
				,C.STATUS = 0
				,C.ID_USER_ATUALIZACAO = 140
  FROM
		[AUXILIAR].[TB_ANALISTA_CARTEIRA_FIXA] C
		INNER JOIN #TMP_FIXA								ON C.RAIZ_GRUPO = #TMP_FIXA.RAIZ_GRUPO
  
  WHERE
		C.STATUS = 2;

  DROP TABLE #TMP_FIXA;
END


