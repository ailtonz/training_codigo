On Error Resume Next
Set objSvc = getObject("WinMgmts:")
'Warning: No white spaces permitted inside the {curly-brackets}
Set assocSet = objSvc.ExecQuery("References Of {Win32_Share.name='temp'}")

If Err <> 0 or assocSet.count=0 Then
	Wscript.Echo "Something went wrong " & Hex(err.number), err.description, err,source
End If
For Each assoc in assocSet
	strAssoc = strAssoc & assoc.Path_.RelPath & vbcrlf
Next
MsgBox strAssoc,vbInformation,"Associations of " & " Win32_Share"
