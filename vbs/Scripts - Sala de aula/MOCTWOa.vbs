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
ie.navigate "file:///c:\moc\setup\mochtml\moccust4.htm"
ie.visible=1

wscript.Sleep 5000

'set lonthree.vbs to run after reboot
if fso.FileExists ("c:\moc\setup\mocthree.vbs") then
	set strt = fso.getfolder("c:\documents and settings\all users\start menu\programs\startup")
	fn = "runnext.vbs"
	set nxt = fso.getfile("c:\moc\setup\mocthree.vbs")
	set fl = fso.createtextfile(strt & "\" & fn, true)
	fl.writeline("set wshshell = wscript.createobject" & chr(40) & chr(34) & "wscript.shell" & chr(34) & chr(41))
	fl.writeline("wshshell.run " & chr(34) & nxt & chr(34))
	fl.Close
else
	set MyFile = fso.GetFile("C:\Documents and Settings\All Users\Start Menu\Programs\Startup\runnext.vbs")
	MyFile.Delete
end if

'Install SQL 2000 Service Pack 2
ie.Navigate "file:///c:\moc\setup\mochtml\moccust4.htm"
wshshell.Run "C:\Tools\sql2knm.vbs", 6, true

'Reboot the Computer
wshShell.Run "c:\tools\reboot.cmd", 6, true
