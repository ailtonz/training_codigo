Dim IE, fso, MyFile
Set fso = CreateObject("Scripting.FileSystemObject")
Set IE = CreateObject("InternetExplorer.Application")
set wshshell = wscript.CreateObject("wscript.shell")
ie.left=0
ie.top=0
ie.height=700
ie.width=800
ie.menubar=0
ie.toolbar=0
ie.addressbar=0
ie.statusbar=0
ie.navigate "file:///c:\setup\html\lon_end.htm"
ie.visible=1

wscript.Sleep 5000

if fso.FileExists ("C:\Documents and Settings\All Users\Start Menu\Programs\Startup\runnext.vbs") then
	set MyFile = fso.GetFile("C:\Documents and Settings\All Users\Start Menu\Programs\Startup\runnext.vbs")
	MyFile.Delete
end if

'Disable Auto Logon
WshShell.RegWrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\AutoAdminLogon", 0 ,"REG_SZ"

'* Insert final tasks here
'

'Disable Internet Connection Wizard
WshShell.run "c:\setup\ie.vbs", 6, true


'Display the final HTML page.
ie.navigate "file:///c:\setup\html\lon_end.htm"
