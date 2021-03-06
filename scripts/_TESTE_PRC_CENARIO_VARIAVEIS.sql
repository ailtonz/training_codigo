DECLARE @ANALISTA				VARCHAR(1000); SET @ANALISTA			= 'AILTON'

DECLARE @FILE_MODEL_PATH		VARCHAR(1000); SET @FILE_MODEL_PATH		= (SELECT TOP 1 [DESCRICAO] AS 'FILE_MODEL_PATH' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'CENARIO_FILE_MODEL_PATH');
DECLARE @FILE_MODEL				VARCHAR(1000); SET @FILE_MODEL			= (SELECT TOP 1 [DESCRICAO] AS 'FILE_MODEL' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'CENARIO_FILE_MODEL');
DECLARE @FILE_EXIT				VARCHAR(1000); SET @FILE_EXIT			= (SELECT TOP 1 [DESCRICAO_02] AS 'FILE_EXIT' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'CENARIO_FILE_MODEL');
DECLARE @FILE_DOWNLOAD			VARCHAR(1000); SET @FILE_DOWNLOAD		= (SELECT TOP 1 [DESCRICAO] AS 'FILE_DOWNLOAD' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'CENARIO_DOWNLOAD');

DECLARE @FILE_EXIT_TMP			VARCHAR(1000); SET @FILE_EXIT_TMP		= @ANALISTA + '_' + @FILE_EXIT;
DECLARE @RETURN_ID_FILE			VARCHAR(1000); SET @RETURN_ID_FILE		= (SELECT TOP 1 [ID] AS 'ID' FROM [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_CENARIOS] WHERE [nm_arquivo] = @FILE_EXIT_TMP ORDER BY [ID] DESC);

SET @RETURN_ID_FILE		= (SELECT TOP 1 [ID] AS 'ID' FROM [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_CENARIOS] WHERE [nm_arquivo] = @FILE_EXIT_TMP ORDER BY [ID] DESC);
PRINT '@RETURN_ID_FILE ---> ' + @RETURN_ID_FILE


PRINT '@FILE_MODEL_PATH ---> ' + @FILE_MODEL_PATH
PRINT '@FILE_MODEL ---> ' +@FILE_MODEL
PRINT '@FILE_EXIT ---> ' +@FILE_EXIT
PRINT '@FILE_DOWNLOAD ---> ' +@FILE_DOWNLOAD

PRINT 'COPY ' + @FILE_MODEL_PATH + @FILE_MODEL + ' ' + @FILE_DOWNLOAD + @ANALISTA+'_'+@FILE_EXIT

PRINT '@RETURN_ID_FILE ---> ' + @RETURN_ID_FILE



--INSERT INTO [APP_WEB].[TBL_ARQUIVOS_TRANSITO_CENARIOS]
--         ([nm_arquivo]
--         ,[diretorio]
--         )
--   VALUES
--         ('AILTON' + '_' + 'NOME_ARQUIVO_TMP.TXT'
--         ,'\\172.16.0.11\siscob\CENARIO/'
--         )


-- SET @FILE_EXIT_TMP		= 'AILTON' + '_' + 'NOME_ARQUIVO_TMP.TXT';