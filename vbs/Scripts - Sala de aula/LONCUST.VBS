Dim IE, fso, MyFile
Set fso = CreateObject("Scripting.FileSystemObject")
Set IE = CreateObject("InternetExplorer.Application")
set wshshell = wscript.CreateObject("wscript.shell")
ie.left=0
ie.top=0
ie.height=570
ie.width=800
ie.menubar=0
ie.toolbar=0
ie.addressbar=0
ie.statusbar=0
ie.navigate "file:///c:\setup\html\loncusto.htm"
ie.visible=1

wscript.Sleep 5000
'Delete the startup file
Set MyFile = fso.GetFile("C:\Documents and Settings\All Users\Start Menu\Programs\Startup\runnext.vbs")
MyFile.Delete

'set lonfinal.vbs to run after reboot
set strt = fso.getfolder("c:\documents and settings\all users\start menu\programs\startup")
fn = "runnext.vbs"
set nxt = fso.getfile("c:\setup\lonfinal.vbs")
set fl = fso.createtextfile(strt & "\" & fn, true)
fl.writeline("set wshshell = wscript.createobject" & chr(40) & chr(34) & "wscript.shell" & chr(34) & chr(41))
fl.writeline("wshshell.run " & chr(34) & nxt & chr(34))



'Install win2k sp2
wshshell.Run "d:\sp2\w2ksp2.exe -u -n -o", 1, true