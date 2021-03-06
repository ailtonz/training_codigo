USE [DB_SISCOB]
GO

DECLARE	@return_value int,
		@ID_FILE int,
		@qry varchar(max)

SELECT	@ID_FILE = 0
--set @qry = (SELECT TOP 1 [ID] AS 'ID' FROM [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_CENARIOS] ORDER BY [ID] DESC);
set @qry = (SELECT TOP 1 [QUERY_RESUMO] FROM [DB_SISCOB].[APP_WEB].[TBL_ARQUIVOS_TRANSITO_CENARIOS] ORDER BY [ID] DESC);

declare @tmp varchar(max); set @tmp = '' + @qry + '';

EXEC	@return_value = [APP_WEB].[PRC_CENARIO]
		@QUERY_WHERE = @tmp,
		@ANALISTA = N'15',
		@RAIZ_GRUPO = N'4007349767',
		@ID_FILE = @ID_FILE OUTPUT

SELECT	@ID_FILE as N'@ID_FILE'

SELECT	'Return Value' = @return_value

GO
