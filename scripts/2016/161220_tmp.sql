DECLARE @Cmd VARCHAR(500);
SET @Cmd = '\\172.16.0.6\e\sftp_files\FTP_User\SISCOB\pacotes\LimparArquivosAntigos.exe' ;  
--PRINT @Cmd
EXEC xp_cmdshell @Cmd