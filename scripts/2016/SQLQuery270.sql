USE [DB_SISCOB]
GO
/****** Object:  StoredProcedure [FILE_CAR].[PRC_000_UPLOAD_CAR_FIXA_WEB]    Script Date: 12/12/2016 3:41:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<AILTON ZACARIAS>
-- Create date: <19/09/2016>
-- Description:	<IMPORT FILE CAR>
-- =============================================

ALTER PROCEDURE [FILE_CAR].[PRC_000_UPLOAD_CAR_FIXA_WEB] 
--WITH EXECUTE AS 'USR_ADMIN'

AS
BEGIN
	
	SET NOCOUNT ON;
	
	-----------------------------------
	-- Processamento Descompactar Arquivos 7z
		
	Declare @processo TABLE (ID BIGINT , NOME_ARQUIVO varchar(100))
	Declare @NomeArquivo varchar(100)
	Declare @ID BIGINT
	
	INSERT INTO @processo (ID,NOME_ARQUIVO)
		SELECT 
			 [ID]
			,[NOME_ARQUIVO]
		FROM 
			[DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR] 
		WHERE 
			[PROCESSO_CAR] = 'DESCOMPACTACAO_CAR'
			AND STATUS = 0;
	
	SET @ID			 = (SELECT id FROM @processo)									  
	SET @NomeArquivo = (SELECT NOME_ARQUIVO FROM @processo)

	UPDATE [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR] SET [DT_PROCESSAMENTO] = GETDATE() WHERE ID = @ID;

	EXEC [FILE_CAR].[DESCOMPACTAR]
								 '\\172.16.0.6\e\sftp_files\FTP_User\SISCOB\_FILE_CAR\'
								,'\\172.16.0.6\e\sftp_files\FTP_User\SISCOB\_FILE_CAR\'
								,@NomeArquivo
								,'Z:\_siscob\bin\app\7-ZipPortable\App\7-Zip64\7Z.exe'
								,'\\172.16.0.6\e\sftp_files\FTP_User\SISCOB\_FILE_CAR\bkp\';
	
	UPDATE [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR] SET 
														 [DT_PROCESSAMENTO_FIM] = GETDATE() 
														,STATUS = 1
	WHERE ID = @ID;
	----------------------------------------------------------------------------------------------------------------------------------------

	--Cadastrar Log de Execucao de Importacoes - Car Fixa
	-----------------------------------------------------------------------------------------------------------------------------------------
	DECLARE @CMD_FILES	NVARCHAR(2000)	SET @CMD_FILES 	= 'dir \\172.16.0.6\e\sftp_files\FTP_User\SISCOB\_FILE_CAR\CAR_FIXA*.txt /A-D /B /ON'
	DECLARE @fileCAR TABLE (ID int IDENTITY, FileName varchar(100)); INSERT INTO @fileCAR EXECUTE xp_cmdshell @CMD_FILES
	
	INSERT INTO [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR] 
	(
		 [PROCESSO_CAR]
		,[NOME_ARQUIVO]
		,[CAR_PERIODO]
		,[STATUS]
		,[DT_PROCESSAMENTO]
	)

	VALUES
	('IMPORTACAO_CAR_FIXA'
	 ,(SELECT FileName FROM @fileCAR WHERE FileName IS NOT NULL)
	 ,(SELECT [CAR_PERIODO] FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR] WHERE ID = 1)
	 ,0
	 ,GETDATE()
	)
	-----------------------------------------------------------------------------------------------------------------------------------------


	--Cadastrar Log de Execucao de Importacoes - Car Movel
	-----------------------------------------------------------------------------------------------------------------------------------------
	declare @CMD_FILES varchar(1000)
	SET @CMD_FILES 	= 'dir \\172.16.0.6\e\sftp_files\FTP_User\SISCOB\_FILE_CAR\CAR_MOVEL*.txt /A-D /B /ON'
	DECLARE @fileCAR TABLE (ID int IDENTITY, FileName varchar(100)); INSERT INTO @fileCAR EXECUTE xp_cmdshell @CMD_FILES
	
	
	

	INSERT INTO [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR] 
	(
		 [PROCESSO_CAR]
		,[NOME_ARQUIVO]
		,[CAR_PERIODO]
		,[STATUS]
		,[DT_PROCESSAMENTO]
	)

	VALUES
	('IMPORTACAO_CAR_MOVEL'
	 ,(SELECT FileName FROM @fileCAR WHERE FileName IS NOT NULL)
	 ,(SELECT [CAR_PERIODO] FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR] WHERE ID = 1)
	 ,0
	 ,GETDATE()
	)
	--------------------------------------------------------------------------------------------------------------------------------------------


	--Cadastrar Log de Execucao de Importacoes - Lotes
	-----------------------------------------------------------------------------------------------------------------------------------------
	SET @CMD_FILES 	= 'dir \\172.16.0.6\e\sftp_files\FTP_User\SISCOB\_FILE_CAR\Lotes.txt /A-D /B /ON'
	DELETE FROM @fileCAR;
	INSERT INTO @fileCAR EXECUTE xp_cmdshell @CMD_FILES

	declare @CMD_FILES varchar(1000)
	SET @CMD_FILES 	= 'dir \\172.16.0.6\e\sftp_files\FTP_User\SISCOB\_FILE_CAR\Lotes.txt /A-D /B /ON'
	DECLARE @fileCAR TABLE (ID int IDENTITY, FileName varchar(100)); INSERT INTO @fileCAR EXECUTE xp_cmdshell @CMD_FILES

	INSERT INTO [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR] 
	(
		 [PROCESSO_CAR]
		,[NOME_ARQUIVO]
		,[CAR_PERIODO]
		,[STATUS]
		,[DT_PROCESSAMENTO]
	)

	VALUES
	('IMPORTACAO_LOTES'
	 ,(SELECT FileName FROM @fileCAR WHERE FileName IS NOT NULL)
	 ,(SELECT [CAR_PERIODO] FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR] WHERE ID = 1)
	 ,0
	 ,GETDATE()
	)
	----------------------------------------------------------------------------------------------------------------------------------------


DECLARE 

	    @Id_imp				BIGINT
	   ,@Processo_Car		VARCHAR(255)
       ,@Nome_Arquivo_Imp	VARCHAR(255)
       ,@Car_Periodo		CHAR(2)
       ,@Status				INT
       ,@Dt_Process			DATETIME
	   ,@FileImport			VARCHAR(255)
	   ,@FileMove			VARCHAR(255)
	   ,@Move				varchar(1000)
      
	
	DECLARE	db_file	CURSOR FOR SELECT 
										 [ID]
										,[PROCESSO_CAR]
										,[NOME_ARQUIVO]
										,[CAR_PERIODO]
										,[STATUS]
										,[DT_PROCESSAMENTO]
								FROM
										[DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR]
								WHERE
										STATUS = 0;
	

	OPEN db_file FETCH NEXT FROM db_file INTO   @Id_imp				
											   ,@Processo_Car		
											   ,@Nome_Arquivo_Imp	
											   ,@Car_Periodo		
											   ,@Status				
											   ,@Dt_Process	

	WHILE @@FETCH_STATUS = 0   
	BEGIN   
		
		Set @FileImport = '\\172.16.0.6\e\sftp_files\FTP_User\SISCOB\_FILE_CAR\' + @Nome_Arquivo_Imp
		Set @FileMove   = 'Z:\_siscob\bin\CAR' + @Nome_Arquivo_Imp


		IF @Processo_Car = 'IMPORTACAO_CAR_FIXA'
			BEGIN
			
				
				EXEC [FILE_CAR].[PRC_100_CARREGAR_CAR_FIXA_WEB]   '[FILE_CAR].[TB_CAR_FIXA_WEB]'
																 ,@FileImport
																 ,@FileMove
																 ,';'
																 ,'2';

				 SET @Move = 'MOVE ' + @FileImport + ' ' + @FileMove 
				 EXEC xp_cmdshell @Move

			
				UPDATE [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR] SET 
															 [DT_PROCESSAMENTO_FIM] = GETDATE() 
															,STATUS = 1

				WHERE ID = @Id_imp;


				INSERT INTO [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR] 
				(
					 [PROCESSO_CAR]
					,[NOME_ARQUIVO]
					,[CAR_PERIODO]
					,[STATUS]
					,[DT_PROCESSAMENTO]
				)

				VALUES
				('ENREQUECIMENTO_CAR_FIXA'
				 ,'[FILE_CAR].[PRC_001_REGRA_ENREQUECIMENTO_FIXA]'
				 ,(SELECT [CAR_PERIODO] FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR] WHERE ID = @Id_imp)
				 ,0
				 ,GETDATE()
				)
			END
		
		ELSE IF @Processo_Car = 'IMPORTACAO_CAR_MOVEL'
			
			BEGIN
				
				EXEC [FILE_CAR].[PRC_100_CARREGAR_CAR_FIXA_WEB]  '[FILE_CAR].[TB_CAR_MOVEL_WEB]'
																 ,@FileImport
																 ,@FileMove
																 ,';'
																 ,'2';
			
				UPDATE [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR] SET 
															 [DT_PROCESSAMENTO_FIM] = GETDATE() 
															,STATUS = 1
				WHERE ID = @Id_imp;

				INSERT INTO [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR] 
				(
					 [PROCESSO_CAR]
					,[NOME_ARQUIVO]
					,[CAR_PERIODO]
					,[STATUS]
					,[DT_PROCESSAMENTO]
				)

				VALUES
				('ENREQUECIMENTO_CAR_MOVEL'
				 ,'[FILE_CAR].[PRC_002_A_REGRA_ENREQUECIMENTO_MOVEL]'
				 ,(SELECT [CAR_PERIODO] FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR] WHERE ID = @Id_imp)
				 ,0
				 ,GETDATE()
				),
				('ENREQUECIMENTO_CAR_MOVEL'
				 ,'[FILE_CAR].[PRC_002_B_ATRIBUI_FORNECEDOR]'
				 ,(SELECT [CAR_PERIODO] FROM [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR] WHERE ID = @Id_imp)
				 ,0
				 ,GETDATE()
				)

				SET @Move = 'MOVE ' + @FileImport + ' ' + @FileMove 
				EXEC xp_cmdshell @Move
			END

		ELSE IF @Processo_Car = 'IMPORTACAO_LOTES'
			
			BEGIN
				
				EXEC [FILE_CAR].[PRC_100_CARREGAR_CAR_FIXA_WEB]  '[FILE_CAR].[LOTES]'
																 ,@FileImport
																 ,@FileMove
																 ,';'
																 ,'1';
			
				UPDATE [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR] SET 
															 [DT_PROCESSAMENTO_FIM] = GETDATE() 
															,STATUS = 1
				WHERE ID = @Id_imp;

				SET @Move = 'MOVE ' + @FileImport + ' ' + @FileMove 
				EXEC xp_cmdshell @Move

			END
			
		
		FETCH NEXT FROM db_file INTO	@Id_imp				
										,@Processo_Car		
										,@Nome_Arquivo_Imp	
										,@Car_Periodo		
										,@Status				
										,@Dt_Process	  
	
	END

	CLOSE db_file   
	DEALLOCATE db_file
	
	
	
	--------------------------------------------------------------------------------------------------------------------------------------
	DECLARE 

	    @Id_imp				BIGINT
	   ,@Processo_Car		VARCHAR(255)
       ,@Nome_Arquivo_Imp	VARCHAR(255)
       ,@Car_Periodo		CHAR(2)
       ,@Status				INT
       ,@Dt_Process			DATETIME
	   ,@FileImport			VARCHAR(255)
	   ,@FileMove			VARCHAR(255)
	   ,@Move				varchar(1000)

	DECLARE 
		db_file_proc	CURSOR FOR SELECT 
										 [ID]
										,[PROCESSO_CAR]
										,[NOME_ARQUIVO]
										,[CAR_PERIODO]
										,[STATUS]
										,[DT_PROCESSAMENTO]
								FROM
										[DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR]
								WHERE
										STATUS = 0
								ORDER BY [ID];
	

	OPEN db_file_proc FETCH NEXT FROM db_file_proc INTO   @Id_imp				
											   ,@Processo_Car		
											   ,@Nome_Arquivo_Imp	
											   ,@Car_Periodo		
											   ,@Status				
											   ,@Dt_Process	

	WHILE @@FETCH_STATUS = 0   
	BEGIN   
		

		EXEC(@Nome_Arquivo_Imp)
		
		Update [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR] SET 
															 STATUS = 1 
															,DT_PROCESSAMENTO_FIM = GETDATE()
			
		WHERE ID = @Id_imp;		
	

		FETCH NEXT FROM db_file_proc INTO	@Id_imp				
										,@Processo_Car		
										,@Nome_Arquivo_Imp	
										,@Car_Periodo		
										,@Status				
										,@Dt_Process	  
	
	END

	CLOSE db_file_proc   
	DEALLOCATE db_file_proc
	
	
	INSERT INTO [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR]
	(
	   [PROCESSO_CAR]
      ,[NOME_ARQUIVO]
      ,[CAR_PERIODO]
      ,[STATUS]
      ,[DT_PROCESSAMENTO]
	)
	
	VALUES
	('PRE-VALIDACAO_FIXA_AGING','[FILE_CAR].[PRC_PRE_VALIDACAO_FIXA_AGING]',CONVERT(CHAR(2),@ID),0,GETDATE()),
	('PRE-VALIDACAO_FIXA_SEG_DESCR','[FILE_CAR].[PRC_PRE_VALIDACAO_FIXA_SEG_DESCR]',CONVERT(CHAR(2),@ID),0,GETDATE()),
	('PRE-VALIDACAO_MOVEL_AGING','[FILE_CAR].[PRC_PRE-VALIDACAO_MOVEL_AGING]',CONVERT(CHAR(2),@ID),0,GETDATE()),
	('PRE-VALIDACAO_MOVEL_SEG_DESCR','[FILE_CAR].[PRC_PRE-VALIDACAO_MOVEL_SEG_DESCR]',CONVERT(CHAR(2),@ID),0,GETDATE())



DECLARE 
		db_file_Valida	CURSOR FOR SELECT 
										 [ID]
										,[PROCESSO_CAR]
										,[NOME_ARQUIVO]
										,[CAR_PERIODO]
										,[STATUS]
										,[DT_PROCESSAMENTO]
								FROM
										[DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR]
								WHERE
										STATUS = 0
								ORDER BY [ID];
	

	OPEN db_file_Valida FETCH NEXT FROM db_file INTO   @Id_imp				
											   ,@Processo_Car		
											   ,@Nome_Arquivo_Imp	
											   ,@Car_Periodo		
											   ,@Status				
											   ,@Dt_Process	

	WHILE @@FETCH_STATUS = 0   
	BEGIN   
		

		EXEC(@Nome_Arquivo_Imp)
		
		Update [DB_SISCOB].[ADM].[TB_APP_CONTROLE_CAR] SET 
															 STATUS = 1 
															,DT_PROCESSAMENTO_FIM = GETDATE()
			
		WHERE ID = @Id_imp;		
	

		FETCH NEXT FROM db_file_Valida INTO	@Id_imp				
										,@Processo_Car		
										,@Nome_Arquivo_Imp	
										,@Car_Periodo		
										,@Status				
										,@Dt_Process	  
	
	END

	CLOSE db_file_proc   
	DEALLOCATE db_file_proc
	


END


