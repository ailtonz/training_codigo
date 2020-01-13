Set objSet = GetObject("winmgmts:root\snmp\localhost").ExecQuery("Select * From SNMP_RFC1213_MIB_ipRouteTable")
For Each obj in objSet
	strRoute = strRoute & "Destination: " & obj.ipRouteDest & _
				" NextHop: " & obj.ipRouteNextHop & _
				" Route Mask: " & obj.ipRouteMask & vbcrlf
Next
Wscript.echo strRoute