Dim objnet, wshShell, fso, ie, url
Set objNet = WScript.CreateObject("WScript.Network")
Set WshShell = WScript.CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
Set IE = CreateObject("InternetExplorer.Application")
ie.left=0
ie.top=0
ie.height=570
ie.width=800
ie.menubar=0
ie.toolbar=0
ie.addressbar=0
ie.statusbar=0
ie.navigate "file:///c:/moc/setup/mochtml/mochtml4.htm"
ie.visible=1

WScript.Sleep 5000

'Remove so this won't run again
Dim MyFile
Set MyFile = fso.GetFile(wshShell.SpecialFolders("AllUsersStartup") & "\runnext.vbs")
MyFile.Delete

'turning off autoadmin logon
ie.navigate "file:///c:/moc/setup/mochtml/mochtml5.htm"
WshShell.RegWrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Autoadminlogon", 0 ,"REG_SZ"


	'set domain to native mode
ie.navigate "file:///c:/moc/setup/mochtml/mochtml6.htm"
wshshell.run "c:\tools\native.vbs", 6, true



'installing labfiles
ie.Navigate "file:///c:/moc/setup/mochtml/mochtml7.htm"
wshshell.Run "c:\moc\setup\allfiles.exe /auto c:\moc\2126", 1, true

	'Set up Files, Folders and Shares
ie.navigate "file:///c:/moc/setup/mochtml/mochtml8.htm"
wshshell.run "c:\tools\files.bat", 6, true

	'User Log on Rights
ie.navigate "file:///c:/moc/setup/mochtml/mochtml9.htm"
wshshell.run "c:\tools\Rights.cmd", 6, true

	'create OUs Groups & users mode
ie.navigate "file:///c:/moc/setup/mochtml/mochtmla.htm"
wshshell.run "c:\tools\groups.vbs", 6, true

	'Disable ie connection wizard
ie.navigate "file:///c:/moc/setup/mochtml/mochtmlb.htm"
WshShell.Run "c:\tools\ie.vbs", 6, True

'Copy Course files to d:
ie.navigate url & 2
wshShell.Run "xcopy c:\moc\*.* c:\moc\*.* /E", 6 ,True

'modify IP configuration
wshshell.Run "c:\moc\setup\stuip.vbs", 6, true


'installation Complete
ie.navigate "file:///c:/moc/setup/mochtml/moc_end.htm"


