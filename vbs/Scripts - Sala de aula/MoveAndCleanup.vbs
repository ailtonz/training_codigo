On Error Resume Next
Set objSvc = GetObject("winmgmts:")
Set obj = objSvc.Get("Win32_LogicalDisk.DeviceId='C:'") 
	WScript.Echo "Volume Name before: " & obj.VolumeName 
	obj.VolumeName="System"
	obj.Put_
	if Err <> 0 Then
		WScript.Echo "Failed to change volume name"
	Else
		Wscript.Echo "Volume Name after: " & obj.VolumeName
	End if
wscript.quit

