declare @app nvarchar(1000);
declare @Cmd nvarchar(1000);

set @app = '\\172.16.0.11\f$\siscob\ACORDO\teste\exportAcordo.exe';
SET @Cmd = @app + ' 23';
--print @Cmd 
EXEC xp_cmdshell @Cmd