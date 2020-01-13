--select * from [APP_WEB].[TBL_ARQUIVOS_TRANSITO_ACORDOS] order by id desc


DECLARE @Cmd VARCHAR(500);
----set @Cmd = 'Z:\_siscob\new\exportAcordo.exe 94';
--set @Cmd = 'Z:\_siscob\new\run.bat';
--PRINT @Cmd;
--EXEC xp_cmdshell @Cmd--,no_output

-- #########################
-- MAPEAMENTO - ( USUÁRIO )
-- #########################
	DECLARE @USUARIO_NOME VARCHAR(100); SET @USUARIO_NOME = (SELECT TOP 1 [DESCRICAO] AS USUARIO_NOME FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'NET_USER');
	DECLARE @USUARIO_SENHA VARCHAR(100); SET @USUARIO_SENHA = (SELECT TOP 1 [DESCRICAO_02] AS USUARIO_SENHA FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'NET_USER');

-- #########################
-- MAPEAMENTO - ( CAMINHO )
-- #########################
	DECLARE @MAPEAMENTO_CAMINHO VARCHAR(100); 
	--SET @MAPEAMENTO_CAMINHO = (SELECT TOP 1 [DESCRICAO] AS MAPEAMENTO_CAMINHO FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'CARTEIRIZACAO_DOWNLOAD');
	
	--SET @MAPEAMENTO_CAMINHO = '\\172.16.0.11\siscob\ACORDO\new\'
	SET @MAPEAMENTO_CAMINHO = '\\172.16.0.11\siscob'
	--- \\172.16.0.11\siscob\ACORDO\exportAcordo.exe

	DECLARE @MAPEAMENTO_UNIDADE VARCHAR(100); 
	--SET @MAPEAMENTO_UNIDADE = (SELECT TOP 1 [DESCRICAO_02] AS MAPEAMENTO_UNIDADE FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE] WHERE [TIPO] = 'CARTEIRIZACAO_DOWNLOAD');

	DECLARE @MAPEAMENTO_CAMINHO_APP VARCHAR(100);
	SET @MAPEAMENTO_CAMINHO_APP = '\ACORDO\'

	SET @MAPEAMENTO_UNIDADE = 'M:'

	
-- #########################
-- MAPEAMENTO - ( CRIAÇÃO )
-- #########################

-- ############# - MAPEAMENTO
	
	--SET @Cmd = 'NET USE ' + @MAPEAMENTO_UNIDADE + '  ' + @MAPEAMENTO_CAMINHO + '  ' + @USUARIO_SENHA + ' /USER:telefonicabpo.local\' + @USUARIO_NOME + ' /PERSISTENT:yes'
	--SET @Cmd = 'NET USE ' + @MAPEAMENTO_UNIDADE + '  ' + @MAPEAMENTO_CAMINHO + '  ' + @USUARIO_SENHA + ' /USER: ' + @USUARIO_NOME + ' /PERSISTENT:yes'

	SET @Cmd = 'NET USE ' + @MAPEAMENTO_UNIDADE + '  ' + @MAPEAMENTO_CAMINHO + '  ' + @USUARIO_SENHA + ' /USER: ' + @USUARIO_NOME + ' /PERSISTENT:yes'
	PRINT @Cmd
	EXEC xp_cmdshell @Cmd--,no_output

-- ############# - SELEÇÃO

	--SET @Cmd = @MAPEAMENTO_UNIDADE
	--PRINT @Cmd;
	--EXEC xp_cmdshell @Cmd--,no_output

---- ############# - APONTAMENTO 01

--	SET @Cmd = 'cd\'
--	PRINT @Cmd;
--	EXEC xp_cmdshell @Cmd--,no_output

---- ############# - APONTAMENTO 02

--	SET @Cmd = 'cd ACORDO\new'
--	PRINT @Cmd;
--	EXEC xp_cmdshell @Cmd--,no_output

-- ############# - EXECUÇÃO

	--set @Cmd = @MAPEAMENTO_UNIDADE + @MAPEAMENTO_CAMINHO_APP + 'exportAcordo.exe 15';
	set @Cmd = @MAPEAMENTO_CAMINHO + @MAPEAMENTO_CAMINHO_APP + 'exportAcordo.exe 15';


	--- @MAPEAMENTO_CAMINHO
	--- @MAPEAMENTO_CAMINHO_APP

	PRINT @Cmd;
	EXEC xp_cmdshell @Cmd--,no_output

	DECLARE @Cmd VARCHAR(500);
	set @cmd = '\\172.16.0.11\siscob\ACORDO\exportAcordo.exe 15';
	EXEC xp_cmdshell @Cmd


-- ############# - EXCLUSÃO

	----DECLARE @MAPEAMENTO_UNIDADE VARCHAR(100);	
	--SET @MAPEAMENTO_UNIDADE = 'M:';
	----DECLARE @Cmd VARCHAR(500);					
	--SET  @Cmd ='NET USE ' + @MAPEAMENTO_UNIDADE + ' /delete /y';
	--PRINT @Cmd;
	--EXEC xp_cmdshell  @Cmd


--usr_siscob