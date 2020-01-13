   EXEC MSDB.dbo.sp_send_cdosysmail 
      @PROFILE_NAME = 'ENVIO_SISCOB'
      @To = 'l.a.junior@accenture.com;a.dasilva@accenture.com',      
      @Subject = '[SISCOB] - [CONCLUIDO] - MIS VPE FIXA ( NÃO ) >>> TESTE <<<',      
      @Body = 'Relatorio gerado com sucesso!',      
      @Anexo = null,      
      @Tipo = 'HTMLBody'



EXEC msdb.dbo.sp_send_dbmail
@profile_name = 'ENVIO_SISCOB',
@recipients = 'a.dasilva@accenture.com',
@subject = '[SISCOB] - [CONCLUIDO] - MIS VPE FIXA ( NÃO ) >>> TESTE <<<',
@Body = 'Relatorio gerado com sucesso!',
@file_attachments = NULL;