set IPConfigSet = GetObject("winmgmts:").ExecQuery _
		("select IPAddress from Win32_NetworkAdapterConfiguration where IPEnabled=TRUE")

for each IPConfig in IPConfigSet
	if Not IsNull(IPConfig.IPAddress) then 
		for i=LBound(IPConfig.IPAddress) to UBound(IPConfig.IPAddress)
						
	if left(IPConfig.IPAddress(i),3) = "192" then
bob = IPConfig.IPAddress(i)
		end if
next
	end if
next



mantis = left(bob,9)
classroom = right(mantis,1)

bob = "c:\tools\dnscmd /zoneadd " & classroom & ".168.192.in-addr.arpa /primary /file " & classroom & ".168.192.in-addr.arpa "
Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.run bob, 6, true

bob = "c:\tools\dnscmd /config ..AllZones AllowUpdate 1"
Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.run bob, 6, true