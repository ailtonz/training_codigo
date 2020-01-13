
	DECLARE @FILE_PATH	VARCHAR(1000); SET @FILE_PATH	= '\\172.16.0.6\e\sftp_files\FTP_User\SISCOB\_AUXILIARES\';
	DECLARE @FILE_NAME	VARCHAR(1000); SET @FILE_NAME	= 'CARTEIRA_CONSOLIDADA_DEZ.16.xlsx';

	DECLARE @TMP VARCHAR(1000); SET @TMP = 'Excel 12.0;Database='+ @FILE_PATH + @FILE_NAME
	DECLARE @SQL VARCHAR(8000); 

-- ################################################################
-- CRIA TABELA DE TRANSITO DE DADOS PARA TRANSFERENCIAS DE DADOS
-- ################################################################

	IF EXISTS(SELECT * FROM sys.tables WHERE name = N'tmp__CARTEIRA')
	BEGIN
	DROP TABLE [DB_SISCOB].[TRANSITO].[tmp__CARTEIRA]
	END


	CREATE TABLE [DB_SISCOB].[TRANSITO].[tmp__CARTEIRA](
		[RAIZ] [nvarchar](255) NULL,
		[RAZAO_SOCIAL] [nvarchar](255) NULL,
		[RAIZ_GRUPO] [nvarchar](255) NULL,
		[NOME_GRUPO] [nvarchar](255) NULL,
		[GN] [nvarchar](255) NULL,
		[GV] [nvarchar](255) NULL,
		[DIRETOR] [nvarchar](255) NULL,
		[SEGMENTO_CARTEIRA_FIXA] [nvarchar](255) NULL,
		[SEGMENTO_CARTEIRA_MOVEL] [nvarchar](255) NULL,
		[ID_TASK] [nvarchar](255) NULL
	) ON [PRIMARY]

-- ################################################################ -- [dados$]
-- TRANSFERE DADOS ENTRE PLANILHA E TABELA DE TRANSITO
-- ################################################################

	SET @SQL = '
	INSERT INTO [DB_SISCOB].[TRANSITO].[tmp__CARTEIRA]
		(

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
			   
		)

	SELECT

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


	FROM 
	OPENROWSET(''Microsoft.ACE.OLEDB.12.0'','''+ @TMP+''' , [CARTEIRA$])'

	EXEC(@SQL)


