Set objSvc = GetObject("winmgmts:")
Set obj = objSvc.Get("Win32_NetworkAdapterConfiguration.index=0")
ipaddr = Array("192.168.20.8")
subnet = Array("255.255.255.0")
'execute the EnableStatic method with the correct parameters
RetVal = obj.EnableStatic(ipAddr,subnet)

if RetVal = 0 then 
	WScript.Echo "DHCP disabled, using static IP address"
else 
	WScript.Echo "DHCP disable failed"
end if

