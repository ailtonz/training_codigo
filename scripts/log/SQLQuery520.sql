declare @app nvarchar(1000);
declare @Cmd nvarchar(1000);
 
set @app = '\\172.16.0.11\siscob\SEGMENTO\exportMIS.exe ';
SET @Cmd = @app + '1';
print @Cmd 
EXEC xp_cmdshell @Cmd 


-- consolidado
-- dados_valores