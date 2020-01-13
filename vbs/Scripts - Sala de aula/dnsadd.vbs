set wshshell = CreateObject("Wscript.Shell")
set oNet = CreateObject("Wscript.Network")
set fso = CreateObject("Scripting.FileSystemObject")

' get full path of the script location
mydir = wscript.ScriptFullName 

' strip off the file name
loc = instr(mydir, wscript.ScriptName)
mydir = left(mydir, loc-1)

' set working directory to script location
wshshell.currentDirectory = mydir

' server = Array ("vancouver", "perth",    "lisbon", "lima",     "bangalore", "casablanca", "acapulco", "auckland", "stockholm", "caracas",    "manila", "khartoum")
' partner = Array("denver",    "brisbane", "bonn",   "santiago", "singapore", "tunis",      "miami",    "suva",     "moscow",    "montevideo", "tokyo",  "nairobi")
' partnerIP = Array("50", 	 "66", 		 "82", 	   "98", 	   "114", 		"130", 		  "146", 	  "162", 	  "178", 	   "194", 		 "210",    "226")

' get info for dhcp server and scope
Call GetServerAndScope(serverIP, scopeIP, classroom)

compname = lcase(oNet.ComputerName)

' partname = ""
' for i = 0 to ubound(server)
' 	if server(i) = compname then
' 		partname = partner(i)
' 		partIP = partnerIP(i)
' 		exit for
' 	end if
' next
' if partname = "" then
' 	wscript.Echo "This script must be run on the Server machine."
' 	wscript.Quit 
' end if

clientIP = "192.168." & classroom & "." & partIP


call DNSZoneProperties()
'call DNSinDHCP()




Private Function DNSZoneProperties()
	'wshshell.Run "dnscmd.exe /config ..AllZones /AllowUpdate 0", 6, true
	'Delete client record
	'wshshell.Run "dnscmd.exe /recorddelete " & compname & ".nwtraders.msft " & partname & " A " & clientIP & " /f", 6, true
	'Delete secondary zone
	wshshell.Run "dnscmd.exe /zonedelete nwtraders.msft /f", 6, true
End Function


Private Function DNSinDHCP()
	wshshell.Run "1.cmd " & serverIP, 6, true
End Function



Private Function IPAdd(ip, n)
	temp = split(ip,".")
	if ubound(temp) <> 3 then
		IPAdd = false
	else
		temp(3) = temp(3) + n
		if temp(3) > 255 then
			IPAdd = false
		else	' build the new IP addy
			ip = temp(0) & "." & temp(1) & "." & temp(2) & "." & temp(3)
			IPAdd = true
		end if
	end if
End Function


Private Function GetServerAndScope(serverIP, scopeIP, clsrmNum)

	set osvc = getobject("winmgmts:root\cimv2")
	
	for each onic in osvc.execquery( _
	            "select * from win32_networkadapter where " & _
	            "netconnectionid = 'Partner Local Area Connection'")
	
	            set oniccfg = osvc.get( _
	                        "win32_networkadapterconfiguration=" & onic.index)
	
	            ip = join(oniccfg.ipaddress,",")
	next
	
	serverIP = ip
 	ip = split(ip,".")
 	if ubound(ip) <> 3 then
 		GetServerAndScope = false
 	else
 		scopeIP = ip(0) & "." & ip(1) & "." & ip(2) & "." & ip(3)-1
 		clsrmNum = ip(2)
 		GetServerAndScope = true
 	end if 
End Function