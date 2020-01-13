On Error Resume Next

Set objNet = WScript.CreateObject("WScript.Network")
sPrefix = "LDAP://" & objNet.UserDomain & "/"


 
'''''''''''''''''''''''''''''''''''''''
'Bind to a ds server
'''''''''''''''''''''''''''''''''''''''
Set IADsRootDSE = GetObject(sPrefix & "rootDSE")
If (Err.Number <> 0) Then
   BailOnFailure Err.Number, "on GetObject method"
   wscript.quit
End If
sDomain = IADsRootDSE.Get("defaultNamingContext")
If (Err.Number <> 0) Then
   BailOnFailure Err.Number, "on Get method"
   wscript.quit
End If
Set IADsDomain = GetObject(sPrefix & sDomain)
If (Err.Number <> 0) Then
   BailOnFailure Err.Number, "on GetObject method"
   wscript.quit
End If
 
'''''''''''''''''''''''''''''''''''''''
'Get ntMixedDomain property
'''''''''''''''''''''''''''''''''''''''

sMode = IADsDomain.Get("ntMixedDomain")
If (Err.Number <> 0) Then
   BailOnFailure Err.Number, "on Get ntMixedDomain property"
   wscript.quit
End If
'''''''''''''''''''''''''''''''''''''''
'Get name property
'''''''''''''''''''''''''''''''''''''''

sName = IADsDomain.Get("name")
If (Err.Number <> 0) Then
   BailOnFailure Err.Number, "on Get name property"
   wscript.quit
End If
 
If (sMode = 0) Then
   sModeString = "Native"
ElseIf (sMode = 1) Then
   sModeString = "Mixed"
Else
   BailOnFailure sMode, "Invalid ntMixedDomain value: " & sMode
   wscript.quit
End If
 

IADsDomain.Put "ntMixedDomain", 0
IADsDomain.setinfo


 

'''''''''''''''''''''''''''''''''''''''
'Display subroutines
'''''''''''''''''''''''''''''''''''''''
Sub show_groups(strText, strName)
End Sub
 
Sub BailOnFailure(ErrNum, ErrText)    strText = "Error 0x" & Hex(ErrNum) & " " & ErrText
    WScript.Quit
End Sub
