Dim wshshell, fso
Set fso=CreateObject("Scripting.FileSystemObject")
set wshshell=wscript.createObject("wscript.shell")
fso.CreateFolder "C:\fonts\"
wshshell.run("c:\tools\fonts.exe /c /t:c:\fonts /q"), 6, true
set wshshell=wscript.createObject("wscript.shell")
wshshell.run("c:\fonts\fontinst.exe"), 6, true
