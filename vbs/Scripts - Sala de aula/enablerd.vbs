Set objSvc = GetObject("winmgmts:")
Set obj = objSvc.Get("Win32_NetworkAdapterConfiguration.index=0")

RetVal = obj.EnableDHCP()

if RetVal = 0 then 
	WScript.Echo "DHCP Enabled"
else 
	WScript.Echo "DHCP enable failed"
end if
