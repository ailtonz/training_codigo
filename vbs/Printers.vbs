' printer.vbs
'
' Configures a Print Share
' Installs an HP LaserJet 5Si with a name of "Class"

set wshshell=wscript.createobject("wscript.shell")

wshshell.run "rundll32 printui.dll,PrintUIEntry /if /b " & chr(34) & "Class" & chr(34) & " /f %windir%\inf\ntprint.inf /r " & chr(34) & "lpt1:" & chr(34) & " /m " & chr(34) & "HP LaserJet 5Si" & chr(34), 1, true