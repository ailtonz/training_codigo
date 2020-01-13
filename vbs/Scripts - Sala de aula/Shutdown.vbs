'Create Shortcut on desktop
Dim wshShell, oShellLink, sDir, fld, fso, subfld, oldWorking
Set wshShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
Set fld = fso.GetFolder("C:\WINDOWS\Microsoft.NET\Framework\")
For Each subfld In fld.SubFolders 
	If Left(subfld.Name,2) = "v1" Then
		sDir = fld.Path & "\" & subfld.Name
		Exit for
	End if
Next
Set fld = fso.GetFolder(sDir)

set oShellLink = WshShell.CreateShortcut(WshShell.SpecialFolders("Desktop")&  "\mscorcfg.msc.lnk")
oShellLink.TargetPath = sDir & "\mscorcfg.msc"
oShellLink.WindowStyle = 1
oShellLink.IconLocation = sDir & "\mscorcfg.msc, 0"
oShellLink.WorkingDirectory = sDir
oShellLink.Save

oldWorking = wshShell.CurrentDirectory
wshShell.CurrentDirectory = sDir
'Run bat file to configure security
wshShell.Run "c:\setup\secsetup.bat", 6, True
wshShell.CurrentDirectory = oldWorking
