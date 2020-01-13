Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup\SourcePath", "C:\setup\Winsrc" ,"REG_SZ"
