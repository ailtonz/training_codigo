Set WshShell = WScript.CreateObject("WScript.Shell")
Set objNet = WScript.CreateObject("WScript.Network")

CompName = objNet.ComputerName 
CompName = lcase(CompName)
NameArr = Split(CompName, "-")

'Set domain controllers to log into nwtraders domain
if NameArr(1) = "pf1" then
	WshShell.RegWrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultDomainName", "nwtraders" ,"REG_SZ"
end if

'Set member servers to log into local domain
If CompName = "van-mbx1" or CompName = "van-fe1" or CompName = "van-fe2" then
   WshShell.RegWrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultDomainName", "namerica" ,"REG_SZ"
End if


If CompName = "lim-mbx1" or CompName = "lim-fe1" or CompName = "lim-fe2" then
   WshShell.RegWrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultDomainName", "samerica" ,"REG_SZ"
End if


If CompName = "par-mbx1" or CompName = "par-fe1" or CompName = "par-fe2" then
   WshShell.RegWrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultDomainName", "europe" ,"REG_SZ"
End if


If CompName = "cap-mbx1" or CompName = "cap-fe1" or CompName = "cap-fe2" then
   WshShell.RegWrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultDomainName", "africa" ,"REG_SZ"
End if


If CompName = "mos-mbx1" or CompName = "mos-fe1" or CompName = "mos-fe2" then
   WshShell.RegWrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultDomainName", "asia" ,"REG_SZ"
End if


If CompName = "can-mbx1" or CompName = "can-fe1" or CompName = "can-fe2" then
   WshShell.RegWrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultDomainName", "spacific" ,"REG_SZ"
End if