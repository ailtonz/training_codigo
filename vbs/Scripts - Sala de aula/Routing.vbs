' Determine the LDAP path for your domain
Set Root = GetObject("LDAP://RootDSE")
DomainPath = Root.Get("DefaultNamingContext")

Set WshShell = Wscript.CreateObject("Wscript.Shell")
Set WshSysEnv = WshShell.Environment("Process")
DCName = wshSysEnv("COMPUTERNAME")

Dim FileSystem
Set FileSystem = WScript.CreateObject("Scripting.FileSystemObject")

Set dcOU = GetObject("LDAP://OU=Domain Controllers," & DomainPath)

Set DC = GetObject("LDAP://CN=" & DCName & ",OU=Domain Controllers," & DomainPath)

'Delete the published printQueue object

DC.delete "printQueue" , "CN=" & DCName & "-HP Color LaserJet 4500"

'Delete the actual printer and driver

wshShell.run "net share /d hpcolorl", 6, true
wshShell.run "rundll32 printui.dll,PrintUIEntry /dl /n" + Chr(34) & "HP Color LaserJet 4500" + Chr(34), 6, true
wshShell.run "net stop spooler", 6, true
wshShell.run "net start spooler", 6, true
wshShell.run "rundll32 printui.dll,PrintUIEntry /dd /m " + Chr(34) & "HP Color LaserJet 4500" + Chr(34) & " /h " + Chr(34) & "Intel" + Chr(34) & " /v " + Chr(34) & "Windows 2000" + Chr(34), 6, true

'Delete the published folder

dcOU.delete "volume" , "CN=Accounting"

wshShell.run "net share /d accounting", 6, true
FileSystem.DeleteFolder("C:\Accounting")


