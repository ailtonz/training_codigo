USE [DB_SISCOB]
GO
/****** Object:  StoredProcedure [FILE_CAR].[PRC_002_A_REGRA_ENREQUECIMENTO_MOVEL]    Script Date: 12/5/2016 7:36:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		LUIZ,AILTON
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [FILE_CAR].[PRC_002_A_REGRA_ENREQUECIMENTO_MOVEL]

AS
BEGIN

SET LANGUAGE Portuguese

--TRUNCATE TABLE [DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT]

--INSERT INTO [DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT] 
--	(
--	[ACORDO]
--	,[AGING_ATUAL]
--	,[AGING_ORIGINAL]
--	,[CDCLIENTE]
--	,[CDCONTA]
--	,[CICLO]
--	,[CLASSE]
--	,[CLASSIFICACAO]
--	,[CLASSSERV]
--	,[CLIENTE]
--	,[COD_SERV]
--	,[CONTA]
--	,[CPF_CNPJ]
--	,[DA]
--	,[DOCUMENTO_SAP]
--	,[DT_CADASTRO]
--	,[DTCONTA]
--	,[DTCORTE]
--	,[DTWO]
--	,[EMPRESA]
--	,[FAIXA_ATUAL]
--	,[FAIXA_ORIGINAL]
--	,[FILTRO]
--	,[GRUPO_DE_EMPRESAS]
--	,[ID_CLIENTE]
--	,[IP]
--	,[NMFATURA]
--	,[NRC]
--	,[OPERACAO]
--	,[ORIGEM]
--	,[OVERBILLING]
--	,[PARCEL_PDD]
--	,[PARCELAMENTO]
--	,[PERDA]
--	,[PF_PJ]
--	,[PRODUTO_ORIGEM]
--	,[PROVISAO]
--	,[RAIZ_CPF_CNPJ]
--	,[RECEBIVEL]
--	,[REGI_AGR]
--	,[REGRA_FX_ENT]
--	,[SALDO_CAR]
--	,[SALDO_FX_ENT]
--	,[SALDO_PDD]
--	,[SALDO_TERCEIROS]
--	,[SALDO_WO]
--	,[SEG_CLIENTE]
--	,[SEG_DESCR]
--	,[SERVTERCEIROS]
--	,[TEL]
--	,[TERM_RET_PDD]
--	,[TIPO_CLIENTE]
--	,[TITULO]
--	,[UF]
--	,[VENC_ATUAL]
--	,[VENC_ORIGINAL]
--	,[WO]
--	,[BILLING]
--	,[STATUS]
--	,[NOTA_FISCAL]
--	,[PARCELA]
--	,[DT_PROCESS]
--	,[REGRA_PDD]
--	,[AGING_CORTE]
--	,[FAIXA_CORTE]
--	,[SEG_DESCR_CLASSE]
--	,[DOC_FAT]
--	,[FILIAL]
--	,[LJ_CLI]
--	,[COD_CLI]
--	)
--SELECT 
--	[ACORDO]
--	,[AGING_ATUAL]
--	,[AGING_ORIGINAL]
--	,[CDCLIENTE]
--	,[CDCONTA]
--	,[CICLO]
--	,[CLASSE]
--	,[CLASSIFICACAO]
--	,[CLASSSERV]
--	,[CLIENTE]
--	,[COD_SERV]
--	,[CONTA]
--	,[CPF_CNPJ]
--	,[DA]
--	,[DOCUMENTO_SAP]
--	,[DT_CADASTRO]
--	,[DTCONTA]
--	,[DTCORTE]
--	,[DTWO]
--	,[EMPRESA]
--	,[FAIXA_ATUAL]
--	,[FAIXA_ORIGINAL]
--	,[FILTRO]
--	,[GRUPO_DE_EMPRESAS]
--	,[ID_CLIENTE]
--	,[IP]
--	,[NMFATURA]
--	,[NRC]
--	,[OPERACAO]
--	,[ORIGEM]
--	,[OVERBILLING]
--	,[PARCEL_PDD]
--	,[PARCELAMENTO]
--	,[PERDA]
--	,[PF_PJ]
--	,[PRODUTO_ORIGEM]
--	,[PROVISAO]
--	,[RAIZ_CPF_CNPJ]
--	,[RECEBIVEL]
--	,[REGI_AGR]
--	,[REGRA_FX_ENT]
--	,[SALDO_CAR]
--	,[SALDO_FX_ENT]
--	,[SALDO_PDD]
--	,[SALDO_TERCEIROS]
--	,[SALDO_WO]
--	,[SEG_CLIENTE]
--	,[SEG_DESCR]
--	,[SERVTERCEIROS]
--	,[TEL]
--	,[TERM_RET_PDD]
--	,[TIPO_CLIENTE]
--	,[TITULO]
--	,[UF]
--	,[VENC_ATUAL]
--	,[VENC_ORIGINAL]
--	,[WO]
--	,[BILLING]
--	,[STATUS]
--	,[NOTA_FISCAL]
--	,[PARCELA]
--	,[DT_PROCESS]
--	,[REGRA_PDD]
--	,[AGING_CORTE]
--	,[FAIXA_CORTE]
--	,[SEG_DESCR_CLASSE]
--	,[DOC_FAT]
--	,[FILIAL]
--	,[LJ_CLI]
--	,[COD_CLI]
--FROM [DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL]


------------------------------------------------------------------
---- INCLUSAO DOS DADOS VPG , LD15 e TDATA VINDAS DA FIXA
--INSERT INTO [DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT]
--SELECT * FROM [DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA] WHERE
--	[OPERACAO] = 'LD15_FIXA';
-------------------------------------------------------------------

--UPDATE [DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT] SET SALDO_CAR = REPLACE(REPLACE(SALDO_CAR,'.',''),',','.')
--WHERE [OPERACAO] = 'LD15_FIXA';

-----------------------------------------------------------------------------------------------------------


----########################################################################################################
----Processo para identiricar as Raizes Retiradas
---- ESSA INFORMAÇÃO SERÁ CONSUMIDA NO PROCESSO DE CONSOLIDACAO
----########################################################################################################


---- ##### 
---- Step1 - Criar tabela temporária para identificar as raízes e valores da tabela

----############################################################################################################
---- INICIO DO PROCESSO DE TRATAMENTO DA MOVEL
----############################################################################################################
--TRUNCATE TABLE [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL];

--INSERT INTO [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL]
--(
--	 [ID_IMPORT_MOVEL]
--	,[PROCV] 
--	,[NV_FX_FECHO]
--	,[NV_FX_ARRECADA]
--	--,[GRUPO_ANALISE]
--	--,[RAIZ_GRUPO]
--	,[RAIZ_CPF_CNPJ]
--	--,[NV_FX_FORNECE]
--	--,[GRUPO_ANALISE]
--	,[INTERCOMPANY]
--	--,[QTD_REG_AGRUPADO]
--	,[SALDO_CAR]
--	,[SALDO_PDD]
--	,[SALDO_FX_ENT]
--	,[MC]
--	,[MC2]
--	,[DIAS_POST]
--	--,[MAIOR_01_COBRAVEL]
--	--,[SEGMENTO_GERENCIA]
--	,[ANOMES]
--	--,[ANALISE_CONTA]
--	--,[CARTEIRA]
--	--,[FORNCEDOR]
--	--,[ANALISTA_TLF_VIVO]
--	,[OK]
--	--,NOME_GRUPO
--	--,RAZAO_SOCIAL
--	--,TASK_FORCE
--	--,GN
--	--,GV
--	--,DIRETOR
	
--)	

--	SELECT 
--		--------------------------------------------------------------------
--		-- Referencia de amarração da tabela TB_CAR_IMPORT_MOVEL  
--		MI.ID
--		-------------------------------------------------------------------
		
--		--------------------------------------------------------------------
--		-- Concatenar Campos para Montagem da Chave Procv 
--		,ISNULL(MI.CONTA,'')		+ 
--		 ISNULL(MI.DT_PROCESS,MI.VENC_ATUAL)	+ 
--		 CASE 
--			WHEN LEN(MI.RAIZ_CPF_CNPJ) < 8 THEN 
--				REPLICATE('0',8 - LEN(MI.RAIZ_CPF_CNPJ)) + MI.RAIZ_CPF_CNPJ 
--			ELSE MI.RAIZ_CPF_CNPJ 
--		END AS PROCV
--		--------------------------------------------------------------------
		
--		--------------------------------------------------------------------
--		-- Regra para Montagem de Aging NV_FX_FECHO
--		,CASE 
--			WHEN MI.DT_PROCESS IS NULL											THEN 'A FATURAR' 
--			WHEN MI.FAIXA_ATUAL IN ('0.1 - A vencer')							THEN '00 - A VENCER' 
--			WHEN MI.FAIXA_ATUAL IN ('0.2 - 1 a 30')								THEN '01 - DE 01 A 30' 
--			WHEN MI.FAIXA_ATUAL IN ('0.3 - 31 a 60','0.4 - 61 a 75')			THEN '02 - DE 31 A 75' 
--			WHEN MI.FAIXA_ATUAL IN ('0.5 - 76 a 90','0.6 - 91 a 105')			THEN '03 - DE 76 A 105' 
--			WHEN MI.FAIXA_ATUAL IN ('0.7 - 106 a 120','0.8 - 121 a 135',
--									'0.9 - 136 a 150','1.0 - 151 a 180',
--								    '1.1 - 181 a 210','1.2 - 211 a 240',
--								    '1.3 - 241 a 270','1.4 - 271 a 300',
--								    '1.5 - 301 a 330','1.6 - 331 a 365')		THEN '04 - DE 106 A 365' 
--			WHEN MI.FAIXA_ATUAL IN ('1.7 - Até 2 Anos','1.7 - Maior 365',
--									'1.8 - Até 3 Anos','1.9 - Até 4 Anos',
--									'2.0 - Até 5 Anos','2.1 - Acima de 5 Anos') THEN '05 - MAIOR 365' 
--			--WHEN MI.FAIXA_ATUAL = 'A FATURAR'									THEN 'A FATURAR'
--		 END AS NV_FX_FECHO
--		---------------------------------------------------------------------
		
--		---------------------------------------------------------------------
--		-- Regra para Montagem de Aging NV_FX_ARRECADA
--		,CASE 
--			WHEN MI.DT_PROCESS IS NULL											THEN 'A FATURAR' 
--			WHEN MI.FAIXA_CORTE IN ('0.1 - A vencer')							THEN '00 - A VENCER' 
--			WHEN MI.FAIXA_CORTE IN ('0.2 - 1 a 30')								THEN '01 - DE 01 A 30' 
--			WHEN MI.FAIXA_CORTE IN ('0.3 - 31 a 60','0.4 - 61 a 75')			THEN '02 - DE 31 A 75' 
--			WHEN MI.FAIXA_CORTE IN ('0.5 - 76 a 90','0.6 - 91 a 105')			THEN '03 - DE 76 A 105' 
--			WHEN MI.FAIXA_CORTE IN ('0.7 - 106 a 120','0.8 - 121 a 135',
--									'0.9 - 136 a 150','1.0 - 151 a 180',
--								    '1.1 - 181 a 210','1.2 - 211 a 240',
--								    '1.3 - 241 a 270','1.4 - 271 a 300',
--								    '1.5 - 301 a 330','1.6 - 331 a 365')		THEN '04 - DE 106 A 365' 
--			WHEN MI.FAIXA_CORTE IN ('1.7 - Até 2 Anos','1.7 - Maior 365',
--								    '1.8 - Até 3 Anos','1.9 - Até 4 Anos',
--								    '2.0 - Até 5 Anos','2.1 - Acima de 5 Anos') THEN '05 - MAIOR 365' 
--			--WHEN MI.FAIXA_CORTE = 'A FATURAR'									
--		 END AS NV_FX_ARRECADA
--		 ---------------------------------------------------------------------
		 
--		 ---------------------------------------------------------------------
				 
--		 ---------------------------------------------------------------------
--		 --Raiz Grupo Vindas da CArteira
--		 --,CASE WHEN C.RAIZ_GRUPO IS NULL THEN  
--			--(CASE WHEN LEN(MI.RAIZ_CPF_CNPJ) < 8 THEN REPLICATE('0',8 - LEN(MI.RAIZ_CPF_CNPJ)) + MI.RAIZ_CPF_CNPJ ELSE MI.RAIZ_CPF_CNPJ END)
--		 -- ELSE C.RAIZ_GRUPO END AS RAIZ_GRUPO
--		 --------------------------------------------------------------------
		  
--		 ---------------------------------------------------------------------
--		 --Formatação do campo Raiz_CPF_CNPJ 
--		 ,CASE 
--			WHEN LEN(MI.RAIZ_CPF_CNPJ) < 8 THEN 
--				REPLICATE('0',8 - LEN(MI.RAIZ_CPF_CNPJ)) + MI.RAIZ_CPF_CNPJ ELSE MI.RAIZ_CPF_CNPJ 
--		  END AS RAIZ_CPF_CNPJ
--		 ---------------------------------------------------------------------
		
--		 ---------------------------------------------------------------------
--		 -- Campo Intercompany Sim/Nao
--		,CASE 
--			WHEN MI.Tipo_Cliente IN ('INTERCOMPANY','SUBSIDIARIAS') THEN 'SIM'
--			 ELSE 'NAO' 
--		END AS INTERCOMPANY
--		 ---------------------------------------------------------------------
		
--		----------------------------------------------------------------------
		
--		----------------------------------------------------------------------
--		-- Conversão de Campos Texto para Valor
--		,CONVERT(DECIMAL(18,2),ISNULL(MI.SALDO_CAR,0))											AS SALDO_CAR
--		,CONVERT(DECIMAL(18,2),REPLACE(REPLACE(ISNULL(MI.SALDO_PDD,0),'.',''),',','.'))			AS SALDO_PDD
--		,CONVERT(DECIMAL(18,2),REPLACE(REPLACE(ISNULL(MI.SALDO_FX_ENT,0),'.',''),',','.'))		AS SALDO_FX_ENT
--		----------------------------------------------------------------------
		
--		----------------------------------------------------------------------
--		-- Regras MC/MC/DIAS_POST
--		,DATEADD(day,30,CONVERT(DATE,MI.DT_PROCESS,103))											AS MC
--		,DATEDIFF(day,CONVERT(DATE,MI.DT_PROCESS,103),CONVERT(DATE,MI.VENC_ATUAL,103))				AS MC2
--		,DATEDIFF(day,DATEADD(day,30,CONVERT(DATE,MI.DT_PROCESS,103)),CONVERT(DATE,MI.DTCORTE,103)) AS DIAS_POST
--		-----------------------------------------------------------------------
		
--		-----------------------------------------------------------------------
--		--Campo ANOMES
--		,
--		   --CONVERT(CHAR(4),YEAR(CONVERT(DATE,MI.DT_PROCESS,103))) + 
--		   --REPLICATE('0', 2-LEN(MONTH(CONVERT(DATE,MI.DT_PROCESS,103)))) + 
--		   --CONVERT(varchar(2),MONTH(CONVERT(DATE,MI.DT_PROCESS,103)))  
--		   LEFT(MI.DtConta,2) + RIGHT(MI.DtConta,4) AS ANOMES
--		-----------------------------------------------------------------------
		
--		,'OK' -- Campo para validar os registros ok 
		  
--		--,CASE WHEN C.NOME_GRUPO IS NULL THEN 
--		--	MI.CLIENTE 
--		--  ELSE C.NOME_GRUPO END AS NOME_GRUPO
		
--		--,CASE WHEN C.RAZAO_SOCIAL IS NULL THEN 
--		--	MI.CLIENTE 
--		--  ELSE C.RAZAO_SOCIAL END AS RAZAO_SOCIAL
		  		  		 
--		-- ,CASE WHEN C.TASK_FORCE = 1 THEN 'SIM'
--	 --     ELSE 'NAO' END AS TASK_FORCE
	     
--	 --    ,C.GN	     
--	 --    ,C.GV	     
--	 --    ,C.DIRETOR

--	FROM 
					
--					[DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT] MI -- TABELA DOS DADOS IMPORTADOS
		
--		-- TABELA DE CARTEIRA (DEVE SER ATUALIZADO ASSIM QUE FINALIZAR A ESTRUTURA
--		--LEFT JOIN  [DB_SISCOB].[AUXILIAR].[TB_ANALISTA_CARTEIRA_MOVEL] C ON CASE WHEN LEN(MI.RAIZ_CPF_CNPJ) < 8 THEN REPLICATE('0',8 - LEN(MI.RAIZ_CPF_CNPJ)) + MI.RAIZ_CPF_CNPJ ELSE MI.RAIZ_CPF_CNPJ END = C.RAIZ; 
--	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	
--	UPDATE M SET 
--				  M.RAIZ_GRUPO = ISNULL(C.RAIZ_GRUPO,M.RAIZ_CPF_CNPJ) 
--				 ,M.NOME_GRUPO = ISNULL(C.NOME_GRUPO,MI.CLIENTE)
--				 ,M.RAZAO_SOCIAL = ISNULL(C.RAZAO_SOCIAL,MI.CLIENTE)
--				-- ,M.TASK_FORCE = CASE WHEN C.TASK_FORCE = 1 THEN 'SIM' ELSE 'NAO' END
--				 ,M.TASK_FORCE =  C.TASK_FORCE 
--				 ,M.GN = C.GN
--				 ,M.GV = C.GV
--				 ,M.DIRETOR = C.DIRETOR
			
--	FROM	
--					[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] M
--		INNER JOIN  [DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT] MI ON M.ID_IMPORT_MOVEL = MI.ID
--		--LEFT JOIN	[DB_SISCOB].[AUXILIAR].[TB_ANALISTA_CARTEIRA_MOVEL] C ON M.[RAIZ_CPF_CNPJ] = C.RAIZ;
--		LEFT JOIN	[DB_SISCOB].[DBO].[DADOS$] C ON M.[RAIZ_CPF_CNPJ] = C.RAIZ;


---- Guardar Valores dos recebiveis em TB
--TRUNCATE TABLE [DB_SISCOB].[FILE_CAR].[TB_VALORES_TRATAMENTO_MOVEL];
--INSERT INTO [DB_SISCOB].[FILE_CAR].[TB_VALORES_TRATAMENTO_MOVEL]
---------------------------------------------------------------------------------------------
--SELECT 
--		 P.CHAVE
--		,[LD15_FIXA]	AS LD15_FIXA 
--		,[LD15_MOVEL]	AS LD15_MOVEL
--		,[OUTRAS LDs]	AS LDS
--		,[TDATA]		AS TDATA
--		,[VIVO_MOVEL]	AS VIVO_MOVEL
--		,[SALDO_FX_ENT]	AS SALDO_FX_ENT
--		,[SALDO_PDD]	AS SALDO_PDD
		
--FROM
--	(
--		SELECT 
--			 I.CONTA + 
--			 ISNULL(I.DT_PROCESS,I.VENC_ATUAL) AS CHAVE
--			,I.OPERACAO
--			,SUM(T.SALDO_CAR) AS SALDO_CAR
--		FROM
--					[DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT] I
--		INNER JOIN	[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] T ON I.ID	= T.ID_IMPORT_MOVEL
		
--		GROUP BY
--			 I.CONTA + 
--			 ISNULL(I.DT_PROCESS,I.VENC_ATUAL)
--			,I.OPERACAO	
		
--		UNION 
		
--		SELECT 
--			I.CONTA + 
--			 ISNULL(I.DT_PROCESS,I.VENC_ATUAL) AS CHAVE
--			,'SALDO_FX_ENT'
--			,SUM(T.SALDO_FX_ENT) AS SALDO_FX_ENT
--		FROM
--					[DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT] I
--		INNER JOIN	[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] T ON I.ID	= T.ID_IMPORT_MOVEL
										
--		GROUP BY
--			 I.CONTA + 
--			 ISNULL(I.DT_PROCESS,I.VENC_ATUAL)
--			,I.OPERACAO
--		UNION
		
--		SELECT 
--			 I.CONTA + 
--			 ISNULL(I.DT_PROCESS,I.VENC_ATUAL) AS CHAVE
--			,'SALDO_PDD'
--			,SUM(T.SALDO_PDD) AS SALDO_PDD
--		FROM
	
--					[DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT] I
--		INNER JOIN	[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] T ON I.ID	= T.ID_IMPORT_MOVEL
										
--		GROUP BY
--			 I.CONTA + 
--			 ISNULL(I.DT_PROCESS,I.VENC_ATUAL) 
--			,I.OPERACAO
			
--	) AS R
--	  Pivot (SUM(R.SALDO_CAR) FOR R.OPERACAO IN (
--												  [LD15_FIXA]
--												 ,[LD15_MOVEL]
--												 ,[OUTRAS LDs]
--												 ,[TDATA]
--												 ,[VIVO_MOVEL]
--												 ,[SALDO_FX_ENT]
--												 ,[SALDO_PDD]
--												 )
--	) P;
--	--Atualização Campo Analise de Conta
	
	
--	UPDATE T SET ANALISE_CONTA = 
--		CASE WHEN AC.CONTA IS NULL THEN 'FOCO'
--		ELSE 'ANALISE_CONTA'
--	END
	
--	FROM
--					[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] T
--		INNER JOIN  [DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT] M			ON T.ID_IMPORT_MOVEL = M.ID
--		LEFT JOIN	[DB_SISCOB].[AUXILIAR].[TB_ANALISE_CONTA_HISTORICO] AC  ON M.CONTA = AC.CONTA AND CONVERT(DATE,M.DT_PROCESS,103) = AC.DT_PROCESS
	
--	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	-- PROCESSO DE ATUALIZAÇAO CAMPO GRUPO ANALISE
--	-- ETAPA JURIDICO ATIVO
--	UPDATE [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] SET [GRUPO_ANALISE] = J.[POLO_ATIVO_PASSIVO]
	
--	FROM
--					[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] M
--		INNER JOIN  [DB_SISCOB].[AUXILIAR].[TB_JURIDICO] J ON M.RAIZ_CPF_CNPJ = J.RAIZ
--	WHERE
--		J.CHAVE IS NULL;
	
--	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	-- ETAPA JURIDICO PASSIVO
--	UPDATE T SET [GRUPO_ANALISE] = J.[POLO_ATIVO_PASSIVO]
	
--	FROM
--				   [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] T
--		INNER JOIN [DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT] M ON T.ID_IMPORT_MOVEL = M.ID
--		INNER JOIN [DB_SISCOB].[AUXILIAR].[TB_JURIDICO]			J ON M.CONTA = J.CONTA
	
--	WHERE 
--			T.[GRUPO_ANALISE] IS NULL
--		AND J.CHAVE IS NULL;		 
--	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	UPDATE T SET [GRUPO_ANALISE] = 'POLO_PASSIVO'
	
--	FROM
--					[DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT] M
--		INNER JOIN  [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] T ON M.ID = T.ID_IMPORT_MOVEL
	
--	WHERE 
--		M.CLASSE IN ('JU','SI');
--	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
--	-- ETAPA 3 MARCACAO DOS RETIRADOS
--	-- ** CRIAR TABELA UNICA TEMPORARIA
--	SELECT 
--		 T.RAIZ_GRUPO
--		,M.STATUS
--		,T.SALDO_CAR
--	INTO 
--		#tmp_Ret
--	FROM
--				   [DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT] M
--		INNER JOIN [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] T ON M.ID = T.ID_IMPORT_MOVEL;
--	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	UPDATE T SET T.[GRUPO_ANALISE] = 'RETIRADO'
	
--	FROM
--					[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] T
--		INNER JOIN  (
--						SELECT DISTINCT 
--							TMP.RAIZ_GRUPO
--						FROM
--						(
--							SELECT 
--								 RAIZ_GRUPO
--								,[A] AS A 
--								,[D] AS D
--								,[F] AS F
--								,[N] AS N
--							FROM
--								#tmp_Ret	   
--								Pivot (SUM(SALDO_CAR) FOR STATUS IN ([A],[D],[F],[N])) P
--						)TMP 
--						WHERE TMP.A IS NULL AND TMP.D IS NULL AND TMP.N IS NULL
		
--					) RET ON T.RAIZ_GRUPO = RET.RAIZ_GRUPO
--	WHERE T.[GRUPO_ANALISE] IS NULL
--	----------------------------------------------------------------------------------------------------------------------------------------------------------
--	-- Atualizar os registros como ativo apos o validamento do campo grupo analise	
--	UPDATE [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] SET [GRUPO_ANALISE] = 'ATIVO'
--	WHERE [GRUPO_ANALISE] IS NULL 		
	
--	-----------------------------------------------------------------------
--	-- Atribuiçao da valor do campo carteira
--	UPDATE [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] SET [CARTEIRA] = 'FIXA'
	
--	FROM
	
--					[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] T
--		INNER JOIN  [DB_SISCOB].[AUXILIAR].[TB_RAIZ_FIXA_META] M ON M.RAIZ_GRUPO = T.RAIZ_GRUPO
--	-----------------------------------------------------------------------

--DROP TABLE #tmp_Ret;	
-------------------------------------------------------------------------------------------
---- ATUALIZAÇÃO NO CAMPO  NV_FX_FORNECE
--UPDATE [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] SET [NV_FX_FORNECE] =
--CASE WHEN MC2 <= 30 THEN NV_FX_ARRECADA
--ELSE
--	(CASE WHEN MC2 > 30 AND DIAS_POST < 1					THEN	'00 - A VENCER'
--		  WHEN MC2 > 30 AND DIAS_POST BETWEEN 1   AND 30    THEN	'01 - DE 01 A 30'
--		  WHEN MC2 > 30 AND DIAS_POST BETWEEN 31  AND 75	THEN	'02 - DE 31 A 75'	
--		  WHEN MC2 > 30 AND DIAS_POST BETWEEN 76  AND 105	THEN	'03 - DE 76 A 105'
--		  WHEN MC2 > 30 AND DIAS_POST BETWEEN 106 AND 365	THEN	'04 - DE 106 A 365'
--		  WHEN MC2 > 30 AND DIAS_POST > 365					THEN	'05 - MAIOR 365'
--	 ELSE 'A FATURAR' END
--	)
--END;
-------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------
---- MARCACAO DAS RAIZES A SEREM COBRADAS
--SELECT 
--	 M.RAIZ_GRUPO
--	,M.NV_FX_FORNECE
--	,ISNULL(M.SALDO_CAR,0) AS SALDO_CAR
--INTO 
--	#tmp_Cobrar
--FROM
--	[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] M;


--UPDATE M SET 
--	M.MAIOR_01_COBRAVEL = 'X'

--FROM

--				[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] M
--	LEFT JOIN	(
--					SELECT DISTINCT
--						TMP.RAIZ_GRUPO
--					FROM
--						(
--							SELECT 
--								 RAIZ_GRUPO
--								,[A FATURAR]            AS [F] 
--								,[00 - A VENCER]		AS [0]
--								,[01 - DE 01 A 30]		AS [1]
--								,[02 - DE 31 A 75]		AS [2]
--								,[03 - DE 76 A 105]		AS [3]
--								,[04 - DE 106 A 365]	AS [4]
--								,[05 - MAIOR 365]		AS [5]
--							FROM
--								#tmp_Cobrar	   
--								Pivot (SUM(SALDO_CAR) FOR NV_FX_FORNECE IN ([A FATURAR],[00 - A VENCER],[01 - DE 01 A 30],[02 - DE 31 A 75],[03 - DE 76 A 105],[04 - DE 106 A 365],[05 - MAIOR 365])) P
--							) TMP
--							WHERE 
--									TMP.[1] IS NULL 
--								AND TMP.[2] IS NULL 
--								AND TMP.[3] IS NULL
--								AND TMP.[4] IS NULL
--								AND TMP.[5] IS NULL				
--					) N_COBRAR ON M.RAIZ_GRUPO = N_COBRAR.RAIZ_GRUPO

--			WHERE 
--				N_COBRAR.RAIZ_GRUPO IS NULL;
--DROP TABLE #tmp_Cobrar;
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
----MARCACAO DO SEGMENTO GERENCIA
--UPDATE M SET SEGMENTO_GERENCIA = 
--	CASE WHEN C.SEGMENTO_CARTEIRA = 'GCN'		AND NOT M.GRUPO_ANALISE = 'RETIRADO'	THEN 'GCN'
--		 WHEN C.SEGMENTO_CARTEIRA = 'GCN'		AND M.GRUPO_ANALISE = 'RETIRADO' 		THEN 'GCN - RETIRADOS'
--	END

--FROM 
--				[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] M
--	INNER JOIN  [DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT] MI ON M.ID_IMPORT_MOVEL = MI.ID
--	--LEFT JOIN	[DB_SISCOB].[AUXILIAR].[TB_ANALISTA_CARTEIRA_MOVEL] C ON M.RAIZ_CPF_CNPJ = C.RAIZ;
--	LEFT JOIN	[DB_SISCOB].[DBO].[DADOS$] C ON M.RAIZ_CPF_CNPJ = C.RAIZ;

	
---------------------------------------------------------------------------------------------

--UPDATE M SET M.SEGMENTO_GERENCIA =	
--	CASE 
--		WHEN VPE.GRUPO_ANALISE = 'RETIRADO' THEN 'GCN - RETIRADOS'
--		ELSE 'GCN'
--	END
--FROM 
--				[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] M
--	INNER JOIN  [DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT] MI ON M.ID_IMPORT_MOVEL = MI.ID
--	INNER JOIN	(
--					SELECT DISTINCT 
--						 M.RAIZ_GRUPO
--						,M.GRUPO_ANALISE
--					FROM
--									[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] M
--						INNER JOIN  [DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT] MI ON M.ID_IMPORT_MOVEL = MI.ID
--					WHERE
--							MI.SEG_DESCR LIKE 'VPE%'
--						AND SEGMENTO_GERENCIA IS NULL
--				) AS VPE ON VPE.RAIZ_GRUPO = M.RAIZ_GRUPO

--WHERE SEGMENTO_GERENCIA IS NULL;
---------------------------------------------------------------------------------------

--UPDATE M SET M.SEGMENTO_GERENCIA =	
--	CASE 
--		WHEN VPK.GRUPO_ANALISE = 'RETIRADO' THEN 'VPK - RETIRADOS'
--		ELSE 'VPK'
--	END
--FROM 
--				[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] M
--	INNER JOIN  [DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT] MI ON M.ID_IMPORT_MOVEL = MI.ID
--	INNER JOIN	(
--					SELECT DISTINCT 
--						 M.RAIZ_GRUPO
--						,M.GRUPO_ANALISE
--					FROM
--									[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] M
--						INNER JOIN  [DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT] MI ON M.ID_IMPORT_MOVEL = MI.ID
--					WHERE
--							MI.SEG_DESCR LIKE 'VPK%'
--						AND SEGMENTO_GERENCIA IS NULL
--				) AS VPK ON VPK.RAIZ_GRUPO = M.RAIZ_GRUPO

--WHERE SEGMENTO_GERENCIA IS NULL;
--------------------------------------------------------------------------------------------

--UPDATE [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] SET SEGMENTO_GERENCIA = 'TOP_PMES'
--WHERE SEGMENTO_GERENCIA IS NULL;

--------------------------------------------------------------------------------------------
----UPDATE [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] SET FORNECEDOR = NULL
-----------------------------------------------------------------------------------------------


----##########################################################################################################################
----ATUALIZAÇÃO CAMPO SITUACAO_SERVICO
----##########################################################################################################################
--	UPDATE TI set [SITUACAO_SERVICO] = 
		
--		CASE WHEN FI.[STATUS] = 'A' THEN 'ATIVO'
--			 WHEN FI.[STATUS] = 'F' THEN 'CANCELADO'
--			 WHEN FI.[STATUS] = 'N' THEN 'SUSPENSO (FASE DE RÉGUA)' 
--		END 
		
--	FROM 
--					[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] TI
--		INNER JOIN  [DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT] FI ON TI.ID_IMPORT_MOVEL = FI.ID;




---- Atualização dos clientes IP
--UPDATE T SET T.FORNECEDOR = 'IP'

--FROM
--			[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] T	
--INNER JOIN	[DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT] I ON T.ID_IMPORT_MOVEL = I.ID	

--WHERE 
--		I.IP = 'SIM'
--	AND I.status = 'F'
--	AND CONVERT(DATE,I.DT_CADASTRO,103) < '2015-01-01'
--	AND NOT T.TASK_FORCE = 'SIM'


---- Atualizar as reizes SERVICES
--UPDATE T SET T.FORNECEDOR = 'SERVICES'

--FROM
--			[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] T	
--INNER JOIN	[DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT] I ON T.ID_IMPORT_MOVEL = I.ID	
--INNER JOIN	
--		    (
--				SELECT DISTINCT
--					M.RAIZ_GRUPO
--				FROM
--								[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] M
--					INNER JOIN  [DB_SISCOB].[FILE_CAR].[TB_CAR_MOVEL_IMPORT] I ON M.ID_IMPORT_MOVEL = I.ID
--				WHERE
--						M.GRUPO_ANALISE		IN ('ATIVO','RETIRADO')
--					AND	M.MAIOR_01_COBRAVEL = 'X'
--					AND M.INTERCOMPANY		= 'NAO'
--					AND I.SEG_DESCR = 'VPG-TOP-GOV'
--					--AND M.SEGMENTO_GERENCIA = 'TOP_PMES'
--		    ) SERV ON SERV.RAIZ_GRUPO = T.RAIZ_GRUPO
--WHERE
--			T.GRUPO_ANALISE		IN ('ATIVO','RETIRADO')
--		AND	T.MAIOR_01_COBRAVEL = 'X'
--		AND T.INTERCOMPANY		= 'NAO'
		
-------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------
---- GUARDAR AS 140 RAIZES DE MAIOR VALOR QUE NAO PERTENCER A SERVICE
--SELECT TOP 140
--		 SUM(SALDO_CAR) AS SALDO_CAR 
--		,RAIZ_GRUPO
--INTO #TOP		
--FROM 
--	[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] M
--WHERE 
--		SEGMENTO_GERENCIA = 'TOP_PMES'
--	AND	MAIOR_01_COBRAVEL = 'X'
--	AND INTERCOMPANY = 'NAO'
--	AND M.GRUPO_ANALISE	= 'ATIVO'
--	AND M.FORNECEDOR IS NULL
--	AND M.OK = 'OK'
--GROUP BY
--	RAIZ_GRUPO
--ORDER BY 
--	SALDO_CAR DESC

----SELECT SUM(SALDO_CAR) FROM #TOP
--UPDATE T SET FORNECEDOR = 'ACCENTURE'

--FROM
--			[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] T
--INNER JOIN  #TOP ON T.RAIZ_GRUPO = #TOP.RAIZ_GRUPO

--WHERE
--		SEGMENTO_GERENCIA = 'TOP_PMES'
--	AND	MAIOR_01_COBRAVEL = 'X'
--	AND INTERCOMPANY = 'NAO'
--	AND T.GRUPO_ANALISE	= 'ATIVO'
--	AND T.FORNECEDOR IS NULL
--	AND T.OK = 'OK'

-------------------------------------------------------------------------------------
---- Marcar o restante fornecedor em branco como ACCENTURE, com base na lista 
---- TOP 140
----UPDATE T SET FORNECEDOR = 'ACCENTURE'

----FROM
----			[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] T
----INNER JOIN  #TOP ON T.RAIZ_GRUPO = #TOP.RAIZ_GRUPO

----WHERE T.FORNECEDOR IS NULL;
--DROP TABLE #TOP;
-------------------------------------------------------------------------------------

--UPDATE T SET FORNECEDOR = F.FORNECEDOR

--FROM

--			 [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] T
--INNER JOIN	 [DB_SISCOB].[AUXILIAR].[TB_FORNECEDOR] F ON T.RAIZ_GRUPO = F.RAIZ_GRUPO
----LEFT JOIN  [DB_SISCOB].[AUXILIAR].[TB_ANALISTA_CARTEIRA_MOVEL] C ON T.RAIZ_CPF_CNPJ = C.RAIZ

	
--WHERE 
--	--C.TASK_FORCE = 1
--		 F.FORNECEDOR LIKE 'ACCENTURE%'
--	 AND T.GRUPO_ANALISE		= 'ATIVO'
--	 AND	T.MAIOR_01_COBRAVEL = 'X'
--	 and t.SEGMENTO_GERENCIA IN ('GCN','VPK')
--	 AND T.FORNECEDOR IS NULL

--UPDATE T SET FORNECEDOR = 'ACCENTURE'

--FROM

--			 [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] T
----LEFT JOIN  [DB_SISCOB].[AUXILIAR].[TB_ANALISTA_CARTEIRA_MOVEL] C ON T.RAIZ_CPF_CNPJ = C.RAIZ

	
--WHERE 
--	--C.TASK_FORCE = 1
--	        T.GRUPO_ANALISE		= 'ATIVO'
--	 AND	T.MAIOR_01_COBRAVEL = 'X'
--	 and t.SEGMENTO_GERENCIA IN ('GCN','VPK')
--	 and t.FORNECEDOR IS NULL


----------------------------------------------------
---- Identificar os Fornecedores já atribuidos
---- que são TASK FORCE

--SELECT DISTINCT 
--	 T.RAIZ_GRUPO
--	,T.FORNECEDOR	
--INTO #TMP_FORNECEDOR
--FROM
--			 [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] T
----INNER JOIN	 [DB_SISCOB].[AUXILIAR].[TB_FORNECEDOR] F ON T.RAIZ_GRUPO = F.RAIZ_GRUPO
--INNER JOIN   [DB_SISCOB].[DBO].[DADOS$] C ON T.RAIZ_CPF_CNPJ = C.RAIZ


--WHERE 
--		FORNECEDOR LIKE 'ACCENTURE%'
--	AND C.TASK_FORCE = 'SIM'

---------------------------------------------------
---- Atualizar  os fornecedores identificados Task
--UPDATE T SET FORNECEDOR = #TMP_FORNECEDOR.FORNECEDOR

--FROM

--			   [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] T
--	INNER JOIN #TMP_FORNECEDOR ON T.RAIZ_GRUPO = #TMP_FORNECEDOR.RAIZ_GRUPO
--	--INNER JOIN  [DB_SISCOB].[AUXILIAR].[TB_ANALISTA_CARTEIRA_MOVEL] C ON T.RAIZ_CPF_CNPJ = C.RAIZ
--	INNER JOIN   [DB_SISCOB].[DBO].[DADOS$] C ON T.RAIZ_CPF_CNPJ = C.RAIZ
--WHERE 
--		T.FORNECEDOR IS NULL
--	AND C.TASK_FORCE = 'SIM';
---------------------------------------------------

------Atualizar as raizes
----UPDATE T SET FORNECEDOR = 'ACCENTURE'

----FROM

----			 [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] T
----INNER JOIN	 [DB_SISCOB].[AUXILIAR].[TB_FORNECEDOR] F ON T.RAIZ_GRUPO = F.RAIZ_GRUPO
----INNER JOIN   [DB_SISCOB].[AUXILIAR].[TB_ANALISTA_CARTEIRA_MOVEL] C ON T.RAIZ_CPF_CNPJ = C.RAIZ

	
----WHERE 
----	C.TASK_FORCE = 1
----	AND T.FORNECEDOR IS NULL 
	
------------------------------------------------------------------------------------------------
---- Atualizar o Campo fornecedor com base na lista de fornecedores	 
--UPDATE M SET FORNECEDOR = F.FORNECEDOR
	
--FROM 
--				[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL]	M
--	INNER JOIN  [DB_SISCOB].[AUXILIAR].[TB_FORNECEDOR]			F ON M.RAIZ_GRUPO = F.RAIZ_GRUPO

--WHERE 
--		M.GRUPO_ANALISE			= 'ATIVO'
--	AND M.MAIOR_01_COBRAVEL		= 'X'
--	AND M.INTERCOMPANY			= 'NAO'
--	AND	M.FORNECEDOR			IS NULL
--	AND (F.FORNECEDOR NOT LIKE 'ACCENTURE%' AND NOT F.FORNECEDOR = 'SERVICES')
	
------------------------------------------------------------------------------------------------
---- MARCAR TODOS OS RETIRADOS COM MASTER
--UPDATE [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] SET FORNECEDOR = 'MASTER'

--WHERE 
--		GRUPO_ANALISE = 'RETIRADO'
--	AND	MAIOR_01_COBRAVEL = 'X'
--	AND INTERCOMPANY = 'NAO'
--	AND FORNECEDOR IS NULL
------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------
---- PROCESSO PARA DEFINIR CLIENTES MASTER E FULL TIME
---- 60% MASTER
---- 40% FULL TIME


---- IDENTIFICAR OS VALORES EM ACUMULADO DAS RAIZES SEM DISTRIBUICAO
---- RESPEITANDOS OS CRITERIOS DEFINIDOS
---------------------------------------------------------------------
--SELECT 
--		RAIZ_GRUPO
--		,SUM(SALDO_CAR) AS SALDO_CAR
--INTO 
--	#TempTable1 
--FROM 
--	[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] 
--WHERE 
--		MAIOR_01_COBRAVEL = 'X'
--	AND INTERCOMPANY = 'NAO'
--	AND GRUPO_ANALISE	= 'ATIVO' 
--	AND SEGMENTO_GERENCIA = 'TOP_PMES'
--	AND FORNECEDOR IS NULL
--GROUP BY 
--	RAIZ_GRUPO
--ORDER BY SALDO_CAR DESC;


----------------------------------------------------------
--SELECT 
--	ROW_NUMBER() OVER(ORDER BY SALDO_CAR DESC) AS ID
--	,RAIZ_GRUPO
--	,SALDO_CAR
--INTO 
--	#TempTable2 
--FROM 
--	#TempTable1; 
----------------------------------------------------------
--SELECT 
--	  T1.RAIZ_GRUPO
--	, T1.SALDO_CAR
--	, SUM(T2.SALDO_CAR) as ACUMULADO
--INTO 
--	#TMP_AC
--FROM 
--			#TempTable2 AS T1
--INNER JOIN	#TempTable2 AS T2 ON T1.ID >= T2.ID
--GROUP BY 
--		T1.RAIZ_GRUPO
--	,	T1.SALDO_CAR
--order by 
--	ACUMULADO; 
-----------------------------------------------------
---- Exclusao das Temporárias
--DROP TABLE #TempTable1
--DROP TABLE #TempTable2
-----------------------------------------------------

-----------------------------------------------------
---- IDENTIFICAR O PERCENTUAL FALTANTE PARA CADA FORNECEDOR

---- Armazenar valor total
------------------------------------------------------------
--DECLARE @SALDO_TOTAL AS DECIMAL(18,2) SET @SALDO_TOTAL = (
--	SELECT 
--		SUM(SALDO_CAR)
--	FROM 
--		[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] 
--	WHERE 
--	        MAIOR_01_COBRAVEL = 'X'
--		AND INTERCOMPANY = 'NAO'
--		AND GRUPO_ANALISE	= 'ATIVO' 
--		AND SEGMENTO_GERENCIA = 'TOP_PMES'
--		AND (FORNECEDOR IN ('MASTER','FULL TIME') OR FORNECEDOR IS NULL))
------------------------------------------------------------

------------------------------------------------------------
---- Caludo percentual faltante e armazenamento em outra temp
------------------------------------------------------------
--SELECT 
--		 FORNECEDOR
--		,SUM(SALDO_CAR) AS SALDO_CAR
--		,SUM(SALDO_CAR)/@SALDO_TOTAL AS PERC
--		, CASE WHEN FORNECEDOR = 'MASTER'		THEN (0.6 - (SUM(SALDO_CAR)/@SALDO_TOTAL)) * @SALDO_TOTAL 
--			   WHEN FORNECEDOR = 'FULL TIME'	THEN (0.4 - (SUM(SALDO_CAR)/@SALDO_TOTAL)) * @SALDO_TOTAL 
--		  ELSE NULL END AS VAL_CHEGADA
--INTO 
--	#Chegada
--FROM 
--	[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] 
--WHERE 
--		MAIOR_01_COBRAVEL = 'X'
--	AND INTERCOMPANY = 'NAO'
--	AND GRUPO_ANALISE	= 'ATIVO' 
--	AND SEGMENTO_GERENCIA = 'TOP_PMES'
--	AND (FORNECEDOR IN ('MASTER','FULL TIME') OR FORNECEDOR IS NULL)
--GROUP BY 
--	FORNECEDOR;
---------------------------------------------------------------


---------------------------------------------------------------
---- Atualização do Fornecedor Master
---- Considerando as raizes que estão na faixa do acumulado 
---------------------------------------------------------------		
--UPDATE [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] SET FORNECEDOR = 'MASTER'
--WHERE 
--	RAIZ_GRUPO IN (
--					SELECT 
--						T.RAIZ_GRUPO
--						--T.ACUMULADO
--					FROM
--						#TMP_AC	T
--					WHERE
--						T.ACUMULADO <=
--						(SELECT #Chegada.VAL_CHEGADA FROM #Chegada WHERE FORNECEDOR = 'MASTER')
--					)
--		AND MAIOR_01_COBRAVEL	= 'X'
--		AND INTERCOMPANY		= 'NAO'
--		AND GRUPO_ANALISE		= 'ATIVO' 
--		AND SEGMENTO_GERENCIA = 'TOP_PMES'
--		AND FORNECEDOR IS NULL;
-------------------------------------------------------------------------------------------------
---- Atualização do restante de raizes em branco para full time
--UPDATE [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] SET FORNECEDOR = 'FULL TIME'
--WHERE     
--		MAIOR_01_COBRAVEL	= 'X'
--	AND INTERCOMPANY		= 'NAO'
--	AND GRUPO_ANALISE		= 'ATIVO' 
--	AND SEGMENTO_GERENCIA = 'TOP_PMES'
--	AND FORNECEDOR IS NULL;
-------------------------------------------------------------------------------------------------
---- Exclusao das Temporárias
--DROP TABLE #Chegada;
--DROP TABLE #TMP_AC;
-------------------------------------------------------------------------------------------------

---- Limar o Campo Carteira para os Fornecederos Accenture1
----------------------------------------------------------------------------------------------------------
--UPDATE [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] SET CARTEIRA  = NULL WHERE FORNECEDOR = 'ACCENTURE1'

---- Atribuir Carteira Fixa quando fornecedor Accenture e Intercompany = Sim
-------------------------------------------------------------------------------------------------------------------------------------
--UPDATE [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] SET CARTEIRA  = 'FIXA' WHERE FORNECEDOR = 'ACCENTURE' AND INTERCOMPANY = 'SIM'
-------------------------------------------------------------------------------------------------
---- ATUALIZACAO ANALISTA TLF
--UPDATE T SET [ANALISTA_TLF_VIVO] = F.[ANALISTA_TLF]

--FROM
--				[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] T
--	INNER JOIN  [DB_SISCOB].[AUXILIAR].[TB_REGRA_ANALISTA_TLF] F ON T.FORNECEDOR = F.FORNECEDOR AND F.ID_REGRA = 1
---------------------------------------------------------------------------------------------------
--UPDATE T SET [ANALISTA_TLF_VIVO] = F.[ANALISTA_TLF]

--FROM
--				[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] T
--	INNER JOIN  [DB_SISCOB].[AUXILIAR].[TB_REGRA_ANALISTA_TLF] F ON T.SEGMENTO_GERENCIA = F.[SEGMENTO_GERENCIA] AND F.ID_REGRA = 2

--WHERE
--	T.ANALISTA_TLF_VIVO IS NULL
---------------------------------------------------------------------------------------------------
--UPDATE T SET [ANALISTA_TLF_VIVO] = F.[ANALISTA_TLF]

--FROM
--				[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] T
--	--INNER JOIN  [DB_SISCOB].[AUXILIAR].[TB_ANALISTA_CARTEIRA_MOVEL] C ON C.RAIZ_GRUPO	= T.RAIZ_GRUPO
--	INNER JOIN   [DB_SISCOB].[DBO].[DADOS$] C ON C.RAIZ_GRUPO	= T.RAIZ_GRUPO
--	INNER JOIN  [DB_SISCOB].[AUXILIAR].[TB_REGRA_ANALISTA_TLF]		F ON C.GV			= F.[NOME_GV] AND F.ID_REGRA = 3

--WHERE
--	T.ANALISTA_TLF_VIVO IS NULL
---------------------------------------------------------------------------------------------------

----DROP TABLE #TMP_VALORES

----#############################################################################################
----AGRUPAMENTO DAS CHAVES DUPLICADAS
----#############################################################################################
--UPDATE F SET [OK] = 'NOK'
--FROM 
	
--				[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] F 
--	INNER JOIN
--			(
--				SELECT 
--					 TMP.PROCV 
--				FROM
--					(
--					 SELECT 
--						 F.PROCV 
--						,COUNT(1) AS CONTAR 
--					 FROM
--						[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] F
--					 GROUP BY
--						 F.PROCV 
--					) AS TMP
--				WHERE TMP.CONTAR > 1
		
--			) AS CHAVES ON F.PROCV = CHAVES.PROCV



--INSERT INTO [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL]
--(
--	 [ID_IMPORT_MOVEL]
--	,[PROCV] 
--	,[NV_FX_FECHO]
--	,[NV_FX_ARRECADA]
--	,[GRUPO_ANALISE]
--	,[RAIZ_GRUPO]
--	,[RAIZ_CPF_CNPJ]
--	,[NV_FX_FORNECE]
--	,[INTERCOMPANY]
--	,[QTD_REG_AGRUPADO]
--	,[SALDO_CAR]
--	,[SALDO_PDD]
--	,[SALDO_FX_ENT]
--	,[MC]
--	,[MC2]
--	,[DIAS_POST]
--	,[MAIOR_01_COBRAVEL]
--	,[SEGMENTO_GERENCIA]
--	,[ANOMES]
--	,[ANALISE_CONTA]
--	,[CARTEIRA]
--	,[FORNECEDOR]
--	,[ANALISTA_TLF_VIVO]
--	,[OK]
--	,NOME_GRUPO
--	,RAZAO_SOCIAL
--	,TASK_FORCE
--	,GN
--	,GV
--	,DIRETOR
--)

--	SELECT
	
--		 SOMA_E.ID
--		,SOMA_E.[PROCV]
--		,SOMA_E.[NV_FX_FECHO]
--		,SOMA_E.[NV_FX_ARRECADA]
--		,[GRUPO_ANALISE]
--		,[RAIZ_GRUPO]
--		,[RAIZ_CPF_CNPJ]
--		,SOMA_E.[NV_FX_FORNECE]
--		,[INTERCOMPANY]
--	    ,SOMA_E.CONTAR
--		,SOMA_E.[SALDO_CAR]
--		,SOMA_E.[SALDO_PDD]
--		,SOMA_E.[SALDO_FX_ENT]
--		,[MC]
--		,[MC2]
--		,[DIAS_POST]
--		,[MAIOR_01_COBRAVEL]
--		,[SEGMENTO_GERENCIA]
--		,[ANOMES]
--		,[ANALISE_CONTA]
--		,[CARTEIRA]
--		,[FORNECEDOR]
--	    ,[ANALISTA_TLF_VIVO]
--		,'OK'
--		,NOME_GRUPO
--		,RAZAO_SOCIAL
--		,TASK_FORCE
--		,GN
--		,GV
--		,DIRETOR
	
		 
--		FROM 
--					[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] F
--		INNER JOIN
--					(
--						SELECT 
--						  		 FE.PROCV
--						  		,MAX(FE.NV_FX_ARRECADA) AS NV_FX_ARRECADA
--						  		,MAX(FE.NV_FX_FECHO)	AS NV_FX_FECHO
--						  		,MAX(FE.NV_FX_FORNECE)	AS NV_FX_FORNECE
--								,COUNT(1) AS CONTAR
--								,MAX(FE.ID_IMPORT_MOVEL) AS ID
--								,SUM(ISNULL(FE.[SALDO_CAR],0))			AS SALDO_CAR
--								,SUM(ISNULL(FE.[SALDO_PDD],0))			AS SALDO_PDD
--								,SUM(ISNULL(FE.[SALDO_FX_ENT],0))		AS SALDO_FX_ENT
--						FROM 
--							[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] FE
--						WHERE 
--							FE.ok = 'NOK'
--						GROUP BY
--							FE.PROCV
						
	
--					) SOMA_E ON SOMA_E.ID = F.ID_IMPORT_MOVEL ;

----#############################################################################################
---- PREENCHIMENTO DE QUADRO DE VALIDACAO
----#############################################################################################


--INSERT INTO [DB_SISCOB].[FILE_CAR].[QUADRO_VALIDACAO_CAR]
--(	
--	 [TIPO]
--	,[SALDO_CAR]
--	,[SALDO_PDD]
--	,[SALDO_FX_ENT]
--	,[SALDO_TERCEIROS]
--	,[SALDO_WO]
--	,[QTD_REGISTROS]
--	,[QTD_REG_AGRUPADO]
--	,[SEGMENTO]
--)

--SELECT 
--		 'DADOS_ATLYS'							AS TIPO
--		,SUM(F.[SALDO_CAR])						AS SALDO_CAR
--		,SUM(F.[SALDO_PDD])						AS SALDO_PDD
--		,SUM(F.[SALDO_FX_ENT])					AS SALDO_FX_ENT
--		,0										AS SALDO_TERCEIROS
--		,0										AS SALDO_WO
--		,COUNT(*)								AS QTD_REGISTROS
--		,SUM(ISNULL(F.[QTD_REG_AGRUPADO],0))	AS QTD_REG_AGRUPADO 
--		,'MOVEL'								AS SEGMENTO
		
--		FROM
--			[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_MOVEL] F
--		WHERE ok = 'ok'


END


