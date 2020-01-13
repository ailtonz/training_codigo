on error resume next
Set WshShell = WScript.CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
Set objNet = WScript.CreateObject("WScript.Network")
CompName = objNet.ComputerName 
CompDomain = objNet.UserDomain
'check to see if student domain exists wait if not, join it if it is.

If CompName = "VANCOUVER" then
		WshShell.run "c:\join\van.cmd", 1, true
End if

If CompName = "DENVER" then
		WshShell.run "c:\join\DEN.cmd", 1, true
End if

If CompName = "PERTH" then
		WshShell.run "c:\join\per.cmd", 1, true
End if

If CompName = "BRISBANE" then
		WshShell.run "c:\join\BRI.cmd", 1, true
End if

If CompName = "LISBON" then
		WshShell.run "c:\join\lis.cmd", 1, true
End if

If CompName = "BONN" then
		WshShell.run "c:\join\BON.cmd", 1, true
End if

If CompName = "LIMA" then
		WshShell.run "c:\join\lim.cmd", 1, true
End if

If CompName = "SANTIAGO" then
		WshShell.run "c:\join\SAN.cmd", 1, true
End if

If CompName = "BANGALORE" then
		WshShell.run "c:\join\ban.cmd", 1, true
End if

If CompName = "SINGAPORE" then
		WshShell.run "c:\join\SIN.cmd", 1, true
End if

If CompName = "CASABLANCA" then
		WshShell.run "c:\join\cas.cmd", 1, true
End if

If CompName = "TUNIS" then
		WshShell.run "c:\join\TUN.cmd", 1, true
End if

If CompName = "ACAPULCO" then
		WshShell.run "c:\join\aca.cmd", 1, true
End if

If CompName = "MIAMI" then
		WshShell.run "c:\join\MIA.cmd", 1, true
End if

If CompName = "AUCKLAND" then
		WshShell.run "c:\join\auc.cmd", 1, true
End if

If CompName = "SUVA" then
		WshShell.run "c:\join\SUV.cmd", 1, true
End if

If CompName = "STOCKHOLM" then
		WshShell.run "c:\join\sto.cmd", 1, true
End if

If CompName = "MOSCOW" then
		WshShell.run "c:\join\MOS.cmd", 1, true
End if