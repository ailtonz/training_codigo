Dim wshshell, fso
Set fso=CreateObject("Scripting.FileSystemObject")
set wshshell=wscript.createObject("wscript.shell")
fso.CreateFolder "C:\Fonts\"
wshshell.run("d:\tools\Fonts.exe /c /t:c:\Fonts /q"), 6, true
set wshshell=wscript.createObject("wscript.shell")
wshshell.run("c:\Fonts\Fontinst.exe"), 6, true

