dim fso, d, dc, dl, run
set wshshell=wscript.createobject("wscript.shell")
set fso = CreateObject("Scripting.FileSystemObject")
set dc = fso.drives
do until resp=vbcancel
    For each d in dc
        set dl = fso.getdrive(d)
        lookfor=dl & "\msdn332.inf"
        if dl.isready then
            if (fso.FileExists(lookfor)) then
                Set ts = fso.CreateTextFile("c:\tools\cpymsdn2.vbs", True)
                ts.WriteLine "Set oSHApp = CreateObject(" & chr(34) & "Shell.Application" & chr(34) & ")" 
                ts.writeline "sSrc = " & chr(34) & dl & "\*.*" & chr(34)
                ts.writeline "sDest = " & chr(34) & "d:\msdn" & chr(34)
                ts.writeline "oSHApp.Namespace(sDest).CopyHere sSrc, &H10&"
                ts.writeline "Set oSHApp = nothing"
                ts.writeline "WScript.Quit"
                ts.Close
                WshShell.run "c:\tools\cpymsdn2.vbs", 1, true
                wscript.quit
            end if
        End If
    Next

    resp=Msgbox ("Please insert the MSDN Disk 2 compact disc into the CD drive." & CHR(10) & "After you have inserted the CD, click OK. If the MSDN Setup Screen should appear, click Exit.", vbOKCancel or vbinformation)
loop


msgbox "Setup cannot copy the MSDN files. After the automated setup finishes, " & chr(10) & _
       "complete the installation of the instructor computer by following the instructions " & chr(10) & _
       "for installing MSDN in the automated setup guide.", vbcritical
wscript.quit

