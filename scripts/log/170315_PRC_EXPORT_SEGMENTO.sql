USE [DB_SISCOB]
GO

DECLARE	@return_value int

EXEC	@return_value = [APP_WEB].[PRC_EXPORT_SEGMENTO]
		@ANALISTA = N'1',
		@SEGMENTO = N'VPE',
		--@FILTRO = N''
		@FILTRO = N'WHERE [SEG_DESCR] = ''VPE'''

SELECT	'Return Value' = @return_value

GO
