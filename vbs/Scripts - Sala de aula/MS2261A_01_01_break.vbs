' moveuser.vbs
' 
' This script calls the moveusers.bat file, which Moves Imported User and Computer Accounts to Default Containers

set wshshell = CreateObject("wscript.shell")
CurrDir = wshshell.CurrentDirectory
wshshell.CurrentDirectory = "c:\Moc\2274\Labfiles\Setup"

'Populate Active Directory
WshShell.run "moveusers.bat", 6, true

wshshell.CurrentDirectory = CurrDir