option explicit
on error resume next
dim mantis, wshshell

mantis= "\\london\setup\winsrc"

Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegWrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SourcePath", mantis ,"REG_SZ"


Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegWrite "HKLM\Software\Microsoft\Windows\CurrentVersion\SourcePath", mantis ,"REG_SZ"


Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegDelete "HKLM\Software\Microsoft\Windows\CurrentVersion\InstallationSources\"


Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegWrite "HKLM\Software\Microsoft\Windows\CurrentVersion\ServicePackSourcePath", mantis ,"REG_SZ"







Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegWrite "HKLM\Software\Microsoft\Windows\CurrentVersion\Setup\SourcePath", mantis ,"REG_SZ"


Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegDelete "HKLM\Software\Microsoft\Windows\CurrentVersion\Setup\Installation Sources"


Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegWrite "HKLM\Software\Microsoft\Windows\CurrentVersion\Setup\ServicePackSourcePath", mantis ,"REG_SZ"