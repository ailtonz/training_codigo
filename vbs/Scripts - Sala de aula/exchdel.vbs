on error resume next
dim fso, d, dc, dl, run
set wshshell=wscript.createobject("wscript.shell")
set fso = CreateObject("Scripting.FileSystemObject")
set dc = fso.drives
fso.CreateFolder("d:\exchange")
wshshell.Run "net share exchange=d:\exchange", 6, true
do until resp=vbcancel
	For each d in dc
		set dl = fso.getdrive(d)
		lookfor=dl & "\setup\i386\exsetdata.dll"
		lookfora = dl & "\exchsrvr60\setup\i386\exsetdata.dll"
		if dl.isready then
			if (fso.FileExists(lookfor)) then
				Set ts = fso.CreateTextFile("c:\tools\copyexchange.vbs", True)
				ts.WriteLine "Set oSHApp = CreateObject(" & chr(34) & "Shell.Application" & chr(34) & ")" 
				ts.writeline "sSrc = " & chr(34) & dl & "\*.*" & chr(34)
				ts.writeline "sDest = " & chr(34) & "d:\exchange" & chr(34)
				ts.writeline "oSHApp.Namespace(sDest).CopyHere sSrc, &H10&"
				ts.writeline "WScript.Quit"
				ts.Close
				WshShell.run "c:\tools\copyexchange.vbs", 1, true
				wscript.quit
			end if
			if (fso.FileExists(lookfora)) then
				Set ts = fso.CreateTextFile("c:\tools\copyexchange.vbs", True)
				ts.WriteLine "Set oSHApp = CreateObject(" & chr(34) & "Shell.Application" & chr(34) & ")" 
				ts.writeline "sSrc = " & chr(34) & dl & "\exchsrvr60\*.*" & chr(34)
				ts.writeline "sDest = " & chr(34) & "d:\exchange" & chr(34)
				ts.writeline "oSHApp.Namespace(sDest).CopyHere sSrc, &H10&"
				ts.writeline "WScript.Quit"
				ts.Close
				WshShell.run "c:\tools\copyexchange.vbs", 1, true
				wscript.quit
			end if
		End If
	Next
	
	msg = "Please insert either retail or MSDN Subscription version of the Microsoft" & chr(10)
	msg = msg + "Exchange 2000 Enterprise Edition compact disk, and then click OK." & chr(10) & chr(10)
	msg = msg + "NOTE: This setup was built with the April 2001 MSDN Subscription." & chr(10)
	msg = msg + "If you are using a different version of the MSDN Subscription, you" & chr(10)
	msg = msg + "may need to click Cancel to enter the path of the source files" & chr(10) & chr(10)
	msg = msg + "If the source files are in a location other than a compact disc," & chr(10)
	msg = msg + "click Cancel and enter the path to that location." & chr(10)
	resp=Msgbox(msg, vbokcancel)
loop

Do until resp1 = vbcancel
	ttl = "1572c Automated Setup"
	msg1 = "Please enter the path to the LAUNCH.EXE for Microsoft Exchange 2000 Enterprise Edition"
	loc = inputbox(msg1,ttl)
	if right(loc,1)<>"\" then
		loc1 = loc + "\"
	end if
	if fso.FileExists(loc & "\setup\i386\exsetdata.dll") then
		Set ts = fso.CreateTextFile("c:\tools\copyexchange.vbs", True)
		ts.WriteLine "Set oSHApp = CreateObject(" & chr(34) & "Shell.Application" & chr(34) & ")" 
		ts.writeline "sSrc = " & chr(34) & loc1 & "*.*" & chr(34)
		ts.writeline "sDest = " & chr(34) & "d:\exchange" & chr(34)
		ts.writeline "oSHApp.Namespace(sDest).CopyHere sSrc, &H10&"
		ts.writeline "WScript.Quit"
		ts.Close
		WshShell.run "c:\tools\copyexchange.vbs", 1, true
		wscript.quit
		else
		msg2 = "This location does not appear to contain the source files for Exchange 2000" & chr(10) & chr(10)
		msg2 = msg2 + "To enter a new path click OK. Ensure that the path entered is the path" & chr(10) 
		msg2 = msg2 + "to Launch.exe on the Exchange 2000 CD." & chr(10) & chr(10) 
		msg2 = msg2 + "To cancel and copy files manually after the instructor computer setup" & chr(10)
		msg2 = msg2 + "has completed, click Cancel" & chr(10)
		resp1 = msgbox(msg2, vbokcancel)
	end if
Loop
wscript.quit