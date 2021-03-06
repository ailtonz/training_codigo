USE [DB_SISCOB]
GO
/****** Object:  StoredProcedure [APP_WEB].[PRC_ACORDO_COM_FILTROS]    Script Date: 4/12/2017 5:33:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [APP_WEB].[PRC_ACORDOS] 
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
declare @FileApp nvarchar(1000);

-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################
-- [1] -> CARREGAR VARIAVEIS 
-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################

-- #########################
-- SELEÇÃO DO ARQUIVO
-- #########################
	DECLARE @FILE_QUERY				VARCHAR(MAX); SET @FILE_QUERY			= (SELECT TOP 1 [DESCRICAO_03]	AS 'QUERY'				FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'CENARIO_QUERY' order by id desc);
	DECLARE @FILE_MODEL_PATH		VARCHAR(1000); SET @FILE_MODEL_PATH		= (SELECT TOP 1 [DESCRICAO] AS 'FILE_MODEL_PATH' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'ACORDO_FILE_MODEL_PATH');
	DECLARE @FILE_MODEL				VARCHAR(1000); SET @FILE_MODEL			= (SELECT TOP 1 [DESCRICAO] AS 'FILE_MODEL' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'ACORDO_FILE_MODEL');
	DECLARE @FILE_EXIT				VARCHAR(1000); SET @FILE_EXIT			= (SELECT TOP 1 [DESCRICAO_02] AS 'FILE_EXIT' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'ACORDO_FILE_MODEL');
	DECLARE @FILE_DOWNLOAD			VARCHAR(1000); SET @FILE_DOWNLOAD		= (SELECT TOP 1 [DESCRICAO] AS 'FILE_DOWNLOAD' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'ACORDO_APP');
	DECLARE @FILE_APP				VARCHAR(1000); SET @FILE_APP			= (SELECT TOP 1 [DESCRICAO]+[DESCRICAO_02] AS 'FILE_APP' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'ACORDO_APP');
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
	
	SET @FILE_QUERY = REPLACE(@FILE_QUERY,'@p_RAIZ_GRUPO',@RAIZ_GRUPO);
	SET @QUERY = @QUERY + replace(@FILE_QUERY,'''''','''');
	
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


-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################
-- [5] -> EXTRAÇÃO DE DADOS
-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################

	SET @Cmd = @FILE_APP + ' ' + @ANALISTA;
	--PRINT @Cmd
	EXEC xp_cmdshell @Cmd, NO_OUTPUT


	
	--SET @RETURN_ID_FILE		= (SELECT TOP 1 [ID] AS 'ID' FROM [APP_WEB].[TBL_ARQUIVOS_TRANSITO_CENARIOS] WHERE [nm_arquivo] = @FILE_EXIT_TMP ORDER BY [ID] DESC);
	--SET @ID_FILE = @RETURN_ID_FILE

END



