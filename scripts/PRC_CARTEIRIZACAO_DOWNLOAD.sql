USE [DB_SISCOB]
GO
/****** Object:  StoredProcedure [APP_WEB].[PRC_CARTEIRIZACAO_DOWNLOAD]    Script Date: 11/13/2016 7:05:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [APP_WEB].[PRC_CARTEIRIZACAO_DOWNLOAD] --@FILE_PATH NVARCHAR(1000), @FILE_NAME NVARCHAR(1000) 
AS
BEGIN

SET NOCOUNT ON


DECLARE @Cmd VARCHAR(500);
DECLARE @SQL NVARCHAR(MAX);	


-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################
-- [1] -> MAPEAR PASTA DE DESTINO DE DOWNLOAD
-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################

-- #########################
-- MAPEAMENTO - ( USUÁRIO )
-- #########################
	DECLARE @USUARIO_NOME VARCHAR(100); SET @USUARIO_NOME = (SELECT TOP 1 [DESCRICAO] AS USUARIO_NOME FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'NET_USER');
	DECLARE @USUARIO_SENHA VARCHAR(100); SET @USUARIO_SENHA = (SELECT TOP 1 [DESCRICAO_02] AS USUARIO_SENHA FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'NET_USER');

-- #########################
-- MAPEAMENTO - ( CAMINHO )
-- #########################
	DECLARE @MAPEAMENTO_CAMINHO VARCHAR(100); SET @MAPEAMENTO_CAMINHO = (SELECT TOP 1 [DESCRICAO] AS MAPEAMENTO_CAMINHO FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'CARTEIRIZACAO_DOWNLOAD');
	DECLARE @MAPEAMENTO_UNIDADE VARCHAR(100); SET @MAPEAMENTO_UNIDADE = (SELECT TOP 1 [DESCRICAO_02] AS MAPEAMENTO_UNIDADE FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'CARTEIRIZACAO_DOWNLOAD');

-- #########################
-- MAPEAMENTO - ( CRIAÇÃO )
-- #########################
	----SET @Cmd = 'NET USE X:\\172.16.0.4\siscob\DOWNLOAD\ ' + @USUARIO_SENHA + ' /USER:' + @USUARIO_NOME + ' /PERSISTENT:yes'
	--SET @Cmd = 'NET USE ' + @MAPEAMENTO_UNIDADE + '  ' + @MAPEAMENTO_CAMINHO + '  ' + @USUARIO_SENHA + ' /USER:' + @USUARIO_NOME -- ' /PERSISTENT:yes'
	--PRINT @Cmd
	--EXEC xp_cmdshell @Cmd--,no_output

--EXEC xp_cmdshell 'net use j: \\172.16.0.4\siscob 41L70N%& /user:a.dasilva'
--EXEC xp_cmdshell 'move i:\siscob\fileModel\CARTEIRIZACAO_mkt.xlsx j:\DOWNLOAD\CARTEIRIZACAO_mkt.xlsx'
--EXEC xp_cmdshell 'net use j: /delete /y'


-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################
-- [2] -> COPIAR ARQUIVO MODELO 
-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################

-- #########################
-- SELEÇÃO DO ARQUIVO
-- #########################
	DECLARE @FILE_MODEL_PATH VARCHAR(1000); SET @FILE_MODEL_PATH = (SELECT TOP 1 [DESCRICAO] AS 'FILE_MODEL_PATH' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'CARTEIRIZACAO_FILE_MODEL_PATH');
	DECLARE @FILE_MODEL		 VARCHAR(1000); SET @FILE_MODEL		 = (SELECT TOP 1 [DESCRICAO] AS 'FILE_MODEL' FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'CARTEIRIZACAO_FILE_MODEL');

-- ##################################
-- COPIA DE ARQUIVO MODELO
-- ##################################
	SET @Cmd = 'COPY ' + @FILE_MODEL_PATH + @FILE_MODEL + ' ' + @FILE_MODEL_PATH + 'CARTEIRIZACAO_MKT.xlsx' ;
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
	SET @SQL = 'INSERT INTO OPENROWSET(''Microsoft.ACE.OLEDB.12.0'',''Excel 12.0 Xml;HDR=YES;Database=' + @FILE_MODEL_PATH + 'CARTEIRIZACAO_MKT.xlsx' + ''',''SELECT * FROM [Dados$]'') '
	SET @SQL = @SQL + 'select * FROM [DB_SISCOB].[APP_WEB].[VW_CARTEIRA_MKT_CONSOLIDADA]'
	--PRINT @SQL
	EXEC(@SQL) 
	
-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################
-- [4] -> TRANSFERIR ARQUIVO FINAL
-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################

-- ##################################
-- TRANSFERENCIA ENTRE SERVIDORES
-- ##################################
	SET @Cmd = 'COPY ' + @FILE_MODEL_PATH + 'CARTEIRIZACAO_MKT.xlsx' + ' ' +  @MAPEAMENTO_CAMINHO + 'CARTEIRA' + '\CARTEIRIZACAO_MKT.xlsx' ;  
	--PRINT @Cmd
	EXEC xp_cmdshell @Cmd,no_output	

-- #########################
-- MAPEAMENTO - ( EXCLUSÃO )
-- #########################
	--SET @Cmd = 'NET USE ' + @MAPEAMENTO_UNIDADE + ' /delete /y ' ; 
	--PRINT @Cmd 
	--EXEC xp_cmdshell @Cmd--,no_output

END

