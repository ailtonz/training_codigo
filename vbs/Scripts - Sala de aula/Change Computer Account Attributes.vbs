On Error Resume Next
Set objSvc = GetObject("winmgmts:")
Const wbemErrTimedout = -2147209215
Set objEventSource = objSvc.ExecNotificationQuery("SELECT * FROM __InstanceCreationEvent WITHIN 2 WHERE TargetInstance ISA 'Win32_PrintJob'AND TargetInstance.size >10000")
Wscript.Echo "Start now...."
Set objEvent = objEventSource.NextEvent(30000)
If Err <> 0 Then
    If Err.Number = wbemErrTimedout Then     
        MsgBox ("There were no events")
    Else
         MsgBox (Err.Number & " " & Err.Description)
    End If
Else
	wscript.echo objEvent.targetInstance.owner & " has printed " & objEvent.targetInstance.document & " with size " & objEvent.targetInstance.size
End If
WScript.quit