Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegWrite "HKCU\Software\Microsoft\Internet Connection Wizard\DesktopChanged", 000000001 ,"REG_DWORD"
WshShell.RegWrite "HKCU\Software\Microsoft\Internet Connection Wizard\Completed", 1 ,"REG_BINARY"
