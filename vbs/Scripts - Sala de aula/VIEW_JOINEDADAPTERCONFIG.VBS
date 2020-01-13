Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegWrite "HKCU\Control Panel\Desktop\PaintDesktopVersion", 0 ,"REG_DWORD"