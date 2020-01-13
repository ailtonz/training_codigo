on error resume next
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
ie.navigate "file:///c:\moc\setup\mochtml\GLACUST1.HTM"
ie.visible=1

WScript.Sleep 5000

start = wshShell.SpecialFolders("AllUsersStartMenu") & "\Programs\Startup\"
'Remove mocsetup.cmd file from startup group to prevent this script from running again
Dim MyFile
Set MyFile = fso.GetFile(start & "mocsetup.cmd")
MyFile.Delete

'set to run after reboot
set strt = fso.getfolder("c:\documents and settings\all users\start menu\programs\startup")
fn = "runnext.vbs"
set nxt = fso.getfile("c:\moc\setup\GlaTwo.vbs")
set fl = fso.createtextfile(strt & "\" & fn, true)
fl.writeline "set wshshell = wscript.createobject" & chr(40) & chr(34) & "wscript.shell" & chr(34) & chr(41)
fl.writeline "wshshell.run " & chr(34) & nxt & chr(34)

WshShell.run "c:\setup\images\display.vbs", 6, true

wshshell.run "c:\tools\dfltDmn.vbs", 6, true

'Configure IP address of 2nd NIC
wshshell.run "c:\tools\setip2.vbs", 6, true
wshshell.run "c:\tools\setip.vbs", 6, true

'Enable WINS PRoxy
ie.navigate "file:///c:\moc\setup\mochtml\GLACUST2.HTM"
wshshell.run "c:\tools\winsprxy.vbs", 6, true

'enable routing
wshshell.run "c:\tools\enroute.vbs", 6, true

'install sp2
ie.navigate "file:///c:\moc\setup\mochtml\GLACUST3.HTM"
wshshell.run "\\london\setup\flats\w2ksp2\w2ksp2.exe -u -n -q", 6, true

'reboot by sp2
