on error resume next
set wshshell = wscript.CreateObject("wscript.shell")
set fso = createobject("scripting.filesystemobject")
set IPConfigSet = GetObject("winmgmts:").ExecQuery _
		("select IPAddress from Win32_NetworkAdapterConfiguration where DHCPEnabled=FALSE")
for each IPConfig in IPConfigSet
	if Not IsNull(IPConfig.IPAddress) then 
		for j=LBound(IPConfig.IPAddress) to UBound(IPConfig.IPAddress)
			IP = IPConfig.IPAddress(j)

		next
	end if
next
ipsub = left(ip,9)
clsrm = right(ipsub,1)
cmd = "c:\tools\dnscmd london /zoneadd " & clsrm & ".168.192.in-addr.arpa /primary /file " & clsrm & ".168.192.in-addr.arpa.dns"
wshshell.Run cmd, 6, true
cmd = "c:\tools\dnscmd.exe London /config ..AllZones /AllowUpdate 0x1"
wshshell.run cmd, 6, true
