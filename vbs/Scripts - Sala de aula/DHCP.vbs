dim wshShell

Set WshShell = WScript.CreateObject("WScript.Shell")

wshShell.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultDomainName", "NWTRADERS" , "REG_SZ"
wshShell.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultUserName", "Administrator", "REG_SZ"
wshShell.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultPassword", "password", "REG_SZ"
     