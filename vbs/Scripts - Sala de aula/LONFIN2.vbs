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
ie.navigate "file:///c:\setup\html\lon\loncustf.htm"
ie.visible=1

wscript.Sleep 5000


'set script to run after reboot
strNext = "c:\setup\lonfinal.vbs"
if fso.FileExists (strNext) then
	set strt = fso.getfolder("c:\documents and settings\all users\start menu\programs\startup")
	fn = "runnext.vbs"
	set nxt = fso.getfile(strNext)
	set fl = fso.createtextfile(strt & "\" & fn, true)
	fl.writeline("set wshshell = wscript.createobject" & chr(40) & chr(34) & "wscript.shell" & chr(34) & chr(41))
	fl.writeline("wshshell.run " & chr(34) & nxt & chr(34))
	fl.Close
else
	set MyFile = fso.GetFile("C:\Documents and Settings\All Users\Start Menu\Programs\Startup\runnext.vbs")
	MyFile.Delete
end if


'Install Adobe Acrobat Reader 6.0
'ie.navigate "file:///c:\setup\html\lon\loncustf.htm"
'wshshell.run "c:\setup\adberdr.vbs", 1, true

'Install Courseware fonts
ie.navigate "file:///c:\setup\html\lon\loncustg.htm"
WshShell.run "c:\tools\runfonts.vbs", 6, true

'Install Microsoft PowerPoint 2002 and Microsoft Excel 2002
ie.navigate "file:///c:\setup\html\lon\loncusth.htm"
WshShell.run "c:\setup\instppxl.vbs", 1, true

'Install PowerPoint slides
ie.navigate "file:///c:\setup\html\lon\loncusti.htm"
wshshell.run "c:\tools\2030_ppt.msi", 1, true

'Install course demo files
ie.navigate "file:///c:\setup\html\lon\loncustj.htm"
WshShell.Run "c:\setup\AllFiles.exe /auto" , 6, true

'Attach lab database files in SQL Server
ie.navigate "file:///c:\setup\html\lon\loncustk.htm"
wshshell.run "c:\setup\attachdb.bat", 6, true

'Configure file-viewing settings
ie.Navigate "file:///c:\setup\html\lon\loncustl.htm"
wshshell.Run "c:\setup\explrcfg.vbs", 6, true

'Configure folder sharing
ie.navigate "file:///c:\setup\html\lon\loncustm.htm"
wshshell.run "c:\setup\cfgfldrs.vbs", 6, true

'Configure AdventureWorks portal web site
ie.navigate "file:///c:\setup\html\lon\loncustn.htm"
wshshell.run "c:\setup\cfgwsite.vbs", 6, true

'Configure Internet Explorer favorites
ie.navigate "file:///c:\setup\html\lon\loncusto.htm"
wshshell.run "c:\setup\cfgiefav.vbs", 6, true

'Reboot the machine
WshShell.run "c:\tools\reboot.cmd", 6, true