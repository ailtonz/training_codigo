USE [DB_SISCOB]
GO
/****** Object:  StoredProcedure [APP_WEB].[PRC_ACORDO_COM_FILTROS]    Script Date: 1/19/2017 6:59:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [APP_WEB].[PRC_ACORDO_COM_FILTROS] 
	--@QUERY_WHERE NVARCHAR(MAX)  
	@ANALISTA NVARCHAR(100)  
	,@RAIZ_GRUPO NVARCHAR(100)
	,@FILTRO NVARCHAR(MAX)
	
AS
BEGIN


SET LANGUAGE PORTUGUESE;

SET NOCOUNT ON

DECLARE @Cmd VARCHAR(500);
DECLARE @SQL NVARCHAR(MAX);	
DECLARE @QUERY NVARCHAR(MAX);
DECLARE @QUERY_WHERE_TMP NVARCHAR(MAX);


-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################
-- [1] -> CARREGAR VARIAVEIS 
-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################

-- #########################
-- SELEÇÃO DO ARQUIVO
-- #########################
	DECLARE @FILE_MODEL_PATH		VARCHAR(1000); SET @FILE_MODEL_PATH		= (SELECT TOP 1 [DESCRICAO] AS 'FILE_MODEL_PATH' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'ACORDO_FILE_MODEL_PATH');
	DECLARE @FILE_MODEL				VARCHAR(1000); SET @FILE_MODEL			= (SELECT TOP 1 [DESCRICAO] AS 'FILE_MODEL' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'ACORDO_FILE_MODEL');
	DECLARE @FILE_EXIT				VARCHAR(1000); SET @FILE_EXIT			= (SELECT TOP 1 [DESCRICAO_02] AS 'FILE_EXIT' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'ACORDO_FILE_MODEL');
	DECLARE @FILE_DOWNLOAD			VARCHAR(1000); SET @FILE_DOWNLOAD		= (SELECT TOP 1 [DESCRICAO] AS 'FILE_DOWNLOAD' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'ACORDO_DOWNLOAD');
	DECLARE @FILE_DOWNLOAD_TMP		VARCHAR(100);  SET @FILE_DOWNLOAD_TMP	= LEFT(@FILE_DOWNLOAD,LEN(@FILE_DOWNLOAD)-1) +'\'
	

	DECLARE @FILE_EXIT_TMP			VARCHAR(1000); 
	DECLARE @RETURN_ID_FILE			VARCHAR(1000); --SET @RETURN_ID_FILE		= (SELECT TOP 1 [ID] AS 'ID' FROM [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_CENARIOS] WHERE [nm_arquivo] = @FILE_EXIT_TMP ORDER BY [ID] DESC);
	
-- ##################################
-- AJUSTES DE DADOS 
-- ##################################
	
	---------------------------------------
	----- FORMATACAO - CAMPO "RAIZ_GRUPO"
	---------------------------------------
	if len(@RAIZ_GRUPO) < 8 
	begin
		SET @RAIZ_GRUPO		= replicate('0',8-len(@RAIZ_GRUPO)) + @RAIZ_GRUPO
	end	

	---------------------------------------
	----- FORMATACAO - NOME DO ARQUIVO
	---------------------------------------	
	SET @FILE_EXIT_TMP		= @RAIZ_GRUPO + '.xml';

-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################
-- [2] -> MONTAR SCRIPT DE EXPORTACAO
-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################

-- #########################
-- SCRIPT
-- #########################
--DECLARE @SQL NVARCHAR(MAX);
--DECLARE @QUERY NVARCHAR(MAX);
--DECLARE 	@ANALISTA NVARCHAR(100);  
--DECLARE 		@RAIZ_GRUPO NVARCHAR(100);
--	DECLARE 	@FILTRO NVARCHAR(MAX);

--	SET 	@ANALISTA = '23' ;  
--SET 		@RAIZ_GRUPO = '60872173';
--	SET 	@FILTRO  = NULL;


	SET @QUERY = 'SELECT PROCV 
		,ID
		,CONVERT(VARCHAR(255), NOME_ANALISTA) as NOME_ANALISTA 
		,CONVERT(VARCHAR(255), NOME_ANALISTA_TMP) as NOME_ANALISTA_TMP 
		,FEEDBACK
		,AREA_OFENSORA
		,TIPO_PAGTO
		,DT_PAGTO
		,REPLACE(CONVERT(VARCHAR(20), VALOR_PAGTO), ''.'', '','') as VALOR_PAGTO
		,DT_AJUSTE
		,REPLACE(CONVERT(VARCHAR(20), VALOR_AJUSTADO), ''.'', '','') as VALOR_AJUSTADO
		,RESUMO_EXECUTIVO_ACAO as RESUMO_EXECUTIVO_ACAO
		,RESUMO_EXECUTIVO_ACAO as RESUMO_EXECUTIVO_PROBLEMA
		,HISTORICO_DETALHADO as HISTORICO_DETALHADO
		,DT_FOLLOW_UP
		,DT_ENCERRAMENTO
		,DT_CONTATO
		,CONVERT(VARCHAR(255), RESPONSAVEL) as RESPONSAVEL
		,FAIXA_FORNECEDOR
		,FAIXA_FECHO
		,FAIXA_ARRECADA_INICIAL
		,FAIXA_ARRECADA_ATUAL
		,RAIZ_GRUPO
		,GRUPO
		,RAIZ
		,CNPJ
		,NOME
		,NOME_CLIENTE
		,TIPO
		,EMPRESA
		,CONTA
		,TEL
		,LOCAL
		,TERMINAL
		,DV
		,NRC
		,CLASSERV
		,TITULO
		,FILIAL
		,LJ_CLI
		,COD_CLI
		,DOCUMENTO_SAP
		,DOC_FAT
		,N_DOC_DE_PARA_ATLYS
		,NOTA_FISCAL
		,VENC_ATUAL
		,VENC_ORIGINAL
		,DT_PROCESS
		,ANOMES
		,DIA_VENCIMENTO_LOTE
		,NUMERO_LOTE
		,VALOR_LOTE
		,SALDO_CAR_26
		,SALDO_CAR_30
		,SALDO_CAR_05
		,SALDO_CAR_14
		,SALDO_CAR_21
		,SALDO_CAR_25
		,SALDO_TOTAL
		,REPLACE(CONVERT(VARCHAR(20), SOMA_FXE_PDD_26), ''.'', '','') as SOMA_FXE_PDD_26
		,REPLACE(CONVERT(VARCHAR(20), SOMA_FXE_PDD_30), ''.'', '','') as SOMA_FXE_PDD_30
		,REPLACE(CONVERT(VARCHAR(20), SOMA_FXE_PDD_05), ''.'', '','') as SOMA_FXE_PDD_05
		,REPLACE(CONVERT(VARCHAR(20), SOMA_FXE_PDD_14), ''.'', '','') as SOMA_FXE_PDD_14
		,REPLACE(CONVERT(VARCHAR(20), SOMA_FXE_PDD_21), ''.'', '','') as SOMA_FXE_PDD_21
		,REPLACE(CONVERT(VARCHAR(20), SOMA_FXE_PDD_25), ''.'', '','') as SOMA_FXE_PDD_25
		,REPLACE(CONVERT(VARCHAR(20), VALOR_PAGAMENTO), ''.'', '','') as VALOR_PAGAMENTO
		,REPLACE(CONVERT(VARCHAR(20), VALOR_AJUSTE), ''.'', '','') as VALOR_AJUSTE
		,REPLACE(CONVERT(VARCHAR(20), SALDO_ATUAL), ''.'', '','') as SALDO_ATUAL
		,CICLO
		,UF
		,STATUS
		,CLASSE
		,SEGMENTO_GERENCIA
		,GN
		,GV
		,DIRETOR
		,ANALISTA_TLF_VIVO
		,INTRAGOV
		,INTERCOMPANY
		,FEEDBACK_00
		,FEEDBACK_01
		,FEEDBACK_02
		,FEEDBACK_03
		,FEEDBACK_04
		,FEEDBACK_05
		,PENDENTE_ID_ANALISE_CONTA
		,PENDENTE_DATA_ANALISE_CONTA
		,CONCLUIDO_ID_ANALISE_CONTA
		,CONCLUIDO_DATA_ANALISE_CONTA
		,REABERTO_ID_ANALISE_CONTA
		,REABERTO_DATA_ANALISE_CONTA
		,QTD_REG_AGRUPADO
		,DT_ULT_ALTERACAO
		,CONVERT(VARCHAR(255), USUARIO_ATUALIZACAO) as USUARIO_ATUALIZACAO
		,ID_ANALISTA
		,ID_ANALISTA_TMP
		,AREA_ATUACAO
		,TASK_FORCE
		,SEG_DESCR
		,PARCELAMENTO
		,ESCALATION
		,CONTA_BONUS
		,OBS
		,PENDENTE_ID_ANALISE_CONTA

	FROM [APP_EXCEL].[VW_CONSUMO_CONSOLIDADO_ACORDO_COM_FILTROS]  

	WHERE RAIZ_GRUPO = ''' + @RAIZ_GRUPO  + ''' AND (ID_ANALISTA = ' + @ANALISTA + ' OR ID_ANALISTA_TMP = ' + @ANALISTA + ') ' + @FILTRO

	--PRINT @SQL
	

-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################
-- [4] -> CADASTRA SOLICITACAO DE ARQUIVO E SCRIPTS
-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################

  INSERT INTO [APP_WEB].[TBL_ARQUIVOS_TRANSITO_ACORDOS]
           ([nm_arquivo]
           ,[diretorio]
		   ,ID_ANALISTA
		   ,DATA_SOLICITACAO
		   ,[QUERY_RESUMO]
           )
     VALUES
           (@FILE_EXIT_TMP
           ,@FILE_DOWNLOAD
		   ,convert(int,@ANALISTA)
		   ,GETDATE()
		   ,@QUERY
           )

	declare @appName varchar(300)/
	set @appName = '\\172.16.0.6\e\sftp_files\FTP_User\SISCOB\pacotes\exportAcordo.exe '

	exec @appName @ANALISTA
	
	--SET @RETURN_ID_FILE		= (SELECT TOP 1 [ID] AS 'ID' FROM [APP_WEB].[TBL_ARQUIVOS_TRANSITO_CENARIOS] WHERE [nm_arquivo] = @FILE_EXIT_TMP ORDER BY [ID] DESC);
	--SET @ID_FILE = @RETURN_ID_FILE

END


