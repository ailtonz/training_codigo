on error resume next
Set WshShell = WScript.CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
Set objNet = WScript.CreateObject("WScript.Network")
CompName = objNet.ComputerName 
CompDomain = objNet.UserDomain
'check to see if student domain exists wait if not, join it if it is.

If CompName = "VANCOUVER" then
		WshShell.run "d:\join\van.cmd", 1, true
End if

If CompName = "DENVER" then
		WshShell.run "d:\join\DEN.cmd", 1, true
End if

If CompName = "PERTH" then
		WshShell.run "d:\join\per.cmd", 1, true
End if

If CompName = "BRISBANE" then
		WshShell.run "d:\join\BRI.cmd", 1, true
End if

If CompName = "LISBON" then
		WshShell.run "d:\join\lis.cmd", 1, true
End if

If CompName = "BONN" then
		WshShell.run "d:\join\BON.cmd", 1, true
End if

If CompName = "LIMA" then
		WshShell.run "d:\join\lim.cmd", 1, true
End if

If CompName = "SANTIAGO" then
		WshShell.run "d:\join\SAN.cmd", 1, true
End if

If CompName = "BANGALORE" then
		WshShell.run "d:\join\ban.cmd", 1, true
End if

If CompName = "SINGAPORE" then
		WshShell.run "d:\join\SIN.cmd", 1, true
End if

If CompName = "CASABLANCA" then
		WshShell.run "d:\join\cas.cmd", 1, true
End if

If CompName = "TUNIS" then
		WshShell.run "d:\join\TUN.cmd", 1, true
End if

If CompName = "ACAPULCO" then
		WshShell.run "d:\join\aca.cmd", 1, true
End if

If CompName = "MIAMI" then
		WshShell.run "d:\join\MIA.cmd", 1, true
End if

If CompName = "AUCKLAND" then
		WshShell.run "d:\join\auc.cmd", 1, true
End if

If CompName = "SUVA" then
		WshShell.run "d:\join\SUV.cmd", 1, true
End if

If CompName = "STOCKHOLM" then
		WshShell.run "d:\join\sto.cmd", 1, true
End if

If CompName = "MOSCOW" then
		WshShell.run "d:\join\MOS.cmd", 1, true
End if