	
	
	declare @ANALISTA varchar(300)
	declare @appName varchar(300)
	declare @tmp varchar(300)
	
	set @ANALISTA = '23'
	set @appName = 'cmd.exe /c "\\172.16.0.6\e\sftp_files\FTP_User\SISCOB\pacotes\exportAcordo.exe" '+ @ANALISTA
	

	exec master..xp_cmdshell @appName

	--exec @appName  @ANALISTA