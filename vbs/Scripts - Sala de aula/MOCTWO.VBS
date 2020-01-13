'on error resume next
Dim IE, fso, MyFile
Set fso = CreateObject("Scripting.FileSystemObject")
Set IE = CreateObject("InternetExplorer.Application")
set wshshell = wscript.CreateObject("wscript.shell")
ie.left=0
ie.top=0
ie.height=600
ie.width=800
ie.menubar=0
ie.toolbar=0
ie.addressbar=0
ie.statusbar=0
ie.Navigate "file:///c:\moc\setup\mochtml\moccust5.htm"
ie.visible=1

wscript.Sleep 5000

if fso.FileExists ("C:\Documents and Settings\All Users\Start Menu\Programs\Startup\runnext.vbs") then
	set MyFile = fso.GetFile("C:\Documents and Settings\All Users\Start Menu\Programs\Startup\runnext.vbs")
	MyFile.Delete
end If

'Disable Auto Logon
'ie.navigate "file:///c:\setup\html\loncusti.htm"
WshShell.RegWrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\AutoAdminLogon", 0 ,"REG_SZ"

'make sure SQL is up and running
WScript.Sleep 15000

'install the SQL Database
wshShell.run "c:\moc\setup\inssqldb.cmd", 6, True

ie.Navigate "file:///c:\moc\setup\mochtml\moc_end.htm"
