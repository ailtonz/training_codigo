USE [DB_SISCOB]
GO
/****** Object:  StoredProcedure [FILE_CAR].[PRC_010_UPDATE_CONSUMO]    Script Date: 3/9/2017 6:55:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- ==========================================================================
-- Author:		Alencar, Luiz
-- Create date: 2016-06-27
-- Obs> : O processo de inserção guardará histórico dos dados de valores
-- ==========================================================================

ALTER PROCEDURE [FILE_CAR].[PRC_010_UPDATE_CONSUMO] 
	@DIA_CAR CHAR(2)
AS
BEGIN
	
	Declare @tmp1 As APP_WEB.CategoryTableHistorico1
	Declare @tmp2 As APP_WEB.CategoryTableHistorico1
	
	IF @DIA_CAR = '26'
	BEGIN
		 
		 --------------------------------------------------------------------------------------------------------------------------------
		 -- Procedimento a executar para CAR de abertura
		 --------------------------------------------------------------------------------------------------------------------------------

		 DECLARE @DtBkp char(8) ; SET @DtBkp = (SELECT REPLACE(PERIODO,'/','_') FROM [DB_SISCOB].[AUXILIAR].[TB_PERIODO] WHERE STATUS = 1)
		 DECLARE @SQL VARCHAR(255);

		 ---------------------------------------------------------------------------------------------------------------------------------
		 -- Criação de Backup
		 ---------------------------------------------------------------------------------------------------------------------------------
		 SET @SQL = 'SELECT * INTO [DB_SISCOB].[BKP].[' + @DtBkp + '_TB_CONSUMO_SISCOB] FROM [DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB]'
		 --PRINT @SQL
		 EXEC (@SQL)
		 ---------------------------------------------------------------------------------------------------------------------------------

		 ---------------------------------------------------------------------------------------------------------------------------------
		 -- Gravar dados em tabela temporária antes da exclusao dos dados
		 SELECT * INTO #TMP FROM [DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB];
		 ---------------------------------------------------------------------------------------------------------------------------------

		 ---------------------------------------------------------------------------------------------------------------------------------
		 -- Matar dados para inicio de um novo ciclo
		 TRUNCATE TABLE [DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB];
		 ---------------------------------------------------------------------------------------------------------------------------------
		 
		 ---------------------------------------------------------------------------------------------------------------------------------
		 -- Inserção de dados de novo periodo - CAR_26
		 ---------------------------------------------------------------------------------------------------------------------------------
		 INSERT INTO [DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB]
		 (
			 [ID_CONSOLIDADO]
			,[ID_VALORES_26]
			,[ID_VALOR_ATUAL]
			,[ID_STATUS_ESCALATION]
		 )
		
		 SELECT 
			 V.ID_CONSOLIDADO
			,V.ID
			,V.ID
			,4
		 FROM	
			[DB_SISCOB].[CONSOLIDADO].[TB_DADOS_E_VALORES] V
		 WHERE
			V.ID_STATUS_CAR = (SELECT MAX(ID) FROM [DB_SISCOB].[AUXILIAR].[TB_STATUS_CAR]);
		-----------------------------------------------------------------------------------------------------------------------------------
		
		-----------------------------------------------------------------------------------------------------------------------------------
		-- Resgate de dados de histórico do ciclo anterior
		-----------------------------------------------------------------------------------------------------------------------------------
		UPDATE CS SET 
					   CS.ID_HISTORICO_SEMANA_0 = #TMP.ID_HISTORICO_ATUAL
					  ,CS.ID_HISTORICO_ATUAL	= #TMP.ID_HISTORICO_ATUAL
					  ,CS.ID_STATUS_ESCALATION	= #TMP.ID_STATUS_ESCALATION
		FROM
					   [DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB] CS
			INNER JOIN #TMP												ON CS.ID_CONSOLIDADO = #TMP.ID_CONSOLIDADO;
		------------------------------------------------------------------------------------------------------------------------------------

		------------------------------------------------------------------------------------------------------------------------------------
		-- Marcação de faturas Novas
		------------------------------------------------------------------------------------------------------------------------------------
		INSERT INTO @tmp1 
		(
			 [ID_CONSOLIDADO]
			,[ID_FOCO_FEEDBACK]
			,[ID_ANALISTA]
			,[RE_PRBLMA]	
		)
			
		SELECT 
			 V.ID_CONSOLIDADO
			,CASE WHEN V.FAIXA_ATUAL = '0.1 - A vencer' THEN 37 ELSE 12 END
			,140 -- Usuário G-Ca$h
			,'Faturas novas entrantes no CAR. Iniciando cobrança'
			select count(*)
		FROM	
						[DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB]  CS 
			INNER JOIN  [DB_SISCOB].[CONSOLIDADO].[TB_DADOS_E_VALORES] V	ON CS.ID_VALOR_ATUAL = V.ID
			
			
			--LEFT JOIN	[DB_SISCOB].[BKP].[FEV_2017_TB_CONSUMO_SISCOB] t ON CS.ID_CONSOLIDADO = t.ID_CONSOLIDADO
					
		--WHERE t.ID_CONSOLIDADO IS NULL;
		WHERE CS.ID_CONSOLIDADO NOT IN (SELECT ID_CONSOLIDADO FROM [DB_SISCOB].[BKP].[FEV_2017_TB_CONSUMO_SISCOB] )
		
		EXEC [APP_WEB].[PRC_GRAVAR_HISTORICO] @tmp1;

		drop table #TMP;
		--------------------------------------------------------------------------------------------------------------------------------
		-- FIM - Procedimento a executar para CAR de abertura
		--------------------------------------------------------------------------------------------------------------------------------
	END
	
	
	ELSE IF @DIA_CAR = '30' OR @DIA_CAR = '31'
	BEGIN
			
		-------------------------------------------------------------------------------------------------------------------------------
		-- Atualização Valores Car 30 Faturas Já Existentes
		-------------------------------------------------------------------------------------------------------------------------------
		UPDATE CS SET 
					 CS.ID_VALORES_30	= V.ID
					,CS.ID_VALOR_ATUAL	= V.ID	
		FROM
					[DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB]	CS
		INNER JOIN	[DB_SISCOB].[CONSOLIDADO].[TB_DADOS_E_VALORES]	V ON  CS.ID_CONSOLIDADO = V.ID_CONSOLIDADO
		INNER JOIN  [DB_SISCOB].[CONSOLIDADO].[TB_CONSOLIDADO]		C ON  CS.ID_CONSOLIDADO = C.ID
			
		WHERE
				V.ID_STATUS_CAR = (SELECT MAX(ID) FROM [DB_SISCOB].[AUXILIAR].[TB_STATUS_CAR])
		-------------------------------------------------------------------------------------------------------------------------------
		
		-------------------------------------------------------------------------------------------------------------------------------
		-- Inserção dos registros novos CAR 30
		-------------------------------------------------------------------------------------------------------------------------------
		INSERT INTO [DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB]
		(
			 [ID_CONSOLIDADO]
			,[ID_VALORES_30]
			,[ID_VALOR_ATUAL]
			,[ID_STATUS_ESCALATION]
		)
		
		SELECT 
			 V.ID_CONSOLIDADO
			,V.ID
			,V.ID
			,4
			
		FROM	
						[DB_SISCOB].[CONSOLIDADO].[TB_DADOS_E_VALORES] V
			LEFT JOIN	[DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB] CS ON V.ID_CONSOLIDADO = CS.ID_CONSOLIDADO 
		WHERE
					V.ID_STATUS_CAR = (SELECT MAX(ID) FROM [DB_SISCOB].[AUXILIAR].[TB_STATUS_CAR])
				AND CS.ID_CONSOLIDADO IS NULL;


		--Marcação das faturas novas
		-----------------------------------------------------------------------------------------------------------------------------
		INSERT INTO @tmp1 
		(
			 [ID_CONSOLIDADO]
			,[ID_FOCO_FEEDBACK]
			,[ID_ANALISTA]
			,[RE_PRBLMA]	
		)
			
		SELECT 
			 V.ID_CONSOLIDADO
			,CASE WHEN V.FAIXA_ATUAL = '0.1 - A vencer' THEN 37 ELSE 12 END
			,140
			,'Faturas novas entrantes no CAR. Iniciando cobrança'
		FROM	
						[DB_SISCOB].[CONSOLIDADO].[TB_DADOS_E_VALORES]	V
			LEFT JOIN	[DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB]	CS ON V.ID_CONSOLIDADO = CS.ID_CONSOLIDADO 
		WHERE
					V.ID_STATUS_CAR = (SELECT MAX(ID) FROM [DB_SISCOB].[AUXILIAR].[TB_STATUS_CAR])
				AND CS.ID_VALOR_ATUAL IS NOT NULL
				AND CS.ID_VALORES_26 IS NULL;

		EXEC [APP_WEB].[PRC_GRAVAR_HISTORICO] @tmp1;
		-----------------------------------------------------------------------------------------------------------------------------
		
		-----------------------------------------------------------------------------------------------------------------------------	
		-- Marcação de Faturas Baixadas CAR 30
		-----------------------------------------------------------------------------------------------------------------------------		
		UPDATE [DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB] SET 
																	ID_VALOR_ATUAL = NULL,
																	ID_STATUS_ESCALATION = 1
		WHERE ID_VALORES_30 is null;
		-----------------------------------------------------------------------------------------------------------------------------

		-----------------------------------------------------------------------------------------------------------------------------
		-- Marcação das faturas baixadas
		INSERT INTO @tmp2 
		(
			 [ID_CONSOLIDADO]
			,[ID_FOCO_FEEDBACK]
			,[ID_ANALISTA]
			,[RE_PRBLMA]	
		)
			
		SELECT 
				CS.ID_CONSOLIDADO
				,9
				,140
				,'Identificado baixa integral'
		FROM				
						[DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB] CS
		WHERE
				CS.ID_VALOR_ATUAL IS NULL;
			
			EXEC [APP_WEB].[PRC_GRAVAR_HISTORICO] @tmp2;
			-----------------------------------------------------------
		END 
	
	ELSE IF @DIA_CAR = '05'
		BEGIN
			

		-------------------------------------------------------------------------------------------------------------------------------
		-- Atualização Valores Car 05 Faturas Já Existentes
		-------------------------------------------------------------------------------------------------------------------------------
		UPDATE CS SET 
					 CS.ID_VALORES_05	= V.ID
					,CS.ID_VALOR_ATUAL	= V.ID	
		FROM
					[DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB]	CS
		INNER JOIN	[DB_SISCOB].[CONSOLIDADO].[TB_DADOS_E_VALORES]	V ON  CS.ID_CONSOLIDADO = V.ID_CONSOLIDADO
		INNER JOIN  [DB_SISCOB].[CONSOLIDADO].[TB_CONSOLIDADO]		C ON  CS.ID_CONSOLIDADO = C.ID
			
		WHERE
				V.ID_STATUS_CAR = (SELECT MAX(ID) FROM [DB_SISCOB].[AUXILIAR].[TB_STATUS_CAR])
		-------------------------------------------------------------------------------------------------------------------------------
		
		-------------------------------------------------------------------------------------------------------------------------------
		-- Inserção dos registros novos CAR 05
		-------------------------------------------------------------------------------------------------------------------------------
		INSERT INTO [DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB]
		(
			 [ID_CONSOLIDADO]
			,[ID_VALORES_05]
			,[ID_VALOR_ATUAL]
			,[ID_STATUS_ESCALATION]
		)
		
		SELECT 
			 V.ID_CONSOLIDADO
			,V.ID
			,V.ID
			,4
			
		FROM	
						[DB_SISCOB].[CONSOLIDADO].[TB_DADOS_E_VALORES] V
			LEFT JOIN	[DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB] CS ON V.ID_CONSOLIDADO = CS.ID_CONSOLIDADO 
		WHERE
					V.ID_STATUS_CAR = (SELECT MAX(ID) FROM [DB_SISCOB].[AUXILIAR].[TB_STATUS_CAR])
				AND CS.ID_CONSOLIDADO IS NULL;


		--Marcação das faturas novas
		-----------------------------------------------------------------------------------------------------------------------------
		INSERT INTO @tmp1 
		(
			 [ID_CONSOLIDADO]
			,[ID_FOCO_FEEDBACK]
			,[ID_ANALISTA]
			,[RE_PRBLMA]	
		)
			
		SELECT 
			 V.ID_CONSOLIDADO
			,CASE WHEN V.FAIXA_ATUAL = '0.1 - A vencer' THEN 37 ELSE 12 END
			,140
			,'Faturas novas entrantes no CAR. Iniciando cobrança'
		FROM	
						[DB_SISCOB].[CONSOLIDADO].[TB_DADOS_E_VALORES]	V
			LEFT JOIN	[DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB]	CS ON V.ID_CONSOLIDADO = CS.ID_CONSOLIDADO 
		WHERE
					V.ID_STATUS_CAR = (SELECT MAX(ID) FROM [DB_SISCOB].[AUXILIAR].[TB_STATUS_CAR])
				AND CS.ID_VALOR_ATUAL IS NOT NULL
				AND CS.ID_VALORES_30 IS NULL;

		EXEC [APP_WEB].[PRC_GRAVAR_HISTORICO] @tmp1;
		-----------------------------------------------------------------------------------------------------------------------------
		
		-----------------------------------------------------------------------------------------------------------------------------	
		-- Marcação de Faturas Baixadas CAR 05
		-----------------------------------------------------------------------------------------------------------------------------		
		UPDATE [DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB] SET 
																	ID_VALOR_ATUAL = NULL,
																	ID_STATUS_ESCALATION = 1
		WHERE ID_VALORES_05 is null;
		-----------------------------------------------------------------------------------------------------------------------------

		-----------------------------------------------------------------------------------------------------------------------------
		-- Marcação das faturas baixadas
		INSERT INTO @tmp2 
		(
			 [ID_CONSOLIDADO]
			,[ID_FOCO_FEEDBACK]
			,[ID_ANALISTA]
			,[RE_PRBLMA]	
		)
			
		SELECT 
				CS.ID_CONSOLIDADO
				,9
				,140
				,'Identificado baixa integral'
		FROM				
						[DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB] CS
		WHERE
				CS.ID_VALOR_ATUAL IS NULL;
			
			EXEC [APP_WEB].[PRC_GRAVAR_HISTORICO] @tmp2;
			-----------------------------------------------------------

		END 
	
	ELSE IF @DIA_CAR = '14'
		BEGIN
			
			-------------------------------------------------------------------------------------------------------------------------------
		-- Atualização Valores Car 05 Faturas Já Existentes
		-------------------------------------------------------------------------------------------------------------------------------
		UPDATE CS SET 
					 CS.ID_VALORES_14	= V.ID
					,CS.ID_VALOR_ATUAL	= V.ID	
		FROM
					[DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB]	CS
		INNER JOIN	[DB_SISCOB].[CONSOLIDADO].[TB_DADOS_E_VALORES]	V ON  CS.ID_CONSOLIDADO = V.ID_CONSOLIDADO
		INNER JOIN  [DB_SISCOB].[CONSOLIDADO].[TB_CONSOLIDADO]		C ON  CS.ID_CONSOLIDADO = C.ID
			
		WHERE
				V.ID_STATUS_CAR = (SELECT MAX(ID) FROM [DB_SISCOB].[AUXILIAR].[TB_STATUS_CAR])
		-------------------------------------------------------------------------------------------------------------------------------
		
		-------------------------------------------------------------------------------------------------------------------------------
		-- Inserção dos registros novos CAR 14
		-------------------------------------------------------------------------------------------------------------------------------
		INSERT INTO [DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB]
		(
			 [ID_CONSOLIDADO]
			,[ID_VALORES_14]
			,[ID_VALOR_ATUAL]
			,[ID_STATUS_ESCALATION]
		)
		
		SELECT 
			 V.ID_CONSOLIDADO
			,V.ID
			,V.ID
			,4
			
		FROM	
						[DB_SISCOB].[CONSOLIDADO].[TB_DADOS_E_VALORES] V
			LEFT JOIN	[DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB] CS ON V.ID_CONSOLIDADO = CS.ID_CONSOLIDADO 
		WHERE
					V.ID_STATUS_CAR = (SELECT MAX(ID) FROM [DB_SISCOB].[AUXILIAR].[TB_STATUS_CAR])
				AND CS.ID_CONSOLIDADO IS NULL;


		--Marcação das faturas novas
		-----------------------------------------------------------------------------------------------------------------------------
		INSERT INTO @tmp1 
		(
			 [ID_CONSOLIDADO]
			,[ID_FOCO_FEEDBACK]
			,[ID_ANALISTA]
			,[RE_PRBLMA]	
		)
			
		SELECT 
			 V.ID_CONSOLIDADO
			,CASE WHEN V.FAIXA_ATUAL = '0.1 - A vencer' THEN 37 ELSE 12 END
			,140
			,'Faturas novas entrantes no CAR. Iniciando cobrança'
		FROM	
						[DB_SISCOB].[CONSOLIDADO].[TB_DADOS_E_VALORES]	V
			LEFT JOIN	[DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB]	CS ON V.ID_CONSOLIDADO = CS.ID_CONSOLIDADO 
		WHERE
					V.ID_STATUS_CAR = (SELECT MAX(ID) FROM [DB_SISCOB].[AUXILIAR].[TB_STATUS_CAR])
				AND CS.ID_VALOR_ATUAL IS NOT NULL
				AND CS.ID_VALORES_05 IS NULL;

		EXEC [APP_WEB].[PRC_GRAVAR_HISTORICO] @tmp1;
		-----------------------------------------------------------------------------------------------------------------------------
		
		-----------------------------------------------------------------------------------------------------------------------------	
		-- Marcação de Faturas Baixadas CAR 14
		-----------------------------------------------------------------------------------------------------------------------------		
		UPDATE [DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB] SET 
																	ID_VALOR_ATUAL = NULL,
																	ID_STATUS_ESCALATION = 1
		WHERE ID_VALORES_14 is null;
		-----------------------------------------------------------------------------------------------------------------------------

		-----------------------------------------------------------------------------------------------------------------------------
		-- Marcação das faturas baixadas
		INSERT INTO @tmp2 
		(
			 [ID_CONSOLIDADO]
			,[ID_FOCO_FEEDBACK]
			,[ID_ANALISTA]
			,[RE_PRBLMA]	
		)
			
		SELECT 
				CS.ID_CONSOLIDADO
				,9
				,140
				,'Identificado baixa integral'
		FROM				
						[DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB] CS
		WHERE
				CS.ID_VALOR_ATUAL IS NULL;
			
			EXEC [APP_WEB].[PRC_GRAVAR_HISTORICO] @tmp2;
			-----------------------------------------------------------

		END 
			
	
	ELSE IF @DIA_CAR = '21'
		BEGIN
			
		-------------------------------------------------------------------------------------------------------------------------------
		-- Atualização Valores Car 21 Faturas Já Existentes
		-------------------------------------------------------------------------------------------------------------------------------
		UPDATE CS SET 
					 CS.ID_VALORES_21	= V.ID
					,CS.ID_VALOR_ATUAL	= V.ID	
		FROM
					[DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB]	CS
		INNER JOIN	[DB_SISCOB].[CONSOLIDADO].[TB_DADOS_E_VALORES]	V ON  CS.ID_CONSOLIDADO = V.ID_CONSOLIDADO
		INNER JOIN  [DB_SISCOB].[CONSOLIDADO].[TB_CONSOLIDADO]		C ON  CS.ID_CONSOLIDADO = C.ID
			
		WHERE
				V.ID_STATUS_CAR = (SELECT MAX(ID) FROM [DB_SISCOB].[AUXILIAR].[TB_STATUS_CAR])
		-------------------------------------------------------------------------------------------------------------------------------
		
		-------------------------------------------------------------------------------------------------------------------------------
		-- Inserção dos registros novos CAR 21
		-------------------------------------------------------------------------------------------------------------------------------
		INSERT INTO [DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB]
		(
			 [ID_CONSOLIDADO]
			,[ID_VALORES_21]
			,[ID_VALOR_ATUAL]
			,[ID_STATUS_ESCALATION]
		)
		
		SELECT 
			 V.ID_CONSOLIDADO
			,V.ID
			,V.ID
			,4
			
		FROM	
						[DB_SISCOB].[CONSOLIDADO].[TB_DADOS_E_VALORES] V
			LEFT JOIN	[DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB] CS ON V.ID_CONSOLIDADO = CS.ID_CONSOLIDADO 
		WHERE
					V.ID_STATUS_CAR = (SELECT MAX(ID) FROM [DB_SISCOB].[AUXILIAR].[TB_STATUS_CAR])
				AND CS.ID_CONSOLIDADO IS NULL;


		--Marcação das faturas novas
		-----------------------------------------------------------------------------------------------------------------------------
		INSERT INTO @tmp1 
		(
			 [ID_CONSOLIDADO]
			,[ID_FOCO_FEEDBACK]
			,[ID_ANALISTA]
			,[RE_PRBLMA]	
		)
			
		SELECT 
			 V.ID_CONSOLIDADO
			,CASE WHEN V.FAIXA_ATUAL = '0.1 - A vencer' THEN 37 ELSE 12 END
			,140
			,'Faturas novas entrantes no CAR. Iniciando cobrança'
		FROM	
						[DB_SISCOB].[CONSOLIDADO].[TB_DADOS_E_VALORES]	V
			LEFT JOIN	[DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB]	CS ON V.ID_CONSOLIDADO = CS.ID_CONSOLIDADO 
		WHERE
					V.ID_STATUS_CAR = (SELECT MAX(ID) FROM [DB_SISCOB].[AUXILIAR].[TB_STATUS_CAR])
				AND CS.ID_VALOR_ATUAL IS NOT NULL
				AND CS.ID_VALORES_14 IS NULL;

		EXEC [APP_WEB].[PRC_GRAVAR_HISTORICO] @tmp1;
		-----------------------------------------------------------------------------------------------------------------------------
		
		-----------------------------------------------------------------------------------------------------------------------------	
		-- Marcação de Faturas Baixadas CAR 21
		-----------------------------------------------------------------------------------------------------------------------------		
		UPDATE [DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB] SET 
																	ID_VALOR_ATUAL = NULL,
																	ID_STATUS_ESCALATION = 1
		WHERE ID_VALORES_21 is null;
		-----------------------------------------------------------------------------------------------------------------------------

		-----------------------------------------------------------------------------------------------------------------------------
		-- Marcação das faturas baixadas
		INSERT INTO @tmp2 
		(
			 [ID_CONSOLIDADO]
			,[ID_FOCO_FEEDBACK]
			,[ID_ANALISTA]
			,[RE_PRBLMA]	
		)
			
		SELECT 
				CS.ID_CONSOLIDADO
				,9
				,140
				,'Identificado baixa integral'
		FROM				
						[DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB] CS
		WHERE
				CS.ID_VALOR_ATUAL IS NULL;
			
			EXEC [APP_WEB].[PRC_GRAVAR_HISTORICO] @tmp2;
			-----------------------------------------------------------

		END 

		
	ELSE IF @DIA_CAR = '25'
		BEGIN
		
		-------------------------------------------------------------------------------------------------------------------------------
		-- Atualização Valores Car 25 Faturas Já Existentes
		-------------------------------------------------------------------------------------------------------------------------------
		UPDATE CS SET 
					 CS.ID_VALORES_25	= V.ID
					,CS.ID_VALOR_ATUAL	= V.ID	
		FROM
					[DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB]	CS
		INNER JOIN	[DB_SISCOB].[CONSOLIDADO].[TB_DADOS_E_VALORES]	V ON  CS.ID_CONSOLIDADO = V.ID_CONSOLIDADO
		INNER JOIN  [DB_SISCOB].[CONSOLIDADO].[TB_CONSOLIDADO]		C ON  CS.ID_CONSOLIDADO = C.ID
			
		WHERE
				V.ID_STATUS_CAR = (SELECT MAX(ID) FROM [DB_SISCOB].[AUXILIAR].[TB_STATUS_CAR])
		-------------------------------------------------------------------------------------------------------------------------------
		
		-------------------------------------------------------------------------------------------------------------------------------
		-- Inserção dos registros novos CAR 25
		-------------------------------------------------------------------------------------------------------------------------------
		INSERT INTO [DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB]
		(
			 [ID_CONSOLIDADO]
			,[ID_VALORES_25]
			,[ID_VALOR_ATUAL]
			,[ID_STATUS_ESCALATION]
		)
		
		SELECT 
			 V.ID_CONSOLIDADO
			,V.ID
			,V.ID
			,4
			
		FROM	
						[DB_SISCOB].[CONSOLIDADO].[TB_DADOS_E_VALORES] V
			LEFT JOIN	[DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB] CS ON V.ID_CONSOLIDADO = CS.ID_CONSOLIDADO 
		WHERE
					V.ID_STATUS_CAR = (SELECT MAX(ID) FROM [DB_SISCOB].[AUXILIAR].[TB_STATUS_CAR])
				AND CS.ID_CONSOLIDADO IS NULL;


		--Marcação das faturas novas
		-----------------------------------------------------------------------------------------------------------------------------
		INSERT INTO @tmp1 
		(
			 [ID_CONSOLIDADO]
			,[ID_FOCO_FEEDBACK]
			,[ID_ANALISTA]
			,[RE_PRBLMA]	
		)
			
		SELECT 
			 V.ID_CONSOLIDADO
			,CASE WHEN V.FAIXA_ATUAL = '0.1 - A vencer' THEN 37 ELSE 12 END
			,140
			,'Faturas novas entrantes no CAR. Iniciando cobrança'
		FROM	
						[DB_SISCOB].[CONSOLIDADO].[TB_DADOS_E_VALORES]	V
			LEFT JOIN	[DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB]	CS ON V.ID_CONSOLIDADO = CS.ID_CONSOLIDADO 
		WHERE
					V.ID_STATUS_CAR = (SELECT MAX(ID) FROM [DB_SISCOB].[AUXILIAR].[TB_STATUS_CAR])
				AND CS.ID_VALOR_ATUAL IS NOT NULL
				AND CS.ID_VALORES_21 IS NULL;

		EXEC [APP_WEB].[PRC_GRAVAR_HISTORICO] @tmp1;
		-----------------------------------------------------------------------------------------------------------------------------
		
		-----------------------------------------------------------------------------------------------------------------------------	
		-- Marcação de Faturas Baixadas CAR 25
		-----------------------------------------------------------------------------------------------------------------------------		
		UPDATE [DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB] SET 
																	ID_VALOR_ATUAL = NULL,
																	ID_STATUS_ESCALATION = 1
		WHERE ID_VALORES_25 is null;
		-----------------------------------------------------------------------------------------------------------------------------

		-----------------------------------------------------------------------------------------------------------------------------
		-- Marcação das faturas baixadas
		INSERT INTO @tmp2 
		(
			 [ID_CONSOLIDADO]
			,[ID_FOCO_FEEDBACK]
			,[ID_ANALISTA]
			,[RE_PRBLMA]	
		)
			
		SELECT 
				CS.ID_CONSOLIDADO
				,9
				,140
				,'Identificado baixa integral'
		FROM				
						[DB_SISCOB].[CONSOLIDADO].[TB_CONSUMO_SISCOB] CS
		WHERE
				CS.ID_VALOR_ATUAL IS NULL;
			
			EXEC [APP_WEB].[PRC_GRAVAR_HISTORICO] @tmp2;
			-----------------------------------------------------------

		END 

END


