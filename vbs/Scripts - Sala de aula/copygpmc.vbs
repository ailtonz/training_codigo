on error resume next
dim fso, d, dc, dl, run
set wshshell=wscript.createobject("wscript.shell")
set fso = CreateObject("Scripting.FileSystemObject")
set dc = fso.drives
fso.CreateFolder("d:\fp2000")
wshshell.Run "net share fp2000=d:\fp2000", 6, true
do until resp=vbcancel
	For each d in dc
		set dl = fso.getdrive(d)
		lookfor=dl & "\studentCD\FP2000\FPSE.MSI"
		if dl.isready then
			if (fso.FileExists(lookfor)) then
				Set ts = fso.CreateTextFile("c:\tools\fpcopy.vbs", True)
				ts.WriteLine "Set oSHApp = CreateObject(" & chr(34) & "Shell.Application" & chr(34) & ")" 
				ts.writeline "sSrc = " & chr(34) & dl & "\studentCD\FP2000\*.*" & chr(34)
				ts.writeline "sDest = " & chr(34) & "d:\FP2000" & chr(34)
				ts.writeline "oSHApp.Namespace(sDest).CopyHere sSrc, &H10&"
				ts.writeline "WScript.Quit"
				ts.Close
				WshShell.run "c:\tools\fpcopy.vbs", 1, true
				wscript.quit
			end if
		end If
	Next
	resp=Msgbox ("Please insert the 2295a Trainer Materials compact disc into the CD drive" & CHR(10) & "After you have inserted the CD, click OK.", vbOKCancel)
loop
msgbox "Setup cannot copy FrontPage files. After the automated setup finishes complete the " & chr(10) & "installation of the instructor computer by copying the entire" & chr(10) & "contents of the \studentCD\fp2000 folder on the Trainer Materials Compact Disc to D:\FP2000." 
wscript.quit