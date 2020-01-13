DECLARE @IdSemana AS INT

	SET @IdSemana = (SELECT CONVERT(BIGINT,FOCO_FEEDBACK) FROM [AUXILIAR].[TB_SEMANAS] WHERE STATUS = 1);

	---------------------------------------------------------------------------------------------------------------

	

	----------------------------------------------------------------------------------------------------------------

	-- Mudar o Status dos registros que deverão ser atualizados

	UPDATE [CONSOLIDADO].[TB_HISTORICO] SET STATUS = 0 WHERE STATUS IS NULL AND ID_ANALISTA = 38;

	----------------------------------------------------------------------------------------------------------------

	

	SELECT 

		    MAX(H.ID)			AS ID

		   ,H.ID_CONSOLIDADO

		   ,H.ID_FOCO_FEEDBACK

		   ,H.ID_TIPO_PAGAMENTO

		   ,H.DT_FOLLOW

		   ,H.[DT_AJUSTE]

		   ,H.[DT_PAGAMENTO]

		   ,H.[VALOR_PAGO]

		   ,H.[VALOR_AJUSTE]

		   ,H.[RESPONSAVEL]

		   ,H.[RE_PROBLEMA]

		   ,H.[RE_ACAO]

		   ,H.[CBPM]

		   ,H.[ID_PORTAL_DEMANDA]

		   ,H.[NUMERO_BOLETO]

		   ,H.[DATA_EMISSAO_BOLETO]

		   ,H.[HISTORICO_DETALHADO]

		   ,H.[TIME_STAMP]

		   ,H.[ID_GESTAO_CONTA]

		   ,H.[OBS]

	INTO

		#TMP

	FROM

		 [CONSOLIDADO].[TB_HISTORICO] H

	WHERE

		  STATUS = 0

	AND	  ID_ANALISTA = 38



	GROUP BY  

	        H.ID_CONSOLIDADO

		   ,H.ID_FOCO_FEEDBACK

		   ,H.ID_TIPO_PAGAMENTO

		   ,H.DT_FOLLOW

		   ,H.[DT_AJUSTE]

		   ,H.[DT_PAGAMENTO]

		   ,H.[VALOR_PAGO]

		   ,H.[VALOR_AJUSTE]

		   ,H.[RESPONSAVEL]

		   ,H.[RE_PROBLEMA]

		   ,H.[RE_ACAO]

		   ,H.[CBPM]

		   ,H.[ID_PORTAL_DEMANDA]

		   ,H.[NUMERO_BOLETO]

		   ,H.[DATA_EMISSAO_BOLETO]

		   ,H.[HISTORICO_DETALHADO]

		   ,H.[TIME_STAMP]

		   ,H.[ID_GESTAO_CONTA]

		   ,H.[OBS]

	----------------------------------------------------------------------------------------------------------------

	





	SELECT

		 H.ID

		,H.ID_CONSOLIDADO

		,H.ID_TIPO_PAGAMENTO

		,H.DT_FOLLOW

		,H.DT_AJUSTE

		,H.DT_PAGAMENTO

		,H.VALOR_PAGO

		,H.VALOR_AJUSTE

		,H.RESPONSAVEL

		,H.RE_PROBLEMA

		,H.RE_ACAO

		,H.CBPM

		,H.ID_PORTAL_DEMANDA

		,H.NUMERO_BOLETO

		,H.DATA_EMISSAO_BOLETO

		,H.HISTORICO_DETALHADO

		,H.ID_GESTAO_CONTA

		,H.OBS

		,H.HD_ACUMULADO

	

	INTO #TMP_UH

	

	FROM	

					[CONSOLIDADO].[TB_HISTORICO] H

		INNER JOIN	[CONSOLIDADO].[TB_CONSUMO_SISCOB] CS ON CS.ID_HISTORICO_ATUAL = H.ID

		

	WHERE

		CS.ID_CONSOLIDADO IN (SELECT ID_CONSOLIDADO FROM #TMP);


		select * from #TMP
	select * from #TMP_UH






	-- Atualizar a informação de Historico detalhado Acumulado

	UPDATE H2 SET 

				 

					H2.ID_TIPO_PAGAMENTO		= ISNULL(H.ID_TIPO_PAGAMENTO,H1.ID_TIPO_PAGAMENTO)

				   ,H2.DT_FOLLOW				= ISNULL(H.DT_FOLLOW,H1.DT_FOLLOW)

				   ,H2.[DT_AJUSTE]				= ISNULL(H.[DT_AJUSTE],H1.[DT_AJUSTE])

				   ,H2.[DT_PAGAMENTO]			= ISNULL(H.[DT_PAGAMENTO],H1.[DT_PAGAMENTO])

				   ,H2.[VALOR_PAGO]				= ISNULL(H.[VALOR_PAGO],H1.[VALOR_PAGO])

				   ,H2.[VALOR_AJUSTE]			= ISNULL(H.[VALOR_AJUSTE],H1.[VALOR_AJUSTE])

				   ,H2.[RESPONSAVEL]			= ISNULL(H.[RESPONSAVEL],H1.[RESPONSAVEL])

				   ,H2.[RE_PROBLEMA]			= ISNULL(H.[RE_PROBLEMA],H1.[RE_PROBLEMA])

				   ,H2.[RE_ACAO]				= ISNULL(H.[RE_ACAO],H1.[RE_ACAO])

				   ,H2.[CBPM]					= ISNULL(H.[CBPM],H1.[CBPM])

				   ,H2.[ID_PORTAL_DEMANDA]		= ISNULL(H.[ID_PORTAL_DEMANDA],H1.[ID_PORTAL_DEMANDA])

				   ,H2.[NUMERO_BOLETO]			= ISNULL(H.[NUMERO_BOLETO],H1.[NUMERO_BOLETO])

				   ,H2.[DATA_EMISSAO_BOLETO]	= ISNULL(H.[DATA_EMISSAO_BOLETO],H1.[DATA_EMISSAO_BOLETO])

				   ,H2.[HISTORICO_DETALHADO]	= ISNULL(H.[HISTORICO_DETALHADO],H1.[HISTORICO_DETALHADO])

				   ,H2.[ID_GESTAO_CONTA]		= ISNULL(H.[ID_GESTAO_CONTA],H1.[ID_GESTAO_CONTA])

				   ,H2.[OBS]					= ISNULL(H.[OBS],H1.[OBS])

				   ,H2.HD_ACUMULADO				= ISNULL(ISNULL(H.HISTORICO_DETALHADO,H1.[HISTORICO_DETALHADO]),'') + ' |' + ISNULL(H1.HD_ACUMULADO,'')

	
	

	FROM

						

						#TMP  H

			 INNER JOIN #TMP_UH									  H1 ON H.ID_CONSOLIDADO = H1.ID_CONSOLIDADO	  

			 INNER JOIN [CONSOLIDADO].[TB_HISTORICO]			  H2 ON H.ID			 = H2.ID

    ----------------------------------------------------------------------------------------------------------------



	----------------------------------------------------------------------------------------------------------------

	-- Quando a semana atual 1, atualizar o campo ID_HISTORICO_SEMANA_1 da tabela de consumo

	IF @idSemana = 1

	BEGIN

		UPDATE CS SET 

			 CS.ID_HISTORICO_SEMANA_1 = H.ID

			,CS.ID_HISTORICO_ATUAL = H.ID

			,CS.ID_STATUS_ESCALATION = 

										CASE WHEN H.DT_FOLLOW >= CONVERT(DATE,GETDATE(),103) THEN 2 ELSE CS.ID_STATUS_ESCALATION END

			--,H.HD_ACUMULADO	= 'teste'--H.HISTORICO_DETALHADO + CHAR(13)+ CHAR(10) + H2.HISTORICO_DETALHADO

		

		

		FROM

						[CONSOLIDADO].[TB_CONSUMO_SISCOB] CS WITH (NOLOCK)

			 INNER JOIN #TMP										  H  ON CS.ID_CONSOLIDADO = H.ID_CONSOLIDADO;

			 

		--WHERE

		--		H.ID_ANALISTA = @idAnalista

		--	AND H.STATUS = 0;		

	END

	----------------------------------------------------------------------------------------------------------------

	

	

	----------------------------------------------------------------------------------------------------------------

	-- Quando a semana atual 2, atualizar o campo ID_HISTORICO_SEMANA_2 da tabela de consumo

	ELSE IF @idSemana = 2

	BEGIN

		UPDATE CS SET 

			 ID_HISTORICO_SEMANA_2 = H.ID

			,CS.ID_HISTORICO_ATUAL = H.ID

			,CS.ID_STATUS_ESCALATION = CASE WHEN H.DT_FOLLOW >= CONVERT(DATE,GETDATE(),103) THEN 2 ELSE CS.ID_STATUS_ESCALATION END

		

		FROM

						[CONSOLIDADO].[TB_CONSUMO_SISCOB] CS WITH (NOLOCK)

			 INNER JOIN #TMP										  H  ON CS.ID_CONSOLIDADO = H.ID_CONSOLIDADO;

			 

		--WHERE

		--		H.ID_ANALISTA = @idAnalista

		--	AND H.STATUS = 0;

	END

	----------------------------------------------------------------------------------------------------------------

	

	

	----------------------------------------------------------------------------------------------------------------

	-- Quando a semana atual 3, atualizar o campo ID_HISTORICO_SEMANA_3 da tabela de consumo

	ELSE IF @idSemana = 3

	BEGIN

		UPDATE CS SET 

			 ID_HISTORICO_SEMANA_3 = H.ID

			,CS.ID_HISTORICO_ATUAL = H.ID

			,CS.ID_STATUS_ESCALATION = CASE WHEN H.DT_FOLLOW >= CONVERT(DATE,GETDATE(),103) THEN 2 ELSE CS.ID_STATUS_ESCALATION END

							

		FROM

						[CONSOLIDADO].[TB_CONSUMO_SISCOB] CS WITH (NOLOCK)

			 INNER JOIN #TMP										  H  ON CS.ID_CONSOLIDADO = H.ID_CONSOLIDADO;

			 

		--WHERE

		--		H.ID_ANALISTA = @idAnalista

		--	AND H.STATUS = 0;;

	END

	----------------------------------------------------------------------------------------------------------------

	

	----------------------------------------------------------------------------------------------------------------

	-- Quando a semana atual 4, atualizar o campo ID_HISTORICO_SEMANA_4 da tabela de consumo

	ELSE IF @idSemana = 4

	BEGIN

		UPDATE CS SET 

			 ID_HISTORICO_SEMANA_4 = H.ID

			,CS.ID_HISTORICO_ATUAL = H.ID

			,CS.ID_STATUS_ESCALATION = CASE WHEN H.DT_FOLLOW >= CONVERT(DATE,GETDATE(),103) THEN 2 ELSE CS.ID_STATUS_ESCALATION END

		

		FROM

						[CONSOLIDADO].[TB_CONSUMO_SISCOB] CS WITH (NOLOCK)

			 INNER JOIN #TMP										  H  ON CS.ID_CONSOLIDADO = H.ID_CONSOLIDADO

			 

		--WHERE

		--		H.ID_ANALISTA = @idAnalista

		--	AND H.STATUS = 0;	

	END

	----------------------------------------------------------------------------------------------------------------

	

	

	----------------------------------------------------------------------------------------------------------------

	-- Quando a semana atual 5, atualizar o campo ID_HISTORICO_SEMANA_5 da tabela de consumo



	ELSE IF @idSemana = 5

	BEGIN

		UPDATE CS SET 

			 ID_HISTORICO_SEMANA_5 = H.ID

			,CS.ID_HISTORICO_ATUAL = H.ID

			,CS.ID_STATUS_ESCALATION = CASE WHEN H.DT_FOLLOW >= CONVERT(DATE,GETDATE(),103) THEN 2 ELSE CS.ID_STATUS_ESCALATION END

		

		FROM

						[CONSOLIDADO].[TB_CONSUMO_SISCOB] CS WITH (NOLOCK)

			 INNER JOIN #TMP										  H  ON CS.ID_CONSOLIDADO = H.ID_CONSOLIDADO

			 

		--WHERE

		--		H.ID_ANALISTA = @idAnalista

		--	AND H.STATUS = 0;	

	END

	---------------------------------------------------------------------------------------------------------------

	

	---------------------------------------------------------------------------------------------------------------

	-- Alterar o Status para 1 após o processamento

	UPDATE [CONSOLIDADO].[TB_HISTORICO] SET STATUS = 1 WHERE STATUS IS NULL AND ID_ANALISTA = 38;

	---------------------------------------------------------------------------------------------------------------



	DROP TABLE #TMP;

	DROP TABLE #TMP_UH;