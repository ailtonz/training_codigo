dim fso, d, dc, dl, run
set wshshell=wscript.createobject("wscript.shell")
set fso = CreateObject("Scripting.FileSystemObject")
set dc = fso.drives
do until resp=vbcancel
For each d in dc
	set dl = fso.getdrive(d)
	lookfor=dl & "\smssqins.bat"
	if dl.isready then
	if (fso.FileExists(lookfor)) then
	Set ts = fso.CreateTextFile("c:\tools\copysql.vbs", True)
	ts.WriteLine "Set oSHApp = CreateObject(" & chr(34) & "Shell.Application" & chr(34) & ")" 
	ts.writeline "sSrc = " & chr(34) & dl & "\*.*" & chr(34)
	ts.writeline "sDest = " & chr(34) & "d:\sql" & chr(34)
	ts.writeline "oSHApp.Namespace(sDest).CopyHere sSrc, &H10&"
	ts.writeline "Set oSHApp = nothing"
	ts.writeline "WScript.Quit"
	ts.Close
	WshShell.run "c:\tools\sql.cmd", 6, true
	WshShell.run "c:\tools\copysql.vbs", 1, true
	wscript.quit
	end if
	End If
Next

resp=Msgbox ("Please insert the Microsoft SQL Server 2000 compact disc into the CD drive" & CHR(10) & "After you have inserted the CD, click OK. If the Microsoft SQL Server 2000 Setup Screen should appear, click Exit.", vbOKCancel)
loop


msgbox "Setup cannot copy SQL files. After the automated setup finishes complete the " & chr(10) & "installation of the instructor computer by following these instructions:" & chr(10) & "1. Create a folder named \SQL on the D drive" & chr(10) & "2. Share the folder with the share name of SQL" & chr(10) & "3. Copy the entire contents of the SQL 2000 CD to D:\SQL\" & chr(10) & "4. Run c:\setup\sql_ent.cmd to install SQL Server 2000" & chr(10) & "5. Run c:\setup\regset.cmd to make necessary registry changes" & chr(10) & "6. Reboot the computer" & chr(10) & "7. Run C:\moc\2071\Batches\Library\Bldlib.cmd" & chr(10) & "8. Continue with the setup of student computers" 
wscript.quit

