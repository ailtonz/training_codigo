Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegWrite "HKLM\System\CurrentControlSet\Services\NTDS\Parameters\Schema Update Allowed", 1 ,"REG_DWORD"
