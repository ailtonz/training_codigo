On error resume next
set fso = createobject("scripting.filesystemobject")
set WshShell = wscript.CreateObject("wscript.shell")
set IPConfigSet = GetObject("winmgmts:").ExecQuery _
		("select IPAddress from Win32_NetworkAdapterConfiguration where IPEnabled=TRUE")

for each IPConfig in IPConfigSet
	if Not IsNull(IPConfig.IPAddress) then 
		for i=LBound(IPConfig.IPAddress) to UBound(IPConfig.IPAddress)
						IP = IPConfig.IPAddress(i)
		
		next
		ipsub = left(ip,9)
		nt = left(ip,3)
		clsrm = right(ipsub,1)
		if nt = "192" then
			exit for
		end if
	end if
next

set f = fso.GetFile("c:\tools\msisaund.ini")
f.Copy ("c:\")
set fl = fso.opentextfile("c:\msisaund.ini", 8)
ln = "Range1 = " & ipsub & ".0 " & ipsub & ".255"
fl.WriteLine ln
fl.Close
cmd = "d:\isa2000\isa\setup /k" & chr(34) & "8804486634" & chr(34) & " /q1"
wshshell.Run cmd, 1, true
