USE [DB_SISCOB]
GO
/****** Object:  StoredProcedure [FILE_CAR].[PRC_001_REGRA_ENREQUECIMENTO_FIXA]    Script Date: 12/5/2016 7:32:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		LUIZ,AILTON
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [FILE_CAR].[PRC_001_REGRA_ENREQUECIMENTO_FIXA]

AS
BEGIN

SET LANGUAGE Portuguese

--####################################################################################
--PROCESSO DE ATUALIZAÇÃO DA BASE AUXILIAR INTRAGOV
--####################################################################################

-- LIMPAR TABELA
--	TRUNCATE TABLE [DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA_IMPORT]

---- INSERIR DADOS
--	INSERT INTO [DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA_IMPORT] 
--		(
--		[ACORDO]
--		,[AGING_ATUAL]
--		,[AGING_ORIGINAL]
--		,[CDCLIENTE]
--		,[CDCONTA]
--		,[CICLO]
--		,[CLASSE]
--		,[CLASSIFICACAO]
--		,[CLASSSERV]
--		,[CLIENTE]
--		,[COD_SERV]
--		,[CONTA]
--		,[CPF_CNPJ]
--		,[DA]
--		,[DOCUMENTO_SAP]
--		,[DT_CADASTRO]
--		,[DTCONTA]
--		,[DTCORTE]
--		,[DTWO]
--		,[EMPRESA]
--		,[FAIXA_ATUAL]
--		,[FAIXA_ORIGINAL]
--		,[FILTRO]
--		,[GRUPO_DE_EMPRESAS]
--		,[ID_CLIENTE]
--		,[IP]
--		,[NMFATURA]
--		,[NRC]
--		,[OPERACAO]
--		,[ORIGEM]
--		,[OVERBILLING]
--		,[PARCEL_PDD]
--		,[PARCELAMENTO]
--		,[PERDA]
--		,[PF_PJ]
--		,[PRODUTO_ORIGEM]
--		,[PROVISAO]
--		,[RAIZ_CPF_CNPJ]
--		,[RECEBIVEL]
--		,[REGI_AGR]
--		,[REGRA_FX_ENT]
--		,[SALDO_CAR]
--		,[SALDO_FX_ENT]
--		,[SALDO_PDD]
--		,[SALDO_TERCEIROS]
--		,[SALDO_WO]
--		,[SEG_CLIENTE]
--		,[SEG_DESCR]
--		,[SERVTERCEIROS]
--		,[TEL]
--		,[TERM_RET_PDD]
--		,[TIPO_CLIENTE]
--		,[TITULO]
--		,[UF]
--		,[VENC_ATUAL]
--		,[VENC_ORIGINAL]
--		,[WO]
--		,[BILLING]
--		,[STATUS]
--		,[NOTA_FISCAL]
--		,[PARCELA]
--		,[DT_PROCESS]
--		,[REGRA_PDD]
--		,[AGING_CORTE]
--		,[FAIXA_CORTE]
--		,[SEG_DESCR_CLASSE]
--		,[DOC_FAT]
--		,[FILIAL]
--		,[LJ_CLI]
--		,[COD_CLI]
--		)
--	SELECT 
--		 [ACORDO]
--		,[AGING_ATUAL]
--		,[AGING_ORIGINAL]
--		,[CDCLIENTE]
--		,[CDCONTA]
--		,[CICLO]
--		,[CLASSE]
--		,[CLASSIFICACAO]
--		,[CLASSSERV]
--		,[CLIENTE]
--		,[COD_SERV]
--		,[CONTA]
--		,[CPF_CNPJ]
--		,[DA]
--		,[DOCUMENTO_SAP]
--		,[DT_CADASTRO]
--		,[DTCONTA]
--		,[DTCORTE]
--		,[DTWO]
--		,[EMPRESA]
--		,[FAIXA_ATUAL]
--		,[FAIXA_ORIGINAL]
--		,[FILTRO]
--		,[GRUPO_DE_EMPRESAS]
--		,[ID_CLIENTE]
--		,[IP]
--		,[NMFATURA]
--		,[NRC]
--		,[OPERACAO]
--		,[ORIGEM]
--		,[OVERBILLING]
--		,[PARCEL_PDD]
--		,[PARCELAMENTO]
--		,[PERDA]
--		,[PF_PJ]
--		,[PRODUTO_ORIGEM]
--		,[PROVISAO]
--		,[RAIZ_CPF_CNPJ]
--		,[RECEBIVEL]
--		,[REGI_AGR]
--		,[REGRA_FX_ENT]
--		,[SALDO_CAR]
--		,[SALDO_FX_ENT]
--		,[SALDO_PDD]
--		,[SALDO_TERCEIROS]
--		,[SALDO_WO]
--		,[SEG_CLIENTE]
--		,[SEG_DESCR]
--		,[SERVTERCEIROS]
--		,[TEL]
--		,[TERM_RET_PDD]
--		,[TIPO_CLIENTE]
--		,[TITULO]
--		,[UF]
--		,[VENC_ATUAL]
--		,[VENC_ORIGINAL]
--		,[WO]
--		,[BILLING]
--		,[STATUS]
--		,[NOTA_FISCAL]
--		,[PARCELA]
--		,[DT_PROCESS]
--		,[REGRA_PDD]
--		,[AGING_CORTE]
--		,[FAIXA_CORTE]
--		,[SEG_DESCR_CLASSE]
--		,[DOC_FAT]
--		,[FILIAL]
--		,[LJ_CLI]
--		,[COD_CLI]
--	FROM [DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA]

--INSERT INTO [DB_SISCOB].[AUXILIAR].[TB_INTRAGOV_CONTAS]
--(
--  CONTA
--)

--SELECT DISTINCT 
--	CONTA
--FROM 
--	[DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA_IMPORT] 
--WHERE 
--		CICLO = '35'
--	AND CONTA NOT IN (SELECT CONTA FROM [DB_SISCOB].[AUXILIAR].[TB_INTRAGOV_CONTAS])



----####################################################################################
----LIMPAR TABELA SEMPRE AO INICIAR O PROCESSO DE ENREQUECIMENTO
----####################################################################################
--TRUNCATE TABLE [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA];

--INSERT INTO [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA]
--(
--	 ID_IMPORT_FIXA
--	,NV_FX_FECHO
--	,NV_FX_ARRECADA
--	,SPEEDY_PROVIDER
--	--,LOCAL
--	--,TERMINAL
--	--,DV
--	,TIPO
--	--,NUMERO_LOTE
--	--,DIA_VENCIMENTO
--	,INTRAGOV
--	,INTERCOMPANY
--	,SALDO_CAR
--	,SALDO_PDD
--	,SALDO_FX_ENT
--	,SALDO_TERCEIROS
--	,SALDO_WO
--	,OK
--	--,RAIZ_GRUPO
--	--,NOME_GRUPO
--	--,RAZAO_SOCIAL
--	 ,RAIZ_CPF_CNPJ
--	--,TASK_FORCE
--	--,GN
--	--,GV
--	--,DIRETOR
--	,NRC
--	--,N_DOC_DE_PARA_ATLYS
--)	

--	SELECT 
--		 FI.ID
		
--		,CASE 
--			WHEN FI.FAIXA_ATUAL IN ('0.1 - A vencer') Then '00 - A VENCER' 
--			WHEN FI.FAIXA_ATUAL IN ('0.2 - 1 a 30') THEN '01 - DE 01 A 30' 
--			WHEN FI.FAIXA_ATUAL IN ('0.3 - 31 a 60','0.4 - 61 a 75') THEN '02 - DE 31 A 75' 
--			WHEN FI.FAIXA_ATUAL IN ('0.5 - 76 a 90','0.6 - 91 a 105')THEN '03 - DE 76 A 105' 
--			WHEN FI.FAIXA_ATUAL IN ('0.7 - 106 a 120','0.8 - 121 a 135','0.9 - 136 a 150','1.0 - 151 a 180',
--								    '1.1 - 181 a 210','1.2 - 211 a 240','1.3 - 241 a 270','1.4 - 271 a 300',
--								    '1.5 - 301 a 330','1.6 - 331 a 365') THEN '04 - DE 106 A 365' 
--			WHEN FI.FAIXA_ATUAL IN ('1.7 - Até 2 Anos','1.7 - Maior 365',
--								  '1.8 - Até 3 Anos','1.9 - Até 4 Anos','2.0 - Até 5 Anos','2.1 - Acima de 5 Anos') THEN '05 - MAIOR 365' 
--			WHEN FI.FAIXA_ATUAL = 'A FATURAR'  THEN 'A FATURAR'
--		 END AS NV_FX_FECHO
		
--		,CASE 
--			WHEN FI.FAIXA_CORTE IN ('0.1 - A vencer') Then '00 - A VENCER' 
--			WHEN FI.FAIXA_CORTE IN ('0.2 - 1 a 30') THEN '01 - DE 01 A 30' 
--			WHEN FI.FAIXA_CORTE IN ('0.3 - 31 a 60','0.4 - 61 a 75') THEN '02 - DE 31 A 75' 
--			WHEN FI.FAIXA_CORTE IN ('0.5 - 76 a 90','0.6 - 91 a 105')THEN '03 - DE 76 A 105' 
--			WHEN FI.FAIXA_CORTE IN ('0.7 - 106 a 120','0.8 - 121 a 135','0.9 - 136 a 150','1.0 - 151 a 180',
--								    '1.1 - 181 a 210','1.2 - 211 a 240','1.3 - 241 a 270','1.4 - 271 a 300',
--								    '1.5 - 301 a 330','1.6 - 331 a 365') THEN '04 - DE 106 A 365' 
--			WHEN FI.FAIXA_CORTE IN ('1.7 - Até 2 Anos','1.7 - Maior 365',
--								    '1.8 - Até 3 Anos','1.9 - Até 4 Anos','2.0 - Até 5 Anos','2.1 - Acima de 5 Anos') THEN '05 - MAIOR 365' 
--			WHEN FI.FAIXA_CORTE = 'A FATURAR'  THEN 'A FATURAR'
--		 END AS NV_FX_ARRECADA
		
				
--		,CASE WHEN FI.ClassServ = 'LPLS' Then 'SIM' else 'NAO' END AS SPEEDY_PROVIDER
		
--		--,CASE 
--		--	WHEN FI.Billing IN ('AFO','TVAS') THEN LEFT(FI.TEL,2)
--		-- ELSE
--		--	LEFT(REPLICATE('0',14-LEN(RTRIM(FI.TEL))) + FI.TEL, 5)
--		--END AS LOCAL
		
--		--,CASE 
--		--	WHEN FI.Billing IN ('AFO','TVAS') THEN (CASE WHEN LEN(FI.TEL) = 10 THEN RIGHT(FI.TEL,8)ELSE SUBSTRING(FI.TEL,6,8) END)
--		--	ELSE SUBSTRING (REPLICATE('0',14-LEN(RTRIM(FI.TEL))) + FI.TEL, 6, 8) END AS TERMINAL
		
--		--,CASE 
--		--	WHEN FI.Billing IN ('AFO','TVAS') AND LEN(FI.TEL) = 14 THEN RIGHT(FI.Tel,1)
--		-- ELSE Right(REPLICATE('0',14-LEN(RTRIM(FI.TEL))) + FI.Tel,1) END AS DV
		
--		,CASE 
--			WHEN Billing = 'ATLYS'													Then 'DADOS_ATLYS'    
--			WHEN (Billing LIKE 'LEGADO%') AND 
--				 Right(REPLICATE('0',14-LEN(RTRIM(FI.TEL))) + FI.Tel,1) IN(2,9)		Then 'DADOS_CSO'
--			WHEN (Billing LIKE 'LEGADO%') AND 
--				Right(REPLICATE('0',14-LEN(RTRIM(FI.TEL))) + FI.Tel,1) NOT IN(2,9)	Then 'VOZ_CSO'
--		WHEN Billing Like'MICROSIGA%'												Then 'ATELECOM'  
--		WHEN Billing like 'SAP%'													Then 
--			(CASE	WHEN  ORIGEM IN('MANUAL','VENDA','VENDA FUTURA')				Then 'CAR_MANUAL' 
--					WHEN  ORIGEM IN('SAP - PDTI')									Then 'PDTI_SAP'   
--			 ELSE 'DADOS_SAP' END)  
--		WHEN Billing IN ('AFO','TVAS')												Then 'AFO' 
--		ELSE 'ERROR' END AS TIPO
		
--		--,GC.Lote AS NUMERO_LOTE
--		--,GC.Periodo AS DIA_VENCIMENTO
		
--		,CASE WHEN I.CONTA IS NULL THEN 'NAO' ELSE 'SIM' END AS INTRAGOV
--		,CASE WHEN FI.Tipo_Cliente IN ('INTERCOMPANY','SUBSIDIARIAS') THEN 'SIM' ELSE 'NAO' END AS INTERCOMPANY
		
--		,CONVERT(DECIMAL(18,2),REPLACE(REPLACE(ISNULL(FI.SALDO_CAR,0),'.',''),',','.'))			AS SALDO_CAR
--		,CONVERT(DECIMAL(18,2),REPLACE(REPLACE(ISNULL(FI.SALDO_PDD,0),'.',''),',','.'))			AS SALDO_PDD
--		,CONVERT(DECIMAL(18,2),REPLACE(REPLACE(ISNULL(FI.SALDO_FX_ENT,0),'.',''),',','.'))		AS SALDO_FX_ENT
--		,CONVERT(DECIMAL(18,2),REPLACE(REPLACE(ISNULL(FI.SALDO_TERCEIROS,0),'.',''),',','.'))	AS SALDO_TERCEIROS
--		,CONVERT(DECIMAL(18,2),REPLACE(REPLACE(ISNULL(FI.SALDO_WO,0),'.',''),',','.'))			AS SALDO_WO
--		,'OK'
--		,CASE WHEN LEN(FI.RAIZ_CPF_CNPJ) < 8 THEN 	REPLICATE('0',8 - LEN(FI.RAIZ_CPF_CNPJ)) + FI.RAIZ_CPF_CNPJ ELSE FI.RAIZ_CPF_CNPJ 
--		END AS RAIZ_CPF_CNPJ
--		--,CASE WHEN C.RAIZ_GRUPO IS NULL THEN  
--		--	(CASE WHEN LEN(FI.RAIZ_CPF_CNPJ) < 8 THEN REPLICATE('0',8 - LEN(FI.RAIZ_CPF_CNPJ)) + FI.RAIZ_CPF_CNPJ ELSE FI.RAIZ_CPF_CNPJ END)
--		--  ELSE C.RAIZ_GRUPO END AS RAIZ_GRUPO
		  
--		--,CASE WHEN C.NOME_GRUPO IS NULL THEN 
--		--	FI.CLIENTE 
--		--  ELSE C.NOME_GRUPO END AS NOME_GRUPO
		
--		--,CASE WHEN C.RAZAO_SOCIAL IS NULL THEN 
--		--	FI.CLIENTE 
--		--  ELSE C.RAZAO_SOCIAL END AS RAZAO_SOCIAL
		  		  
--		--,CASE WHEN 
--		--	LEN(FI.RAIZ_CPF_CNPJ) < 8 THEN REPLICATE('0',8 - LEN(FI.RAIZ_CPF_CNPJ)) + FI.RAIZ_CPF_CNPJ 
--		-- ELSE FI.RAIZ_CPF_CNPJ END AS RAIZ_CPF_CNPJ
		 
--		-- ,C.TASK_FORCE
	     
--	 --    ,C.GN	     
--	 --    ,C.GV	     
--	 --    ,C.DIRETOR
--		,CASE 
--			WHEN FI.BILLING LIKE('LEGADO%') OR FI.BILLING IN ('AFO','TVAS') THEN REPLICATE('0',11-LEN(FI.NRC)) + FI.NRC 
--		END AS NRC
--		--,S.MIGRAÇÃO AS N_DOC_DE_PARA_ATLYS
	
--	FROM 
--					[DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA_IMPORT] FI
--		--LEFT JOIN	[bck].[DB_BCK].[VW_LG].[GC] GC					ON FI.Tel = GC.terminal AND replace(FI.DtConta,'/','') = GC.Conta 
--		LEFT JOIN   [DB_SISCOB].[AUXILIAR].[TB_INTRAGOV_CONTAS] I 			ON FI.CONTA = I.CONTA
--		--LEFT JOIN	[DB_SISCOB].[AUXILIAR].[TB_ANALISTA_CARTEIRA_FIXA] C	ON CASE WHEN LEN(FI.RAIZ_CPF_CNPJ) < 8 THEN REPLICATE('0',8 - LEN(FI.RAIZ_CPF_CNPJ)) + FI.RAIZ_CPF_CNPJ ELSE FI.RAIZ_CPF_CNPJ END = C.RAIZ
--		--LEFT JOIN   [DB_SISCOB].[dbo].[SAP]	S								ON S.CONTA = FI.CONTA AND S.DT_PROCESS = FI.DT_PROCESS
--		--LEFT JOIN	[DB_SISCOB].[DBO].[DADOS$] C							ON CASE WHEN LEN(FI.RAIZ_CPF_CNPJ) < 8 THEN REPLICATE('0',8 - LEN(FI.RAIZ_CPF_CNPJ)) + FI.RAIZ_CPF_CNPJ ELSE FI.RAIZ_CPF_CNPJ END = C.RAIZ
		   										
--	WHERE 
	 
--			(FI.[SEG_DESCR] NOT LIKE 'VPG%' OR FI.[SEG_DESCR] IS NULL)
--    AND NOT (FI.[SEG_DESCR] = 'CORPORATIVO' OR FI.[SEG_DESCR] IS NULL)
--	AND (FI.[OPERACAO] NOT IN('LD15_FIXA','TDATA') OR FI.OPERACAO IS NULL);
--	--AND (FI.[OPERACAO] NOT IN('LD15_FIXA','TDATA') OR FI.OPERACAO IS NULL);
	
	

--	UPDATE M SET 
--				  M.RAIZ_GRUPO = ISNULL(C.RAIZ_GRUPO,M.RAIZ_CPF_CNPJ) 
--				 ,M.NOME_GRUPO = ISNULL(C.NOME_GRUPO,MI.CLIENTE)
--				 ,M.RAZAO_SOCIAL = ISNULL(C.RAZAO_SOCIAL,MI.CLIENTE)
--				-- ,M.TASK_FORCE = CASE WHEN C.TASK_FORCE = 1 THEN 'SIM' ELSE 'NAO' END
--				 ,M.TASK_FORCE =  ISNULL(C.TASK_FORCE,'NAO')
--				 ,M.GN = C.GN
--				 ,M.GV = C.GV
--				 ,M.DIRETOR = C.DIRETOR
			
--	FROM	
--					[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA] M
--		INNER JOIN  [DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA_IMPORT] MI ON M.ID_IMPORT_FIXA = MI.ID
--		--LEFT JOIN	[DB_SISCOB].[AUXILIAR].[TB_ANALISTA_CARTEIRA_MOVEL] C ON M.[RAIZ_CPF_CNPJ] = C.RAIZ;
--		LEFT JOIN	[DB_SISCOB].[DBO].[DADOS$] C ON M.[RAIZ_CPF_CNPJ] = C.RAIZ;

	
--	UPDATE TI SET TI.LOCAL = 
--							CASE 
--								WHEN FI.Billing IN ('AFO','TVAS') THEN LEFT(FI.TEL,2)
--							ELSE	
--								LEFT(REPLICATE('0',14-LEN(RTRIM(FI.TEL))) + FI.TEL, 5)
--							END
				 
--				 ,TI.TERMINAL  = 
--						CASE 
--							WHEN FI.Billing IN ('AFO','TVAS') THEN (CASE WHEN LEN(FI.TEL) = 10 THEN RIGHT(FI.TEL,8)ELSE SUBSTRING(FI.TEL,6,8) END)
--						ELSE 
--							SUBSTRING (REPLICATE('0',14-LEN(RTRIM(FI.TEL))) + FI.TEL, 6, 8) 
						
--						END 
--				,TI.DV = 
--						CASE 
--							WHEN FI.Billing IN ('AFO','TVAS') AND LEN(FI.TEL) = 14 THEN RIGHT(FI.Tel,1)
--						ELSE 
--							Right(REPLICATE('0',14-LEN(RTRIM(FI.TEL))) + FI.Tel,1) 
--						END
--	FROM
--					[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA] TI
--		INNER JOIN  [DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA_IMPORT] FI ON TI.ID_IMPORT_FIXA = FI.ID;
--	--------------------------------------------------------------------------------------------------------------------------------
--	-- Atualizar NV_FX_Fornece = Arrecada
--	--UPDATE TI set NV_FX_FORNECE = 
--	--	CASE 
--	--		WHEN FI.FAIXA_ATUAL IN ('0.1 - A vencer')														THEN '00 - A VENCER' 
--	--		WHEN FI.FAIXA_ATUAL IN ('0.2 - 1 a 30')															THEN '01 - DE 01 A 30' 
--	--		WHEN FI.FAIXA_ATUAL IN ('0.3 - 31 a 60','0.4 - 61 a 75')										THEN '02 - DE 31 A 75' 
--	--		WHEN FI.FAIXA_ATUAL IN ('0.5 - 76 a 90','0.6 - 91 a 105')										THEN '03 - DE 76 A 105' 
--	--		WHEN FI.FAIXA_ATUAL IN ('0.7 - 106 a 120','0.8 - 121 a 135','0.9 - 136 a 150','1.0 - 151 a 180',
--	--							    '1.1 - 181 a 210','1.2 - 211 a 240','1.3 - 241 a 270','1.4 - 271 a 300',
--	--							    '1.5 - 301 a 330','1.6 - 331 a 365')									THEN '04 - DE 106 A 365' 
--	--		WHEN FI.FAIXA_ATUAL IN ('1.7 - Até 2 Anos','1.7 - Maior 365',
--	--							  '1.8 - Até 3 Anos','1.9 - Até 4 Anos','2.0 - Até 5 Anos','2.1 - Acima de 5 Anos') THEN '05 - MAIOR 365' 
--	--		WHEN FI.FAIXA_ATUAL = 'A FATURAR'  THEN 'A FATURAR'
--	--	 END 
		
--	--FROM 
--	--				[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA] TI
--	--	INNER JOIN  [DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA_IMPORT] FI ON TI.ID_IMPORT_FIXA = FI.ID
	
	
	
	
--	-----------------------------------------------------------------------
--	-- Atualização do Campo Migração
--	UPDATE TI set N_DOC_DE_PARA_ATLYS = S.MIGRAÇÃO
		
--	FROM 
--					[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA] TI
--		INNER JOIN  [DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA_IMPORT] FI ON TI.ID_IMPORT_FIXA = FI.ID
--		INNER JOIN  [DB_SISCOB].[dbo].[SAP]	S								ON S.CONTA = FI.CONTA AND S.DT_PROCESS = FI.DT_PROCESS
		
	
	
--	--##########################################################################################################################
--	--ATUALIZAÇÃO CHAVE PROCV
--	--##########################################################################################################################
--	UPDATE TI set PROCV = 
--		--CASE WHEN TI.TIPO = 'DADOS_ATLYS' Then ISNULL(FI.CONTA,'') + ISNULL(FI.DT_PROCESS,'') + ISNULL(FI.RECEBIVEL,'') + CASE WHEN LEN(FI.RAIZ_CPF_CNPJ) < 8 THEN REPLICATE('0',8 - LEN(FI.RAIZ_CPF_CNPJ)) + FI.RAIZ_CPF_CNPJ ELSE FI.RAIZ_CPF_CNPJ END
--		CASE WHEN TI.TIPO = 'DADOS_ATLYS' Then ISNULL(FI.CONTA,'') + ISNULL(FI.DT_PROCESS,'') + ISNULL(FI.RECEBIVEL,'') + TI.RAIZ_CPF_CNPJ
--			 WHEN TI.TIPO = 'DADOS_CSO' Then ISNULL(FI.[Tel],'') + ISNULL(FI.[DtConta],'') + ISNULL(FI.[VENC_ORIGINAL],'') + ISNULL(CONVERT(VARCHAR(11),CONVERT(BIGINT,TI.[NRC])),'') + TI.RAIZ_CPF_CNPJ
--			 WHEN TI.TIPO = 'VOZ_CSO' Then ISNULL(FI.[Tel],'') + ISNULL(FI.[DtConta],'') + ISNULL(FI.[VENC_ORIGINAL],'') + ISNULL(CONVERT(VARCHAR(11),CONVERT(BIGINT,TI.[NRC])),'') + TI.RAIZ_CPF_CNPJ
--			 WHEN TI.TIPO = 'ATELECOM' Then ISNULL(FI.TITULO,'') + ISNULL(FI.DTCONTA ,'') + TI.RAIZ_CPF_CNPJ
--			 WHEN TI.TIPO = 'DADOS_SAP' Then ISNULL(FI.DOCUMENTO_SAP,'') + TI.RAIZ_CPF_CNPJ
--			 WHEN TI.TIPO = 'CAR_MANUAL' Then TI.RAIZ_CPF_CNPJ + ISNULL(FI.[NOTA_FISCAL],'') + ISNULL(FI.[DtConta],'') + ISNULL(REPLACE(FI.[SALDO_CAR],'.',''),'')
--			 WHEN TI.TIPO = 'AFO' Then ISNULL(FI.[Tel],'') + ISNULL(FI.[DtConta],'') + ISNULL(FI.[VENC_ORIGINAL],'') + ISNULL(CONVERT(VARCHAR(11),CONVERT(BIGINT,TI.[NRC])),'') + TI.RAIZ_CPF_CNPJ
--			 WHEN TI.TIPO = 'PDTI_SAP' Then ISNULL(FI.DOCUMENTO_SAP,'') + TI.RAIZ_CPF_CNPJ
--			 ELSE 'ERROR' 
--		END
		
--	FROM 
--					[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA] TI
--		INNER JOIN  [DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA_IMPORT] FI ON TI.ID_IMPORT_FIXA = FI.ID;
	
	
--	--UPDATE TI set NV_FX_ARRECADA = 
--	--	CASE 
--	--		WHEN FI.FAIXA_CORTE IN ('0.1 - A vencer') Then '00 - A VENCER' 
--	--		WHEN FI.FAIXA_CORTE IN ('0.2 - 1 a 30') THEN '01 - DE 01 A 30' 
--	--		WHEN FI.FAIXA_CORTE IN ('0.3 - 31 a 60','0.4 - 61 a 75') THEN '02 - DE 31 A 75' 
--	--		WHEN FI.FAIXA_CORTE IN ('0.5 - 76 a 90','0.6 - 91 a 105')THEN '03 - DE 76 A 105' 
--	--		WHEN FI.FAIXA_CORTE IN ('0.7 - 106 a 120','0.8 - 121 a 135','0.9 - 136 a 150','1.0 - 151 a 180',
--	--							    '1.1 - 181 a 210','1.2 - 211 a 240','1.3 - 241 a 270','1.4 - 271 a 300',
--	--							    '1.5 - 301 a 330','1.6 - 331 a 365') THEN '04 - DE 106 A 365' 
--	--		WHEN FI.FAIXA_CORTE IN ('1.7 - Até 2 Anos','1.7 - Maior 365',
--	--							  '1.8 - Até 3 Anos','1.9 - Até 4 Anos','2.0 - Até 5 Anos','2.1 - Acima de 5 Anos') THEN '05 - MAIOR 365' 
--	--		WHEN FI.FAIXA_CORTE = 'A FATURAR'  THEN 'A FATURAR'
--	--	 END 
		
--	--FROM 
--	--				[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA] TI
--	--	INNER JOIN  [DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA_IMPORT] FI ON TI.ID_IMPORT_FIXA = FI.ID;




----##########################################################################################################################
----ATUALIZAÇÃO CAMPO SITUACAO_SERVICO
----##########################################################################################################################
--	UPDATE TI set [SITUACAO_SERVICO] = 
		
--		CASE WHEN TI.TIPO = 'AFO'			THEN 
--				CASE WHEN FI.PROVISAO = 'CCF_S' THEN 'CANCELADO' ELSE 'ATIVO' END
--			 WHEN TI.TIPO = 'ATELECOM'		THEN 	
--				CASE WHEN FI.PROVISAO = 'CCF_S' THEN 'CANCELADO' ELSE 'ATIVO' END
--			 WHEN TI.TIPO = 'DADOS_ATLYS'	THEN
--				CASE WHEN FI.[STATUS] = 'A' THEN 'ATIVO'
--					 WHEN FI.[STATUS] = 'F' THEN 'CANCELADO'
--					 WHEN FI.[STATUS] = 'N' THEN 'SUSPENSO (FASE DE RÉGUA)' END
--			 WHEN TI.TIPO = 'DADOS_CSO'	OR 	TI.TIPO = 'VOZ_CSO' THEN
--				CASE WHEN FI.PROVISAO = 'ALTO_RISCO'	THEN 'ATIVO' 
--					 WHEN FI.PROVISAO = 'CCF_S'			THEN 'CANCELADO'
--					 WHEN FI.PROVISAO = 'CCFN'			THEN 'FILTRO JURIDICO'
--					 WHEN FI.PROVISAO = 'NAO'			THEN 'ATIVO' END
--			 WHEN TI.TIPO = 'DADOS_SAP'	OR TI.TIPO = 'PDTI_SAP'	OR TI.TIPO = 'CAR_MANUAL' THEN 'SEM INFORMACAO'
			 
--		END
		
--	FROM 
--					[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA] TI
--		INNER JOIN  [DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA_IMPORT] FI ON TI.ID_IMPORT_FIXA = FI.ID;



----###########################################################################################################################################################
----	ATUALIZAÇÃO LOTE E DIA VENCIMENTO
----	ATUALIZAÇÃO CAMPO LOTE
----###########################################################################################################################################################
--UPDATE T SET
--	 T.NUMERO_LOTE		= GC.Lote
--	,T.DIA_VENCIMENTO	= GC.Periodo

--FROM
--				[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA] T
--	INNER JOIN  [DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA_IMPORT] FI	ON T.ID_IMPORT_FIXA = FI.ID
--	INNER JOIN  [bck].[DB_BCK].[VW_LG].[GC] GC					ON FI.TEL = GC.terminal AND replace(FI.DtConta,'/','') = GC.Conta AND CONVERT(DATE,FI.VENC_ATUAL,103) = CONVERT(DATE,GC.VENCIMENTO)
---------------------------------------------------------------------------------------------------------------------------------
--UPDATE F SET
--		F.VALOR_LOTE = LOTE.valor
--FROM 
--			[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA] F
--INNER JOIN  [DB_SISCOB].[FILE_CAR].[TB_CAR_FIXA_IMPORT] FI ON F.ID_IMPORT_FIXA = FI.ID
--INNER JOIN
--			(
--			 SELECT 
--					 GC.periodo
--					,GC.conta
--					,GC.lote
--					,sum(GC.valor) as valor
--			FROM 
--					[bck].[DB_BCK].[VW_LG].[GC] GC
--			group by
--					 GC.periodo
--					,GC.conta
--					,GC.lote
				
--		) AS Lote ON					F.DIA_VENCIMENTO				= lote.Periodo
--										AND replace(FI.DtConta,'/','')	= lote.conta
--										AND F.NUMERO_LOTE				= LOTE.lote


----#############################################################################################
----AGRUPAMENTO DAS CHAVES DUPLICADAS
----#############################################################################################
--UPDATE F SET [OK] = 'NOK'
--FROM 
	
--				[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA] F 
--	INNER JOIN
--			(
--				SELECT 
--					 TMP.PROCV 
--					,TMP.TIPO
--				FROM
--					(
--					 SELECT 
--						 F.PROCV 
--						,F.TIPO
--						,COUNT(1) AS CONTAR 
--					 FROM
--						[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA] F
--					 GROUP BY
--						 F.PROCV 
--						,F.TIPO
--					) AS TMP
--				WHERE TMP.CONTAR > 1
		
--			) AS CHAVES ON F.PROCV = CHAVES.PROCV AND F.TIPO = CHAVES.TIPO;



--INSERT INTO [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA]
--(
--	 [ID_IMPORT_FIXA]
--	,[NV_FX_FECHO]  
--	,[NV_FX_ARRECADA]    
--	,[SPEEDY_PROVIDER]  
--	,[LOCAL]  
--	,[TERMINAL]  
--	,[DV]  
--	,[TIPO]  
--	,[PROCV]  
--	,[NUMERO_LOTE]  
--	,[DIA_VENCIMENTO]  
--	,[VALOR_LOTE]   
--	,[INTRAGOV]  
--	,[INTERCOMPANY]  
--	,[QTD_REG_AGRUPADO]  
--	,[SALDO_CAR]   
--	,[SALDO_PDD]   
--	,[SALDO_FX_ENT]   
--	,[SALDO_TERCEIROS]   
--	,[SALDO_WO]   
--	,[OK]
--	,RAIZ_GRUPO
--	,NOME_GRUPO
--	,RAZAO_SOCIAL
--	,RAIZ_CPF_CNPJ
--	,TASK_FORCE
--	,GN
--	,GV
--	,DIRETOR 
--	,NRC 
--	,N_DOC_DE_PARA_ATLYS
--)

--	SELECT
--		 SOMA_E.ID
--		,SOMA_E.[NV_FX_FECHO]  
--		,SOMA_E.[NV_FX_ARRECADA]    
--		--,F.[NV_FX_FECHO]  
--		--,F.[NV_FX_ARRECADA]    
--		,F.[SPEEDY_PROVIDER]  
--		,F.[LOCAL]  
--		,F.[TERMINAL]  
--		,F.[DV]  
--		,F.[TIPO]  
--		,F.[PROCV]  
--		,F.[NUMERO_LOTE]  
--		,F.[DIA_VENCIMENTO]  
--		,F.[VALOR_LOTE]   
--		,F.[INTRAGOV]  
--		,F.[INTERCOMPANY]  
--		,SOMA_E.CONTAR  
--		,SOMA_E.[SALDO_CAR]
--		,SOMA_E.[SALDO_PDD]
--		,SOMA_E.[SALDO_FX_ENT]
--		,SOMA_E.[SALDO_TERCEIROS]
--		,SOMA_E.[SALDO_WO]
--		,'OK'
--		,RAIZ_GRUPO
--		,NOME_GRUPO
--		,RAZAO_SOCIAL
--		,RAIZ_CPF_CNPJ
--		,TASK_FORCE
--		,GN
--		,GV
--		,DIRETOR
--		,NRC
--		,N_DOC_DE_PARA_ATLYS

--		FROM 
--					[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA] F
--		INNER JOIN
--					(
--						SELECT
--						  		 FE.PROCV
--								,FE.TIPO
--								,MAX(FE.[NV_FX_FECHO]) AS [NV_FX_FECHO]  
--								,MAX(FE.[NV_FX_ARRECADA]) AS [NV_FX_ARRECADA]      
--								,COUNT(1) AS CONTAR
--								,MAX(FE.ID_IMPORT_FIXA) AS ID
--								,SUM(ISNULL(FE.[SALDO_CAR],0))			AS SALDO_CAR
--								,SUM(ISNULL(FE.[SALDO_PDD],0))			AS SALDO_PDD
--								,SUM(ISNULL(FE.[SALDO_FX_ENT],0))		AS SALDO_FX_ENT
--								,SUM(ISNULL(FE.[SALDO_TERCEIROS],0))	AS SALDO_TERCEIROS
--								,SUM(ISNULL(FE.[SALDO_WO],0))			AS SALDO_WO
--						FROM 
--							[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA] FE
--						WHERE 
--							FE.ok = 'NOK'
--						GROUP BY
--							FE.PROCV
--							,FE.TIPO
	
--					) SOMA_E ON SOMA_E.ID = F.ID_IMPORT_FIXA AND SOMA_E.TIPO = F.TIPO;
					

----#############################################################################################
---- PREENCHIMENTO DE QUADRO DE VALIDACAO
----#############################################################################################

--TRUNCATE TABLE [DB_SISCOB].[FILE_CAR].[QUADRO_VALIDACAO_CAR]; --LIMPAR TABELA ANTES DO INICIO DO PROCESSO
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
--		 F.TIPO									AS TIPO
--		,SUM(F.[SALDO_CAR])						AS SALDO_CAR
--		,SUM(F.[SALDO_PDD])						AS SALDO_PDD
--		,SUM(F.[SALDO_FX_ENT])					AS SALDO_FX_ENT
--		,SUM(F.[SALDO_TERCEIROS])				AS SALDO_TERCEIROS
--		,SUM(F.[SALDO_WO])						AS SALDO_WO
--		,COUNT(1)								AS QTD_REGISTROS
--		,SUM(ISNULL(F.[QTD_REG_AGRUPADO],0))	AS QTD_REG_AGRUPADO 
--		,'FIXA'									AS SEGMENTO
		
--		FROM
--			[DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA] F
--		WHERE ok = 'ok'
--GROUP BY 
--		 F.TIPO
--ORDER BY 
--		 F.TIPO;
END


--SELECT * FROM [DB_SISCOB].[FILE_CAR].[QUADRO_VALIDACAO_CAR]
