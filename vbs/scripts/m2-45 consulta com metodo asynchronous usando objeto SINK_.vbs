'============================================================
On Error Resume Next
For Each obj in GetObject("WinMgmts:").ExecQuery _
("Select * From Win32_NtLogEvent Where LogFile='System'",,48)
count = count + 1
Next
If Err<> 0 Then
Wscript.echo "Something went wrong"
End If
Wscript.echo count