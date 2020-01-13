Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegWrite "HKLM\Software\Microsoft\Windows\CurrentVersion\Setup\OC Manager\Subcomponents\DNS", 0 ,"REG_DWORD"
