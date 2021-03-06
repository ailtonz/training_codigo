USE [DB_SISCOB]
GO
/****** Object:  StoredProcedure [FILE_CAR].[PRC_005_GERAR_ARQUIVO_PRE_VALIDACAO]    Script Date: 1/31/2017 6:28:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [FILE_CAR].[PRC_005_GERAR_ARQUIVO_PRE_VALIDACAO]
AS
BEGIN

SET NOCOUNT ON


DECLARE @Cmd VARCHAR(500);
DECLARE @SQL NVARCHAR(MAX);	


-- #########################
-- SELEÇÃO DO ARQUIVO
-- #########################
	DECLARE @FILE_MODEL_PATH VARCHAR(1000); SET @FILE_MODEL_PATH = (SELECT TOP 1 [DESCRICAO] AS 'FILE_MODEL_PATH' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'PRE_VALIDACAO_CAR');
	DECLARE @FILE_MODEL		 VARCHAR(1000); SET @FILE_MODEL		 = (SELECT TOP 1 [DESCRICAO_02] AS 'FILE_MODEL' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'PRE_VALIDACAO_CAR');

-- ##################################
-- COPIA DE ARQUIVO MODELO
-- ##################################
	DECLARE 
			 @DT_PROCESS  VARCHAR(8)
			,@ARQUIVO_PRE VARCHAR(100)

	SET @DT_PROCESS = (SELECT TOP 1 SUBSTRING([NOME_ARQUIVO],15,8) FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR] WHERE [PROCESSO_CAR] = 'DESCOMPACTACAO_CAR' ORDER BY [ID] DESC)
	SET @ARQUIVO_PRE = 'G-CA$H_PRE_VALIDACAO_CAR_' + @DT_PROCESS + '.xlsm'

	SET @Cmd = 'COPY ' + @FILE_MODEL_PATH + @FILE_MODEL + ' ' + @FILE_MODEL_PATH + @ARQUIVO_PRE;
	--PRINT @Cmd  

	EXEC xp_cmdshell @Cmd--,no_output	

-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################
-- [3] -> CARREGAR DADOS EM ARQUIVO COPIADO
-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################

-- #########################
-- EXPORTAR DADOS
-- #########################
	--SET @SQL = 'INSERT INTO OPENROWSET(''Microsoft.ACE.OLEDB.12.0'',''Excel 12.0 Xml;HDR=YES;Database=' + '\\172.16.0.4\siscob\DOWNLOAD\' + @FILE_NAME + ''',''SELECT * FROM [Dados$]'') '
	SET @SQL = 'INSERT INTO OPENROWSET(''Microsoft.ACE.OLEDB.12.0'',''Excel 12.0 Xml;HDR=YES;Database=' + @FILE_MODEL_PATH + @ARQUIVO_PRE + ''',''SELECT * FROM [FIXA_AGING$]'') '
	SET @SQL = @SQL + 'select [TIPO]'
    SET @SQL = @SQL + ',[A FATURAR]'
    SET @SQL = @SQL + ',[00 - A VENCER]'
    SET @SQL = @SQL + ',[01 - DE 01 A 30]'
    SET @SQL = @SQL + ',[02 - DE 31 A 75]'
    SET @SQL = @SQL + ',[03 - DE 76 A 105]'
    SET @SQL = @SQL + ',[04 - DE 106 A 365]'
    SET @SQL = @SQL + ',[05 - MAIOR 365] FROM [DB_SISCOB].[FILE_CAR].[PRE_VALIDACAO_FIXA_AGING]'
	SET @SQL = @SQL + ' ORDER BY TIPO'
	--PRINT @SQL
	EXEC(@SQL) 

	SET @SQL = 'INSERT INTO OPENROWSET(''Microsoft.ACE.OLEDB.12.0'',''Excel 12.0 Xml;HDR=YES;Database=' + @FILE_MODEL_PATH + @ARQUIVO_PRE + ''',''SELECT * FROM [FIXA_SEG_DESCR$]'') '
	SET @SQL = @SQL + 'select [TIPO]'
    SET @SQL = @SQL + ',[VPE]'
    SET @SQL = @SQL + ',[VPE-GOV]'
    SET @SQL = @SQL + ',[VPG-TOP]'
    SET @SQL = @SQL + ',[VPG-TOP-GOV]'
    SET @SQL = @SQL + ',[VPK]'
    SET @SQL = @SQL + ',[VPK-GOV]'
    SET @SQL = @SQL + ',[CORPORATIVO]'
    SET @SQL = @SQL +  ' FROM [DB_SISCOB].[FILE_CAR].[PRE_VALIDACAO_FIXA_SEG_DESCR]'
	SET @SQL = @SQL + ' ORDER BY TIPO'
	--PRINT @SQL
	EXEC(@SQL) 

	SET @SQL = 'INSERT INTO OPENROWSET(''Microsoft.ACE.OLEDB.12.0'',''Excel 12.0 Xml;HDR=YES;Database=' + @FILE_MODEL_PATH + @ARQUIVO_PRE + ''',''SELECT * FROM [MOVEL_AGING$]'') '
	SET @SQL = @SQL + 'select [FORNECEDOR]'
    SET @SQL = @SQL + ',[A FATURAR]'
    SET @SQL = @SQL + ',[00 - A VENCER]'
    SET @SQL = @SQL + ',[01 - DE 01 A 30]'
    SET @SQL = @SQL + ',[02 - DE 31 A 75]'
    SET @SQL = @SQL + ',[03 - DE 76 A 105]'
    SET @SQL = @SQL + ',[04 - DE 106 A 365]'
    SET @SQL = @SQL + ',[05 - MAIOR 365] FROM [DB_SISCOB].[FILE_CAR].[PRE_VALIDACAO_MOVEL_AGING]'
	SET @SQL = @SQL + ' ORDER BY [FORNECEDOR]'
	--PRINT @SQL
	EXEC(@SQL) 

	SET @SQL = 'INSERT INTO OPENROWSET(''Microsoft.ACE.OLEDB.12.0'',''Excel 12.0 Xml;HDR=YES;Database=' + @FILE_MODEL_PATH + @ARQUIVO_PRE + ''',''SELECT * FROM [MOVEL_SEG_DESCR$]'') '
	SET @SQL = @SQL + 'select [FORNECEDOR]'
    SET @SQL = @SQL + ',[VPE]'
    SET @SQL = @SQL + ',[VPE-GOV]'
    SET @SQL = @SQL + ',[VPG-TOP]'
    SET @SQL = @SQL + ',[VPG-TOP-GOV]'
    SET @SQL = @SQL + ',[VPK]'
    SET @SQL = @SQL + ',[VPK-GOV]'
    SET @SQL = @SQL + ',[CORPORATIVO]'
    SET @SQL = @SQL +  ' FROM [DB_SISCOB].[FILE_CAR].[PRE_VALIDACAO_MOVEL_SEG_DESCR]'
	SET @SQL = @SQL + ' ORDER BY [FORNECEDOR]'
	--PRINT @SQL
	EXEC(@SQL) 
	
	SET @SQL = 'INSERT INTO OPENROWSET(''Microsoft.ACE.OLEDB.12.0'',''Excel 12.0 Xml;HDR=YES;Database=' + @FILE_MODEL_PATH + @ARQUIVO_PRE + ''',''SELECT * FROM [ABERTURA_FIXA_POR_FORNECEDOR$]'') '
	SET @SQL = @SQL + 'select CASE WHEN [FORNECEDOR]  is not null then [FORNECEDOR] else ''SEM DISTRIBUIÇÃO'' END AS [FORNECEDOR]'
    SET @SQL = @SQL + ',[SEG_DESCR]'
    SET @SQL = @SQL + ',sum([SALDO_CAR]) AS SOMA_SALDO_CAR'
    SET @SQL = @SQL +  ' FROM [DB_SISCOB].[FILE_CAR].[TB_TRATAMENTO_FIXA_WEB]'
	SET @SQL = @SQL + ' WHERE [OK] = 1 '
	SET @SQL = @SQL + ' GROUP BY [SEG_DESCR],[FORNECEDOR] '
	--SET @SQL = @SQL + ' ORDER BY [FORNECEDOR]'

	--PRINT @SQL
	EXEC(@SQL) 
	



-- ############################
-- ENVIO DE ARQUIVO POR E-MAIL
-- ############################

	DECLARE  @REPORT_SUBJECT	VARCHAR(100)
			,@REPORT_EMAIL		VARCHAR(255)
			,@REPORT_BODY		VARCHAR(200)
			,@ANEXO				VARCHAR(255)
			,@COPY				VARCHAR(255)
	
	
	SET @REPORT_SUBJECT = 'G-CA$H_Validação_' + @DT_PROCESS
	SET @REPORT_EMAIL	= (SELECT [DESCRICAO] FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'PRE_VALIDACAO_ENVIO_EMAIL')
	SET @COPY			= (SELECT [DESCRICAO_02] FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'PRE_VALIDACAO_ENVIO_EMAIL')
	SET @REPORT_BODY	= 'Prezados, <br /> <br /> Segue em anexo Pré-Validação CAR ' + @DT_PROCESS + '.'
	SET @ANEXO			= @FILE_MODEL_PATH + @ARQUIVO_PRE


	EXEC msdb.dbo.sp_send_dbmail
	@profile_name = 'ENVIO_SISCOB',
	@recipients = @REPORT_EMAIL,
	@copy_recipients = @COPY,
	@subject = @REPORT_SUBJECT,
	@Body = @REPORT_BODY,
	@file_attachments = @ANEXO,
	@body_format = 'HTML'

-- ############################
-- EXCLUSÃO ARQUIVO ENVIADO
-- ############################

	SET @Cmd = 'del ' + @ANEXO;
	--PRINT @Cmd  

	EXEC xp_cmdshell @Cmd--,no_output	
	

	INSERT INTO [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR]
	(
	   [PROCESSO_CAR]
      ,[NOME_ARQUIVO]
      ,[CAR_PERIODO]
      ,[STATUS]
      ,[DT_PROCESSAMENTO]
	)

	VALUES
	(
		 'AGUARDANDO_VALIDACAO_MIS'
		,'AGUARDANDO_VALIDACAO_MIS'
		,RIGHT(@DT_PROCESS,2)
		,0
		,GETDATE()
	)

END	

