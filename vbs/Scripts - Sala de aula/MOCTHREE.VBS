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
ie.navigate "file:///c:\moc\setup\mochtml\moccust6.htm"
ie.visible=1

wscript.Sleep 5000

'set lonfinal.vbs to run after reboot
if fso.FileExists ("c:\moc\setup\mocfinal.vbs") then
	set strt = fso.getfolder("c:\documents and settings\all users\start menu\programs\startup")
	fn = "runnext.vbs"
	set nxt = fso.getfile("c:\moc\setup\mocfinal.vbs")
	set fl = fso.createtextfile(strt & "\" & fn, true)
	fl.writeline("set wshshell = wscript.createobject" & chr(40) & chr(34) & "wscript.shell" & chr(34) & chr(41))
	fl.writeline("wshshell.run " & chr(34) & nxt & chr(34))
	fl.Close
else
	set MyFile = fso.GetFile("C:\Documents and Settings\All Users\Start Menu\Programs\Startup\runnext.vbs")
	MyFile.Delete
end if

'Install SQL Server 2000 (if required)
'wshshell.run "\\london\setup\sqlsetup.cmd", 6, true	
		
'Install MSOffice XP Pro with Front Page (if required)
'wshshell.run "c:\setup\flats\msoxp\setup.exe TRANSFORMS=c:\setup\MSOXPUN.MST /qb-", 6, true

'Reboot the Computer (if SQL or Office were installed)
'wshShell.Run "c:\tools\reboot.cmd", 6, true

'Install the Microsoft .NET Framework Samples Database
ie.Navigate "file:///c:\moc\setup\mochtml\moccust6.htm"
szPath = chr(34) & "C:\Program Files\Microsoft Visual Studio .NET\FrameworkSDK\Samples\Setup\msde\instmsde.exe" & chr(34)
WshShell.run szPath, 6, true

'Install the Microsoft .NET QuickStarts
ie.Navigate "file:///c:\moc\setup\mochtml\moccust7.htm"
szPath = chr(34) & "C:\Program Files\Microsoft Visual Studio .NET\FrameworkSDK\Samples\Setup\ConfigSamples.exe" & chr(34) & " -q"
WshShell.run szPath, 6, true

'If a reboot is not required, run Lonfinal.vbs to complete the setup
'WshShell.run "c:\moc\setup\mocFINAL.VBS", 6, FALSE
'ie.Quit


if fso.FileExists ("C:\Documents and Settings\All Users\Start Menu\Programs\Startup\runnext.vbs") then
	set MyFile = fso.GetFile("C:\Documents and Settings\All Users\Start Menu\Programs\Startup\runnext.vbs")
	MyFile.Delete
end if

'Disable Auto Logon
ie.Navigate "file:///c:\moc\setup\mochtml\moccust7.htm"
WshShell.RegWrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\AutoAdminLogon", 0 ,"REG_SZ"


'* Insert final tasks here
'

ie.Navigate "file:///c:\moc\setup\mochtml\moc_end.htm"