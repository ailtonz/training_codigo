On Error Resume Next
Set WshShell = WScript.CreateObject("WScript.Shell")
vLimit = InputBox("Enter how many times to loop ")
For i = 1 to vLimit
	WshShell.LogEvent 1, "The Test Command Failed"
	WshShell.LogEvent 2, "The Operation is taking too long"
	WshShell.LogEvent 4, "Your hard disk needs de-fragmenting"
	If err<>0 Then
		wscript.echo "Something went wrong on pass # " & i
	End If
Next
wscript.echo 3*i & " Events were written to the Application Log"
wscript.quit