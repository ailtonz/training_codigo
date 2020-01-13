' glashare.vbs
'
' This script creates the shared folder on Glasgow

dim fso

set fso = CreateObject("Scripting.FileSystemObject")
set wshshell = Wscript.CreateObject("Wscript.Shell")

if not(fso.FolderExists("C:\Share")) then fso.CreateFolder "C:\Share"
   wshshell.Run "net share Share=C:\Share"

WshShell.Run "C:\moc\setup\rmtshare.exe \\glasgow\Share /grant administrators:f", 6, true