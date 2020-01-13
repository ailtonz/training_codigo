' enablerd.vbs
'
' This script enables Remote Desktop on the machine.

set wshshell = wscript.CreateObject("wscript.shell")

'Setting remote desktop
WshShell.RegWrite "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\fDenyTSConnections", 0 ,"REG_DWORD"
