'=========================================================================================
'=========================================================================================
'set obj = getobject("winmgmts:").instancesof("win32_networkadapterconfiguration")
'for each nic in obj
'txt = txt & nic.index & "  " & nic.caption & vbnewline
'next
'wscript.Echo txt

'=============================================================================================================
'=============================================================================================================

'set obj2 = getobject("winmgmts:").execquery("select * from win32_service where state='running'")
'for each nic2 in obj2
'txt2 = txt2 & nic2.name & "                      -                  " & nic2.state & vbnewline
'next
'wscript.Echo txt2

'=============================================================================================================
'=============================================================================================================
set obj = getobject("winmgmts:\\santiago").execquery("select caption from win32_process where " & "caption='calc.exe'")
for each proc in obj
	if proc.caption = "calc.exe" then
	wscript.Echo "Calculator rodando"
	resp = "ok"
	end if
next
	
if resp <> "ok" then
	set obj2 = getobject("winmgmts:win32_process")
	obj2.create("calc.exe")
end if	

	
	
'txt = txt & proc.caption & vbnewline
'next
'wscript.Echo txt &