'========================Backup do Log de Aplica��o==========================================

set obj = getobject("winmgmts:{(backup)}") _
.execquery("select * from  win32_nteventlogfile" & _
" where LogfileName = 'application'")
for each olog in obj
resp = olog.backupeventlog("c:\application.evt")
if resp = 0 then 
	wscript.Echo "Backup Efetuado com o mais alto sucesso"
	olog.cleareventlog()
else
	wscript.Echo "Backup BZ"
end if
next
'=============================================================================================
'===================================
'Backup de qualquer tipo de LOG
'===================================
set obj = getobject("winmgmts:{(backup)}") _
.execquery("select * from  win32_nteventlogfile" & _
" where LogfileName = 'application'")
for each olog in obj
resp = olog.backupeventlog("c:\application.evt")
if resp = 0 then 
	wscript.Echo "Backup Efetuado com o mais alto sucesso"
	olog.cleareventlog()
else
	wscript.Echo "Backup BZ"
end if
next