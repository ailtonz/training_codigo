'============================================================
On Error Resume Next

Set objSvc = GetObject("WinMgmts:")
Set objObject = objSvc.Get("NoSuchClass")
if Err = 0 Then
WScript.Echo "Got the class"
Else
'=============================================================
'Caregar informa��es sobre o �ltimo erro ocorrido antes 
'deste ponto no c�digo
set objObject = CreateObject("WbemScripting.SWbemLastError")
Set oPropSet = objObject.properties_
For Each oProp in oPropset
strLastError = strLastError & oProp.name & ": " & _
oProp.value & vbcrlf
Next

strErr = "Source: " & Err.Source & vbcrlf
strErr = strErr & "Description: "& Err.Description & vbcrlf
strErr = strErr & "Number: 0x" & Hex(Err.Number) & vbcrlf
MsgBox strErr,vbInformation,"From Err Object"
MsgBox strLastError,vbCritical,"From Last Error Object"
End If
