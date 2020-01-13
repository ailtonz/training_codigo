Set WshShell = WScript.CreateObject("WScript.Shell")

wshshell.RegWrite "HKLM\System\CurrentcontrolSet\Control\Session Manager\Memory Management\PagingFiles", "c:\pagefile.sys 256 256", "REG_SZ"

WshShell.run "c:\setup\images\display.vbs", 6, true

WshShell.run "c:\moc\setup\mocset\mocset2.cmd", 6, true

WshShell.run "c:\moc\setup\shutdown.exe /L /R /Y", 6, true