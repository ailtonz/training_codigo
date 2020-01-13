'=============================================================================
'
' script for reading DS properties
'
' usage: cscript dsprop.vbs <DS object LDAP path> <property1> [<property2>...]
'
'=============================================================================
On Error Resume Next

Set sArgs = WScript.Arguments

If sArgs.Count < 2 Then 
    wscript.echo "Parameters: cscript dsprop.vbs <object LDAP path>" + " <property1> [<property2> ...]"
    wscript.echo "Example: cscript dsprop.vbs LDAP://OU=test,DC=testdomain,DC=com whenCreated whenChanged"
    wscript.quit(1)
End If

container = wScript.Arguments(0)

err.Clear
Set obj = GetObject(container)
Call ExitOnError("GetObject for " & container)

for countprop = 1 to sArgs.Count-1
    propname = wScript.Arguments(countprop)
    err.Clear
    propval = obj.Get(propname)
    Call ExitOnError("Get for " & propname & " property")
    wscript.echo propname & "=" & propval
next

'=============================================================================
' on error, dump error message and exit
'=============================================================================
Sub ExitOnError(failedCall)

    if err.number <> 0 then
        wscript.echo "Error " & Hex(err.number) & " calling " & failedCall & " - " & err.description
        wscript.quit(1)
    end if

End Sub
