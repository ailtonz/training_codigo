DECLARE @Cmd VARCHAR(500);

--SET LANGUAGE PORTUGUESE;
-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################
-- [1] -> COPIAR ARQUIVO MODELO 
-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################

-- #########################
-- SELEÇÃO DO ARQUIVO
-- #########################
	DECLARE @FILE_PATH				VARCHAR(1000); SET @FILE_PATH				= (SELECT TOP 1 [DESCRICAO] AS 'FILE_PATH' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'CONTA_BONUS' ORDER BY [ID] DESC);
	DECLARE @FILE_PATH_DESTINATION	VARCHAR(1000); SET @FILE_PATH_DESTINATION	= (SELECT TOP 1 [DESCRICAO] AS 'FILE_PATH_DESTINATION' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'CONTA_BONUS_DESTINO'  ORDER BY [ID] DESC);

	DECLARE @FILE_NAME				VARCHAR(1000); SET @FILE_NAME				= (SELECT TOP 1 [DESCRICAO_02] AS 'FILE_NAME' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'CONTA_BONUS' ORDER BY [ID] DESC);

	DECLARE @CONTROLER				VARCHAR(1000); SET @CONTROLER				= (SELECT CONCAT(YEAR(GETDATE()), MONTH(GETDATE()), DAY(GETDATE())))+'_'+(SELECT CONCAT(DATEPART(HOUR,GETDATE()),'',DATEPART(MINUTE,GETDATE()))) + '_';

-- ##################################
-- COPIA DE ARQUIVO MODELO
-- ##################################
	SET @Cmd = 'COPY ' + @FILE_PATH + @FILE_NAME + ' ' + @FILE_PATH_DESTINATION + @CONTROLER + @FILE_NAME ;
	--PRINT @Cmd  
	EXEC xp_cmdshell @Cmd --,no_output	

	SET @Cmd = 'DEL ' + @FILE_PATH + @FILE_NAME 
	--PRINT @Cmd  
	EXEC xp_cmdshell @Cmd --,no_output	


	SELECT CONCAT(YEAR(GETDATE()), MONTH(GETDATE()), DAY(GETDATE()));  

	SELECT CONCAT(DATEPART(HOUR,GETDATE()),'',DATEPART(MINUTE,GETDATE())) 'Minute Part'


	SELECT DATEPART(HOUR,GETDATE())