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


if objNet.ComputerName="VANCOUVER" then
bob = "1"
fred = "1"
end if

if objNet.ComputerName="DENVER" then
bob = "1"
fred = "2"
end if

if objNet.ComputerName="ACAPULCO" then
bob = "1"
fred = "13"
end if

if objNet.ComputerName="MIAMI" then
bob = "1"
fred = "14"
end if

if objNet.ComputerName="LISBON" then
bob = "1"
fred = "5"
end if

if objNet.ComputerName="BONN" then
bob = "1"
fred = "6"
end if

if objNet.ComputerName="STOCKHOLM" then
bob = "1"
fred = "17"
end if

if objNet.ComputerName="MOSCOW" then
bob = "1"
fred = "18"
end if

if objNet.ComputerName="BANGALORE" then
bob = "1"
fred = "9"
end if


if objNet.ComputerName="SINGAPORE" then
bob = "1"
fred = "10"
end if


if objNet.ComputerName="MANILA" then
bob = "1"
fred = "21"
end if

if objNet.ComputerName="TOKYO" then
bob = "1"
fred = "22"
end if

if objNet.ComputerName="PERTH" then
bob = "1"
fred = "3"
end if

if objNet.ComputerName="BRISBANE" then
bob = "1"
fred = "4"
end if

if objNet.ComputerName="AUCKLAND" then
bob = "1"
fred = "15"
end if

if objNet.ComputerName="SUVA" then
bob = "1"
fred = "16"
end if

if objNet.ComputerName="LIMA" then
bob = "1"
fred = "7"
end if

if objNet.ComputerName="SANTIAGO" then
bob = "1"
fred = "8"
end if

if objNet.ComputerName="CARACAS" then
bob = "1"
fred = "19"
end if

if objNet.ComputerName="MONTEVIDEO" then
bob = "1"
fred = "20"
end if

if objNet.ComputerName="CASABLANCA" then
bob = "1"
fred = "11"
end if

if objNet.ComputerName="TUNIS" then
bob = "1"
fred = "12"
end if

if objNet.ComputerName="KHARTOUM" then
bob = "1"
fred = "23"
end if

if objNet.ComputerName="NAIROBI" then
bob = "1"
fred = "24"
end if




set WshShell = CreateObject("WScript.Shell")
WshShell.Run "control ncpa.cpl"
wscript.sleep 1000
WshShell.AppActivate "Network"
wscript.sleep 1000
WshShell.SendKeys "{TAB}"
WshShell.SendKeys "{TAB}"
WshShell.SendKeys "{TAB}"
WshShell.SendKeys "{TAB}"
WshShell.SendKeys "{RIGHT}"
WshShell.SendKeys "+{F10}"
WshShell.SendKeys "r"
wscript.sleep 1000
WshShell.AppActivate "Local"
WshShell.SendKeys "{DOWN}"
WshShell.SendKeys "{DOWN}"
WshShell.SendKeys "{DOWN}"
WshShell.SendKeys "%r"
wscript.sleep 1000
WshShell.AppActivate "Internet"
WshShell.SendKeys "{DOWN}"
WshShell.SendKeys "192168"
WshShell.SendKeys bob
WshShell.SendKeys "{RIGHT}"
WshShell.SendKeys fred
WshShell.SendKeys "{TAB}"
WshShell.SendKeys "{TAB}"
WshShell.SendKeys "{TAB}"
WshShell.SendKeys "{TAB}"
wshShell.SendKeys "192168"
WshShell.SendKeys "1"
WshShell.SendKeys "{RIGHT}"
WshShell.sendKeys "200"
WshShell.SendKeys "{TAB}"
WshShell.SendKeys "{TAB}"
WshShell.SendKeys "{TAB}"

WshShell.SendKeys "{ENTER}"
wscript.sleep 1000
WshShell.AppActivate "Local"
WshShell.SendKeys "{TAB}"
WshShell.SendKeys "{TAB}"
WshShell.SendKeys "{TAB}"
WshShell.SendKeys "{TAB}"
WshShell.SendKeys "{TAB}"

wscript.sleep 1000
WshShell.SendKeys "{ENTER}"
WshShell.SendKeys "%{F4}"


