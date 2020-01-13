declare @REPORT_EMAIL varchar(255); set @REPORT_EMAIL = (select 'a.dasilva@accenture.com' as email );
declare @REPORT_SUBJECT varchar(255); set @REPORT_SUBJECT = (select 'TESTE DE ENVIO' as 'subject' );
declare @FILE_PATH varchar(255); set @FILE_PATH = (select '\\172.16.0.11\siscob\CENARIO\4060746948_CENARIO.7z' as 'subject' );
declare @REPORT_Body varchar(255); SET @REPORT_Body  = GETDATE();
PRINT @REPORT_Body;


	EXEC msdb.dbo.sp_send_dbmail
	@profile_name = 'ENVIO_SISCOB',
	@recipients = @REPORT_EMAIL,
	@subject = @REPORT_SUBJECT,
	@Body = @REPORT_Body ,
	@file_attachments = '\\172.16.0.11\siscob\CENARIO\4060746948_CENARIO.7z';