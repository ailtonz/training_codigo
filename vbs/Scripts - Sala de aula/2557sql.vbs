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
WshShell.Run "%SystemRoot%\System32\inetsrv\iis.msc"
wscript.sleep 3000
WshShell.SendKeys "{DOWN}"
WshShell.SendKeys "{RIGHT}"
wscript.sleep 1000
WshShell.SendKeys "{DOWN}"
WshShell.SendKeys "{RIGHT}"
wscript.sleep 1000
WshShell.SendKeys "{DOWN}"
WshShell.SendKeys "{RIGHT}"
wscript.sleep 1000
WshShell.SendKeys "%a"
wscript.sleep 1000
WshShell.SendKeys "n"
wscript.sleep 1000
WshShell.SendKeys "v"
wscript.sleep 3000
WshShell.SendKeys "{ENTER}"
wscript.sleep 1000
WshShell.SendKeys "Woodgrove"
wscript.sleep 1000
WshShell.SendKeys "{ENTER}"
wscript.sleep 1000
WshShell.SendKeys "c:\Program Files\Msdntrain\2524\Labfiles\VB\WebServicesSolution\Woodgrove"
wscript.sleep 1000
WshShell.SendKeys "{ENTER}"
WshShell.SendKeys "%o"
wscript.sleep 1000
WshShell.SendKeys "{ENTER}"
wscript.sleep 1000
WshShell.SendKeys "{ENTER}"

wscript.sleep 3000
WshShell.SendKeys "d"
wscript.sleep 1000
WshShell.SendKeys "d"
wscript.sleep 1000

wscript.sleep 3000
WshShell.SendKeys "%a"
wscript.sleep 1000
WshShell.SendKeys "n"
WshShell.SendKeys "v"
wscript.sleep 3000
WshShell.SendKeys "{ENTER}"
wscript.sleep 1000
WshShell.SendKeys "Contoso"
wscript.sleep 1000
WshShell.SendKeys "{ENTER}"
wscript.sleep 1000
WshShell.SendKeys "c:\Program Files\Msdntrain\2524\Labfiles\VB\WebServicesSolution\contoso"
wscript.sleep 1000
WshShell.SendKeys "{ENTER}"
WshShell.SendKeys "%o"
wscript.sleep 1000
WshShell.SendKeys "{ENTER}"
wscript.sleep 1000
WshShell.SendKeys "{ENTER}"

wscript.sleep 3000
WshShell.SendKeys "d"
WshShell.SendKeys "d"
wscript.sleep 1000

wscript.sleep 3000
WshShell.SendKeys "%a"
wscript.sleep 1000
WshShell.SendKeys "n"
WshShell.SendKeys "v"
wscript.sleep 3000
WshShell.SendKeys "{ENTER}"
wscript.sleep 1000
WshShell.SendKeys "Northwind"
wscript.sleep 1000
WshShell.SendKeys "{ENTER}"
wscript.sleep 1000
WshShell.SendKeys "c:\Program Files\Msdntrain\2524\Labfiles\VB\WebServicesSolution\Northwind"
wscript.sleep 1000
WshShell.SendKeys "{ENTER}"
WshShell.SendKeys "%o"
wscript.sleep 1000
WshShell.SendKeys "{ENTER}"
wscript.sleep 1000
WshShell.SendKeys "{ENTER}"


