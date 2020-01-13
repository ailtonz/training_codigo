dim sPath, WshShell
Dim oSked, oPort, sUrl

sPath = WScript.ScriptFullName
sPath = Mid(sPath, 1, InStrRev(sPath, "\"))
sUrl = "sked:///" & sPath & "DispatchApp.skx"
Set oSked = GetObject(sUrl)
msgbox "Started DispatchApp"
