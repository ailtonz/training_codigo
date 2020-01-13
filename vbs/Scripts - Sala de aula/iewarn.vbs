' ietext.vbs
'
' This script configures Internet Explorer for optimal presentation.
' It sets the following defaults:
'	Text Size: Larger

set wshshell = wscript.CreateObject("wscript.shell")

WshShell.RegWrite "HKCU\Software\Microsoft\Internet Explorer\International\Scripts\3\IEFontSize", 3 ,"REG_BINARY"

