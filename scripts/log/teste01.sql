	DECLARE @Cmd VARCHAR(500);
	DECLARE @SQL NVARCHAR(MAX);
	DECLARE @DATABASE NVARCHAR(1000);	

-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################
-- [1] -> MAPEAR PASTA DE DESTINO DE DOWNLOAD
-- ###################################################################################################################################################################################
-- ###################################################################################################################################################################################

-- #########################
-- MAPEAMENTO - ( USUÁRIO )
-- #########################
	DECLARE @USUARIO_NOME VARCHAR(100); 
	--SET @USUARIO_NOME = (SELECT TOP 1 [DESCRICAO] AS USUARIO_NOME FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'NET_USER');
	SET @USUARIO_NOME = 'a.dasilva'

	DECLARE @USUARIO_SENHA VARCHAR(100); 
	--SET @USUARIO_SENHA = (SELECT TOP 1 [DESCRICAO_02] AS USUARIO_SENHA FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'NET_USER');
	SET @USUARIO_SENHA = 'rdp@2016'

-- #########################
-- MAPEAMENTO - ( CAMINHO )
-- #########################
	DECLARE @MAPEAMENTO_CAMINHO VARCHAR(100); 
	--SET @MAPEAMENTO_CAMINHO = (SELECT TOP 1 [DESCRICAO] AS MAPEAMENTO_CAMINHO FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'CARTEIRIZACAO_DOWNLOAD');
	SET @MAPEAMENTO_CAMINHO ='\\172.16.0.6\e'

	DECLARE @MAPEAMENTO_UNIDADE VARCHAR(100); 
	--SET @MAPEAMENTO_UNIDADE = (SELECT TOP 1 [DESCRICAO_02] AS MAPEAMENTO_UNIDADE FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'CARTEIRIZACAO_DOWNLOAD');
	SET @MAPEAMENTO_UNIDADE = 'y:'

	DECLARE @FILE_NAME VARCHAR(100); 
	--SET @FILE_NAME = (SELECT TOP 1 [NOME_ARQUIVO] FROM [DB_SISCOB].[APP_WEB].[TBL_LOG_CARTEIRA] ORDER BY [ID] DESC);
	SET @FILE_NAME = 'CARTEIRA_CONSOLIDADA.xlsx'

	-- #########################
	-- MAPEAMENTO - ( CRIAÇÃO )
	-- #########################

	SET @Cmd = 'NET USE ' + @MAPEAMENTO_UNIDADE + '  ' + @MAPEAMENTO_CAMINHO + '  ' + @USUARIO_SENHA + ' /USER:' + @USUARIO_NOME -- ' /PERSISTENT:yes'
	PRINT @Cmd
	EXEC xp_cmdshell @Cmd--,no_output

	-- #########################
	-- LIMPAR TABELA DE TRANSITO
	-- #########################

	TRUNCATE TABLE [DB_SISCOB].[TRANSITO].[tmp_CARTEIRA_MKT]

	-- ##########################
	-- CARREGAR DADOS EM TRANSITO
	-- ##########################

	SET @DATABASE = 'Excel 12.0;Database=' + @MAPEAMENTO_UNIDADE + '\' + @FILE_NAME;
	SET @SQL = 'SELECT * FROM OPENROWSET(''Microsoft.ACE.OLEDB.12.0'',''' + @DATABASE + ''' , [Dados$])';
	
	INSERT INTO [DB_SISCOB].[TRANSITO].[tmp_CARTEIRA_MKT] (
		   [RAIZ]
		  ,[RAZAO_SOCIAL]
		  ,[RAIZ_GRUPO]
		  ,[NOME_GRUPO]
		  ,[GN]
		  ,[GV]
		  ,[DIRETOR]
		  ,[SEGMENTO_CARTEIRA_FIXA]
		  ,[SEGMENTO_CARTEIRA_MOVEL]
		  ,[ID_TASK]
		  ,[DT_ATUALIZACAO]
	)EXEC (@sql)