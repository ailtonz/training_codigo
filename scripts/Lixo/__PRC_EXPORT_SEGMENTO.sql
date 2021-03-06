USE [DB_SISCOB]
GO
/****** Object:  StoredProcedure [APP_WEB].[PRC_EXPORT_SEGMENTO]    Script Date: 3/16/2017 6:06:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [APP_WEB].[PRC_EXPORT_SEGMENTO] 
	@ANALISTA NVARCHAR(100)  
	,@SEGMENTO NVARCHAR(100)
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
	DECLARE @FILE_DOWNLOAD			VARCHAR(1000); SET @FILE_DOWNLOAD		= (SELECT TOP 1 [DESCRICAO]					AS 'FILE_DOWNLOAD' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE]			WHERE [TIPO] = 'EXPORT_SEGMENTO_DOWNLOAD');
	DECLARE @FILE_APP				VARCHAR(1000); SET @FILE_APP			= (SELECT TOP 1 [DESCRICAO]+[DESCRICAO_02]	AS 'FILE_APP' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE]				WHERE [TIPO] = 'EXPORT_SEGMENTO_APP');
	DECLARE @FILE_DOWNLOAD_TMP		VARCHAR(100);  SET @FILE_DOWNLOAD_TMP	= LEFT(@FILE_DOWNLOAD,LEN(@FILE_DOWNLOAD)-1) +'\'
	DECLARE @FILE_EXIT_TMP			VARCHAR(1000); 
	DECLARE @RETURN_ID_FILE			VARCHAR(1000); 
	
	
-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################
-- [1] -> CADASTRA SOLICITACAO DE ARQUIVO E SCRIPTS
-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################

  INSERT INTO [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_SEGMENTO]
           ([nm_arquivo]
           ,[diretorio]
		   ,ID_ANALISTA
		   ,DATA_SOLICITACAO
		   ,[QUERY_RESUMO]
           )
     VALUES
           (@ANALISTA+@SEGMENTO+'.xml'
           ,@FILE_DOWNLOAD
		   ,convert(int,@ANALISTA)
		   ,GETDATE()
		   ,@FILTRO
           ) 
		   
-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################
-- [2] -> EXTRAÇÃO DE DADOS
-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################

	--SET @Cmd = @FILE_APP + ' ' + @ANALISTA;
	--EXEC xp_cmdshell @Cmd, NO_OUTPUT


	--DECLARE @APP_COMPACT	VARCHAR(500);	SET @APP_COMPACT		= (SELECT TOP 1 [DESCRICAO] AS 'APP_COMPACT' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'APP_COMPACT' ORDER BY [ID] DESC);
	--DECLARE @FILE_COMPACT	VARCHAR(100);	SET @FILE_COMPACT		= LEFT(@ANALISTA+@SEGMENTO+'.xml',LEN(@ANALISTA+@SEGMENTO+'.xml')-4)+ '.7z';
	
	--DECLARE @x	VARCHAR(500);	set @x = '\\172.16.0.11\htdocs\siscob_hml\Segmento\'

	----SET @Cmd = @APP_COMPACT + ' A ' + @FILE_DOWNLOAD + @FILE_COMPACT + ' ' + @FILE_DOWNLOAD_TMP + @ANALISTA + @SEGMENTO + '.xml' ;
	--SET @Cmd = @APP_COMPACT + ' A ' + @x + @FILE_COMPACT + ' ' + @FILE_DOWNLOAD_TMP + @ANALISTA + @SEGMENTO + '.xml' ;
	--EXEC xp_cmdshell @Cmd,no_output	




DECLARE @SUBJECT VARCHAR(1000); SET @SUBJECT	= (SELECT TOP 1 [DESCRICAO]		AS '_SUBJECT_' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE]	WHERE [TIPO] = 'EXPORT_SEGMENTO_EMAIL'  ORDER BY ID DESC);
DECLARE @EMAIL VARCHAR(1000);	SET @EMAIL		= (SELECT TOP 1 [DESCRICAO_02]	AS '_EMAIL_' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE]	WHERE [TIPO] = 'EXPORT_SEGMENTO_EMAIL'  ORDER BY ID DESC);
DECLARE @BODY VARCHAR(1000);	SET @BODY		= (SELECT TOP 1 [DESCRICAO_03]	AS '_BODY_' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE]	WHERE [TIPO] = 'EXPORT_SEGMENTO_EMAIL'  ORDER BY ID DESC);
DECLARE @LINK VARCHAR(1000);	SET @LINK		= 'file://tlf-prd-wap03.cloudapp.net:8081/siscob_hml/Segmento/1VPE.7z';

SET @BODY = REPLACE(@BODY,'_LINK_',@LINK)
SET @BODY = REPLACE(@BODY,'_FILTRO_SEGMENTO_','SEGMENTO')

PRINT @BODY

EXEC msdb.dbo.sp_send_dbmail
	@profile_name = 'ENVIO_COBRANCA',
	@recipients = @EMAIL,
	--@copy_recipients = @COPY,
	@subject = @SUBJECT,
	@Body = @BODY,
	--@file_attachments = @ANEXO,
	@body_format = 'HTML';	



		
END


