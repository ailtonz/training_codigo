USE [DB_SISCOB]
GO

DECLARE	@return_value int

EXEC	@return_value = [APP_WEB].[PRC_CENARIO]
		@QUERY_WHERE = N'''''',
		@ANALISTA = N'''''',
		@RAIZ_GRUPO = N'4033592510',
		@GERAR_EMAIL = N''

SELECT	'Return Value' = @return_value

GO
