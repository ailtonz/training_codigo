'============================================================
'
'Consulte na documentação do WMI SDK DOCUMENTATION sobre win32_process
'para ver a listagem das propriedades dos processos
'
'============================================================

set objsvc = getobject("winmgmts:\\bfins13")
Set colProcessos = objsvc.ExecQuery("Select * from win32_process")' where priority >= 13")

for each p in colProcessos
	txt = txt & p.description & " (" & p.ExecutablePath & ")" & vbnewline
next
wscript.Echo txt