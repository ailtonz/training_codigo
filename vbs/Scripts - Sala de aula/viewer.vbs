On Error Resume Next
Set objSvc = GetObject("WinMgmts:\root\CourseWork")
Set objNICSet = objSvc.ExecQuery("Select * from joinedAdapterConfig") 
If Err <> 0 or objNICSet.count=0 Then
	Wscript.Echo "Something went wrong " & Hex(err.number), err.description, err,source
End If
For Each objNIC in objNICSet
	strNIC = 	strNIC & _ 
			"--------------------------------------------------------" & vbcrlf & _
			objNIC.system & vbcrlf & _
			"--------------------------------------------------------" & vbcrlf & _
			space(10) & "MAC:          " & objNIC.mac & vbcrlf & _
			space(10) & "Last Reset:   " & convertDT(objNIC.LastReset) & vbcrlf & _
			space(10) & "DHCP Enabled: " & objNIC.dhcpON & vbcrlf & _
			space(10) & "DHCP Expires: " & convertDT(objNIC.dhcpExpires) & vbcrlf
Next
Wscript.echo strNIC
wscript.Quit
' --------------------------- Functions below this line ------------------------------------
'	DMTF Date Time format converter
Function convertDT(vdateTime)
	vYear 	= Mid(vDateTime,1,4)
	vMonth 	= Mid(vDateTime,5,2)
	vDay 	= Mid(vDateTime,7,2)
	vHour 	= Mid(vDateTime,9,2)
	vMin 	= Mid(vDateTime,11,2)
	vSec 	= Mid(vDateTime,13,2)
	vMsec 	= Mid(vDateTime,15,6)
	vOffset = Mid(vDateTime,23,3)
	convertDT = vDay &"/"& vMonth &"/"&  vYear &" : "& vHour &":"& vMin &":"& vSec 
End Function 