Set WshShell = WScript.CreateObject("WScript.Shell")
wshshell.regwrite "HKLM\SYSTEM\ControlSet001\Services\RemoteAccess\Start", 3, "REG_DWORD"
wshshell.regwrite "HKLM\SYSTEM\CurrentControlSet\Services\RemoteAccess\Start", 3, "REG_DWORD"