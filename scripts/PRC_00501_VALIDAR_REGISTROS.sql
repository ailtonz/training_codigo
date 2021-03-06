USE [DB_SISCOB]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [FILE_CAR].[PRC_00501_VALIDAR_REGISTROS]
@DIA_CAR CHAR(2)
AS
BEGIN
	
	-------------------------------------------------------------------------------------------------------------------------------------------
	DECLARE @Id_Per	 BIGINT; SET @Id_Per = (SELECT MAX(ID) FROM [DB_SISCOB].[AUXILIAR].[TB_PERIODO])
	DECLARE @Id_Per2 BIGINT; 
	
	IF @DIA_CAR = '26' 
		BEGIN
			SET @Id_Per2 = @Id_Per -1
		END

	ELSE
		BEGIN
			SET @Id_Per2 = @Id_Per
		END
	-------------------------------------------------------------------------------------------------------------------------------------------

	--VALIDAÇÃO FIXA
	--------------------------------------------------------------------------------------------------------------------------------------------

	update TF SET TF.CHECK_CAR = 1

   
	FROM
				[DB_SISCOB].[CONSOLIDADO].[TB_CONSOLIDADO]	TC	
	INNER JOIN	[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA_WEB] TF ON 
																		TC.PROCV		= TF.PROCV 
																	AND TC.ID_TIPO		= TF.ID_TIPO
																	AND LEFT(TC.SEG_DESCR,3)= LEFT(TF.SEG_DESCR,3) 
																	AND TC.ID_PERIODO	= @Id_Per2
	WHERE 
	TF.OK = 1



	--VALIDAÇÃO FIXA
	--------------------------------------------------------------------------------------------------------------------------------------------

	declare @validarFixa as varchar(50);

	set @validarFixa =
	(
	SELECT 
		SUM(CAST(T.QTDREGISTROS AS FLOAT)) AS QTDREGISTROS 
	FROM 
		(
			--FATURAS NOVAS 
			SELECT 
				count(*) as qtdRegistros , 'NOVAS' as Tipo
			FROM [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA_WEB] TF
				INNER JOIN [DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA_IMPORT] FX ON TF.ID_IMPORT_FIXA = FX.ID
				LEFT JOIN [DB_SISCOB].[CONSOLIDADO].[TB_CONSOLIDADO] C ON TF.PROCV = C.PROCV
					AND TF.ID_TIPO = C.ID_TIPO
					AND LEFT(C.SEG_DESCR, 3) = LEFT(TF.SEG_DESCR, 3)
				LEFT JOIN [DB_SISCOB].[AUXILIAR].[TB_DESCRICAO_AGING] FH ON TF.ID_FX_FECHO = FH.ID
				LEFT JOIN [DB_SISCOB].[AUXILIAR].[TB_DESCRICAO_AGING] AR ON TF.ID_FX_ARRECADA = AR.ID
				LEFT JOIN [DB_SISCOB].[AUXILIAR].[TB_TIPO] TP ON TF.ID_TIPO = TP.ID
			WHERE TF.OK = 1
				AND TF.CHECK_CAR IS NULL

		UNION

			-- FATURAS EXISTENTES
			SELECT 
				count(*) as qtdRegistros , 'EXISTENTES' as Tipo
			FROM [DB_SISCOB].[CONSOLIDADO].[TB_CONSOLIDADO] TC
				INNER JOIN [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA_WEB] TF ON TC.PROCV = TF.PROCV
					AND TC.ID_TIPO = TF.ID_TIPO
					AND LEFT(TC.SEG_DESCR, 3) = LEFT(TF.SEG_DESCR, 3)
				INNER JOIN [DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA_IMPORT] FX ON TF.ID_IMPORT_FIXA = FX.ID
				LEFT JOIN [DB_SISCOB].[AUXILIAR].[TB_DESCRICAO_AGING] FH ON TF.ID_FX_FECHO = FH.ID
				LEFT JOIN [DB_SISCOB].[AUXILIAR].[TB_DESCRICAO_AGING] AR ON TF.ID_FX_ARRECADA = AR.ID
			WHERE TF.OK = 1
				AND TC.ID_SEGMENTO = 1
				AND TC.ID_PERIODO = @Id_Per2 --<<<<<<<<<<<<<<<< PERIODO
				AND TF.CHECK_CAR = 1

		UNION

			SELECT concat('-',count(*)) AS qtdRegistros
				,CASE ISNULL(CHECK_CAR,0)
						WHEN 0 THEN 'NOVAS'
						WHEN 1 THEN 'EXISTENTES'
						ELSE 'SEM CLASSIFICACAO'
						end  as Tipo
			FROM [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA_WEB]
			WHERE ok = 1
			GROUP BY CHECK_CAR
		) t
	)

	
	-- Marcação das faturas já existens
	------------------------------------------------------------------------------------------------------------
   update TF SET TF.CHECK_CAR = 1

   FROM
					[DB_SISCOB].[CONSOLIDADO].[TB_CONSOLIDADO]	TC	
		INNER JOIN	[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL_WEB] TF ON TC.PROCV = TF.PROCV AND ID_PERIODO = @Id_Per2

   WHERE 
		TF.OK = 1


	--VALIDAÇÃO MOVEL
	--------------------------------------------------------------------------------------------------------------------------------------------
	
	declare @validarMovel as varchar(50)

	set @validarMovel =
	(
	SELECT 
		SUM(CAST(T.QTDREGISTROS AS FLOAT)) AS QTDREGISTROS 
	FROM 
		(
			--FATURAS NOVAS 
			SELECT 
				count(*) as qtdRegistros , 'NOVAS' as Tipo
			FROM
							[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL_WEB]	TM
				INNER JOIN  [DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT]		MV	ON TM.ID_IMPORT_MOVEL = MV.ID
				LEFT JOIN	[DB_SISCOB].[CONSOLIDADO].[TB_CONSOLIDADO]			C	ON 
																						TM.PROCV = C.PROCV 
																					AND	C.ID_PERIODO = 13 -- @Id_Per2 --<<<<<<<<<<<<<<<< PERIODO
				LEFT  JOIN	[DB_SISCOB].[AUXILIAR].[TB_DESCRICAO_AGING]			FH	ON TM.ID_FX_FECHO	= FH.ID 
				LEFT  JOIN	[DB_SISCOB].[AUXILIAR].[TB_DESCRICAO_AGING]			AR	ON TM.ID_FX_ARRECADA = AR.ID
				LEFT  JOIN	[DB_SISCOB].[AUXILIAR].[TB_DESCRICAO_AGING]			FN	ON TM.ID_FX_FORNECE =  FN.ID  
			WHERE
				  TM.CHECK_CAR IS NULL
				  AND TM.OK = 1		

		UNION

			-- FATURAS EXISTENTES
			SELECT 
				count(*) as qtdRegistros , 'EXISTENTES' as Tipo
			FROM
							[DB_SISCOB].[CONSOLIDADO].[TB_CONSOLIDADO]			TC	
				INNER JOIN	[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL_WEB]	TM ON TC.PROCV				= TM.PROCV
				INNER JOIN  [DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT]		MV ON TM.ID_IMPORT_MOVEL	= MV.ID
				LEFT  JOIN	[DB_SISCOB].[AUXILIAR].[TB_DESCRICAO_AGING]			FH ON TM.ID_FX_FECHO		= FH.ID 
				LEFT  JOIN	[DB_SISCOB].[AUXILIAR].[TB_DESCRICAO_AGING]			AR ON TM.ID_FX_ARRECADA		= AR.ID
				LEFT  JOIN	[DB_SISCOB].[AUXILIAR].[TB_DESCRICAO_AGING]			FN ON TM.ID_FX_FORNECE		= FN.ID 
	
			WHERE
			
					TM.OK			= 1
				AND TC.ID_PERIODO	= @Id_Per2 --<<<<<<<<<<<<<<<< PERIODO
				AND TC.ID_SEGMENTO	= 2
				AND TM.CHECK_CAR	= 1

		UNION

			SELECT concat('-',count(*)) AS qtdRegistros
				,CASE ISNULL(CHECK_CAR,0)
						WHEN 0 THEN 'NOVAS'
						WHEN 1 THEN 'EXISTENTES'
						ELSE 'SEM CLASSIFICACAO'
						end  as Tipo
			FROM [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL_WEB]
			WHERE ok = 1
			GROUP BY CHECK_CAR
		) t
	)


	if ( @validarFixa = 0 ) AND ( @validarMovel = 0 )
		BEGIN
			print 'ok!';
			--EXEC [FILE_CAR].[PRC_START_PROCESSO_FINAL_IMPORTACAO_CAR] ;
		END
	ELSE
		BEGIN
			print 'n.ok!';

		END


END
