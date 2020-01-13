' CONFNIC2.VBS
'
' Configures the second network adapter

set wshshell = wscript.CreateObject("wscript.shell")

LACName = "Partner Network Connection"	'name of the Local Area Connection to modify
classroom = getclsrm


'set Ip Address and Subnet Mask
wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.100.1 mask=255.255.255.0", 0, true

'set Preferred DNS Server
wshshell.Run "netsh interface ip set dns name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".200 register=PRIMARY", 0, true

'set WINS Server
wshshell.Run "netsh interface ip set wins name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".200", 0, true

'set DNS Suffix for the connection
ipg = IPguid
If ipg <> "0" then
	wshshell.run "c:\tools\reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\" & ipg & " /v Domain /t REG_SZ /d nwtraders.msft /f" 'reg entry to set DNS suffix
End If


private function getclsrm
	set fso = createobject("scripting.filesystemobject")
	set fl = fso.OpenTextFile ("c:\setup\instruct\lonset2.cmd")
	while left (x,13) <> "set classroom"
		x = fl.readline
	wend
	fl.close
	rtrim x
	lgn = len(x)
	getclsrm = left(right(x,lgn-14),1)
end function


'Retrieves the GUID of the IP config info
Private Function IPGuid
   IPGuid = "0"

   Set IPConfigSet = GetObject("winmgmts:").ExecQuery ("select IPAddress, settingID from Win32_NetworkAdapterConfiguration where IPenabled=TRUE")

   For Each IPConfig in IPConfigSet
      If Not IsNull(IPConfig.IPAddress) then 
         For i = LBound(IPConfig.IPAddress) to UBound(IPConfig.IPAddress)
	    If IPConfig.IPAddress(i) = "192.168.100.1" Then
               IPGuid = IPConfig.settingID(i)
	    End If
         Next
      End If
   Next
End Function