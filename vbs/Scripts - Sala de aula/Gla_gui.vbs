' gimport.vbs
' 
' This script calls the import.bat file, which populates Active Directory on Glasgow

set wshshell = CreateObject("wscript.shell")
CurrDir = wshshell.CurrentDirectory

WshShell.run "net use z: \\london\labfiles\setup", 6, true
wshshell.CurrentDirectory = "z:\"

'Populate Active Directory
WshShell.run "Glasgowimport.bat", 6, true

'set the password for each user account to be P@ssw0rd
WshShell.run "Glasgowsetpass.vbs", 1, true

'set Interactive Logon Rights
WshShell.run "GlasgowUsers.cmd", 1, true

wshshell.CurrentDirectory = CurrDir