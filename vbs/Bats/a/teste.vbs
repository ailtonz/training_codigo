Set objNet = WScript.CreateObject("WScript.Network")
savename = objNet.ComputerName

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
mantis= right(mantis,1)



Set objNet = WScript.CreateObject("WScript.Network")


set WshShell = CreateObject("WScript.Shell")
wscript.sleep 1000
WshShell.SendKeys "%{TAB}"
wscript.sleep 1000
WshShell.SendKeys "%{n}"
wscript.sleep 3000
WshShell.SendKeys "%{a}"
wscript.sleep 3000
WshShell.SendKeys "{ENTER}"
wscript.sleep 3000
WshShell.SendKeys "Q2XV6 VK7F6 6P47R FBVVP Q4DY8"
WshShell.SendKeys "{ENTER}"
wscript.sleep 3000
WshShell.SendKeys "{ENTER}"
wscript.sleep 3000
WshShell.SendKeys "{ENTER}"

