Option Explicit
On Error Resume Next
dim wshshell
set wshshell = wscript.CreateObject("wscript.shell")
wshshell.regdelete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\2261"

response = msgbox("The fix for for VBScript 2261_01_01 has been successfully applied to your system.", vbOKOnly, "SUCCESS")
