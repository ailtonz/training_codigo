USE [DB_SISCOB]
GO
/****** Object:  StoredProcedure [FILE_CAR].[PRC_000_UPLOAD_CAR_FIXA]    Script Date: 12/5/2016 7:24:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<AILTON ZACARIAS>
-- Create date: <19/09/2016>
-- Description:	<IMPORT FILE CAR>
-- =============================================

create PROCEDURE [FILE_CAR].[PRC_000_UPLOAD_CAR_FIXA] 
--WITH EXECUTE AS 'USR_ADMIN'

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

-- ########################################
-- LISTAR ARQUIVOS E DESCOMPACTAR ARQUIVOS
-- ########################################

DECLARE 
		  @name			VARCHAR(50)
		, @PERIODO		VARCHAR(10)
		, @RETVAL		INT
		, @tmp			VARCHAR(100)		
		, @FILE_NAME	VARCHAR(100)
		, @DIA			VARCHAR(2)
		, @MES			VARCHAR(2)
		, @nameText		VARCHAR(50)
		, @RET_FILE		INT
		

	DECLARE @FILE_PATH	VARCHAR(100)	SET @FILE_PATH	= 'D:\siscob\Relatorios\FILE_CAR\'
	DECLARE @FILE_MOVE	VARCHAR(100)	SET @FILE_MOVE	= '\\10.128.222.63\siscob\Relatorios\FILE_CAR\_BKP\CAR\'
	DECLARE @STRSPACE	VARCHAR(10)		SET @STRSPACE	= '          '
	DECLARE @CMD		NVARCHAR(2000)	

	DECLARE	@FILE_CAR	VARCHAR(100)	SET @FILE_CAR 	= 'CAR_FIXA*.txt'
	DECLARE @CMD_FILES	NVARCHAR(2000)	SET @CMD_FILES 	= 'dir ' + @FILE_PATH + @FILE_CAR + ' /A-D /B /ON'
	DECLARE @fileCAR TABLE (ID int IDENTITY, FileName varchar(100)); INSERT INTO @fileCAR EXECUTE xp_cmdshell @CMD_FILES
	DECLARE	db_file	CURSOR FOR SELECT [FileName] FROM @fileCAR WHERE [FileName] is not null and [FileName] <> 'file not found'

-- ########################################
--- ###################	UPLOAD FILE CAR
-- ########################################

	OPEN db_file FETCH NEXT FROM db_file INTO @nameText

	WHILE @@FETCH_STATUS = 0   
	BEGIN   
		
		SET @tmp		= db_siscob.dbo.GetFileNameWithoutExtension(@FILE_PATH+@nameText);
		SET @PERIODO	= right(left(@tmp,LEN(@tmp)-4),8);
		SET @DIA		= SUBSTRING(@tmp,CHARINDEX('.',@tmp)-2,2) -- right(@PERIODO,2); 
		SET @MES		= substring(@PERIODO,len(@PERIODO)-3,2); 
		
		-- VERIFICA A EXISTENCIA DA SUBIDA DO "FILE_CAR"	
		SET @RET_FILE = (SELECT S.[ID] FROM [DB_SISCOB].[AUXILIAR].[TB_STATUS_CAR] S WHERE S.[FILE_CAR] LIKE '%'+@nameText+'%')
		
		-- SE NÃO EXISTIR CADASTRA
		IF @RET_FILE IS NULL 
		BEGIN
			
			EXEC FILE_CAR.PRC_100_CARREGAR_CAR_FIXA @nameText
			EXEC FILE_CAR.PRC_001_REGRA_ENREQUECIMENTO_FIXA
			
			-- CADASTRA O LOG DA SUBIDA DO ARQUIVO "FILE_CAR"
			INSERT INTO [DB_SISCOB].[ADM].[TB_APP_CONTROLE] 
						([TIPO],[DESCRICAO],[DESCRICAO_02],[DTSUBIDA])
				 VALUES 
						('LOG_CAR',@FILE_PATH + @nameText,SUBSTRING(@FILE_PATH + @nameText,CHARINDEX('.',@FILE_PATH + @nameText)-2,2),CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE(),106),103))			
		END
		
		FETCH NEXT FROM db_file INTO @nameText   
	END   

	CLOSE db_file   
	DEALLOCATE db_file							

END


