Dim objnet, wshShell
Set objNet = WScript.CreateObject("WScript.Network")
Set WshShell = WScript.CreateObject("WScript.Shell")

wshshell.run "\\london\winxppro\i386\winnt32.exe /s:\\london\winxppro\i386 /unattend:c:\moc\setup\winxp.txt", 6, True

