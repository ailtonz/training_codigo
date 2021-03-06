ON ERROR RESUME NEXT
dim fso, d, dc, dl, run
set wshshell=wscript.CreateObject("Wscript.Shell")
set fso = CreateObject("Scripting.FileSystemObject")
set dc = fso.drives

' Separate paths with a coma (,)
pathSet = Array("","\PPTVIEW")

' file to look for
lookfile = "\ppview97.exe"

valid = false

' check each drive
For each d in dc
    set dl = fso.GetDrive(d)
    ' check each possible path
    For each path in pathSet
 		lookfor=dl & path & lookfile
    	if dl.IsReady then
        	if (fso.FileExists(lookfor)) then
        		valid = true
        		extractFiles(lookfor)
        	end if
    	End If
    Next
Next

if valid = false then
	Msgbox "Could not find the file ""PPView97.Exe""", vbCritical,"Error"
End If



sub extractFiles(myfile)
	WshShell.run myfile & " /auto", 1, true
	wshshell.run "%temp%\setup.exe /q1",6, true
	wscript.quit
end sub