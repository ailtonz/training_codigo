'on error resume next
set wshshell = wscript.createobject("wscript.shell")
Set IPConfigSet = GetObject("winmgmts:").ExecQuery ("select IPAddress,SettingID from Win32_NetworkAdapterConfiguration where DHCPEnabled=FALSE")
for each j in IpConfigSet
	if Not IsNull(j.ipaddress) then
		x = j.ipaddress(i)
		if right(x,3) = "201" then
			exit for
		end if
	end if
next
y=j.settingid(i)
wshshell.run "c:\tools\reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\" & y & " /v NameServer /t REG_SZ /d 192.168.222.200 /f" 'reg entry to set DNS