'on error resume next
set wshshell = wscript.createobject("wscript.shell")
Set IPConfigSet = GetObject("winmgmts:").ExecQuery ("select IPAddress,SettingID from Win32_NetworkAdapterConfiguration where DHCPEnabled=FALSE")
for each j in IpConfigSet
	if Not IsNull(j.ipaddress) then
		x = j.ipaddress(i)
		if right(x,3) = "200" then
			exit for
		end if
	end if
next
y=j.settingid(i)
wshshell.run "c:\tools\reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\" & y & " /v EnableDHCP /t REG_DWORD /d 0 /f" 'reg entry disabling DHCP
wshshell.run "c:\tools\reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\" & y & " /v SubnetMask /t REG_MULTI_SZ /d 255.255.255.0 /f" 'reg entry setting subnet mask
wshshell.run "c:\tools\reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\" & y & " /v NameServer /t REG_SZ /d 192.168.222.200 /f" 'reg entry to set DNS
wshshell.run "c:\tools\reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\" & y & " /v IPAddress /t REG_MULTI_SZ /d 192.168.222.200 /f" 'reg entry to set ip address
wshshell.run "c:\tools\reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\" & y & " /v DefaultGateway /t REG_MULTI_SZ /d 192.168.222.201 /f" 'reg entry to set gateway
wshshell.run "c:\tools\reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\" & y & " /v DefaultGatewayMetric /t REG_MULTI_SZ /d 1 /f" 'reg entry to set gateway