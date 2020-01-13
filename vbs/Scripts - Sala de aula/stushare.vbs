' STUNIC2.VBS
'
' Configures the second network adapter for the student machines

set wshshell = wscript.CreateObject("wscript.shell")

LACName = "Partner Network Connection"	'name of the Local Area Connection to modify
classroom = getclsrm


set onet   = CreateObject("wscript.network")
cname      = ucase(onet.ComputerName)

' now make it lowercase
lcname  = LCase(cname)

'set Ip Address and Subnet Mask
Select  Case lcname
	Case "vancouver"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.101.1 mask=255.255.255.0", 0, true
	Case "denver"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.101.2 mask=255.255.255.0", 0, true
	Case "perth"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.102.1 mask=255.255.255.0", 0, true
	Case "brisbane"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.102.2 mask=255.255.255.0", 0, true
	Case "lisbon"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.103.1 mask=255.255.255.0", 0, true
	Case "bonn"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.103.2 mask=255.255.255.0", 0, true
	Case "lima"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.104.1 mask=255.255.255.0", 0, true
	Case "santiago"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.104.2 mask=255.255.255.0", 0, true
	Case "bangalore"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.105.1 mask=255.255.255.0", 0, true
	Case "singapore"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.105.2 mask=255.255.255.0", 0, true
	Case "casablanca"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.106.1 mask=255.255.255.0", 0, true
	Case "tunis"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.106.2 mask=255.255.255.0", 0, true
	Case "acapulco"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.107.1 mask=255.255.255.0", 0, true
	Case "miami"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.107.2 mask=255.255.255.0", 0, true
	Case "auckland"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.108.1 mask=255.255.255.0", 0, true
	Case "suva"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.108.2 mask=255.255.255.0", 0, true
	Case "stockholm"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.109.1 mask=255.255.255.0", 0, true
	Case "moscow"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.109.2 mask=255.255.255.0", 0, true
	Case "caracas"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.110.1 mask=255.255.255.0", 0, true
	Case "montevideo"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.110.2 mask=255.255.255.0", 0, true
	Case "manila"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.111.1 mask=255.255.255.0", 0, true
	Case "tokyo"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.111.2 mask=255.255.255.0", 0, true
	Case "khartoum"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.112.1 mask=255.255.255.0", 0, true
	Case "nairobi"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168.112.2 mask=255.255.255.0", 0, true
	Case Else
		wscript.Echo "Problem in stunic2.vbs... the computer name did not match the any of the expected student computer names.  As a result, we could not configure the second network card."
end select

'set Preferred DNS Server
wshshell.Run "netsh interface ip set dns name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".200 register=PRIMARY", 0, true

'set WINS Server
wshshell.Run "netsh interface ip set wins name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".200", 0, true

'set DNS Suffix for the connection
ipg = IPguid
If ipg <> "0" then
	wshshell.run "c:\moc\setup\reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\" & ipg & " /v Domain /t REG_SZ /d nwtraders.msft /f" 'reg entry to set DNS suffix
End If


private function getclsrm
	set fso = createobject("scripting.filesystemobject")
	set fl = fso.OpenTextFile ("c:\moc\setup\mocset\mocset2.cmd")
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
            addr = IPConfig.IPAddress(i)
            If Left(addr, 7) = "192.168" then
               thirdPeriodPos = InStrRev(addr, ".")
               secondPeriodPos = InStrRev(addr, ".", thirdPeriodPos - 1)
	       thirdquadofip = Mid(addr, secondPeriodPos + 1, thirdPeriodPos - secondPeriodPos - 1)
	       If (thirdquadofip >= "101" And thirdquadofip <= "112") Then
                  IPGuid = IPConfig.settingID(i)
               End If
	    End If
         Next
      End If
   Next
End Function