on error resume next
set wshshell = wscript.CreateObject("wscript.shell")
set IPConfigSet = GetObject("winmgmts:").ExecQuery _
		("select IPAddress from Win32_NetworkAdapterConfiguration where IPEnabled=TRUE")
set objnet = wscript.CreateObject("wscript.network")
compname = objnet.ComputerName
		
First = Array("VANCOUVER","PERTH","LISBON","LIMA","BANGALORE","CASABLANCA","ACAPULCO","AUCKLAND","STOCKHOLM","CARACAS","MANILA","KHARTOUM")
Replica = Array("DENVER","BRISBANE","BONN","SANTIAGO","SINGAPORE","TUNIS","MIAMI","SUVA","MOSCOW","MONTEVIDEO","TOKYO","NAIROBI")

For each i in Replica
	if compname = i then
		wscript.quit
	end if
next

For each i in First
	if compname = i then
		for each IPConfig in IPConfigSet
			if Not IsNull(IPConfig.IPAddress) then 
				for j=LBound(IPConfig.IPAddress) to UBound(IPConfig.IPAddress)
					IP = IPConfig.IPAddress(j)
		
				next
			end if
		next
		ipsub = left(ip,9)
		clsrm = right(ipsub,1)
		if compname = "VANCOUVER" then
			domain = "namerica1"
			pair = "DENVER"
			ip = ".1"
			pairip = ".2"
			listen = "10.1.1.1"
		end if
		if companem = "PERTH" then
			domain = "spacific1"
			pair = "BRISBANE"
			ip = ".3"
			pairip = ".4"
			listen = "10.1.3.1"
		end if
		if compname = "LISBON" then
			doamin = "europe1"
			pair = "BONN"
			ip = ".5"
			pairip = ".6"
			listen = "10.1.5.1"
		end if
		 if compname = "LIMA" then
			domain = "samerica1"
			pair = "SANTIAGO"
			ip = ".7"
			pairip = ".8"
			listen = "10.1.7.1"
		end if
		if compname = "BANGALORE" then
			domain = "asia1"
			pair = "SINGAPORE"
			ip = ".9"
			pairip = ".10"
			listen = "10.1.9.1"
		end if
		if compname = "CASABLANCA" then
			domain = "africa1"
			pair = "TUNIS"
			ip = ".11"
			pairip = ".12"
			listen = "10.1.11.1"
		end if
		if compname = "ACAPULCO" then
			domain = "namerica2"
			pair = "MIAMI"
			ip = ".13"
			pairip = ".14"
			listen = "10.1.13.1"
		end if
		if compname = "AUCKLAND" then
			domain = "spacific2"
			pair = "SUVA"
			ip = ".15"
			pairip = ".16"
			listen = "10.1.15.1"
		end if
		if compname = "STOCKHOLM" then
			domain = "europe2"
			pair = "MOSCOW"
			ip = ".17"
			pairip = ".18"
			listen = "10.1.17.1"
		end if
		if compname = "CARACAS" then
			domain = "samerica2"
			pair = "MONTEVIDEO"
			ip = ".19"
			pairip = ".20"
			listen = "10.1.19.1"
		end if
		if compname = "MANILA" then 
			domain = "asia2"
			pair = "TOKYO"
			ip = ".21"
			pairip = ".22"
			listen = "10.1.21.1"
		end if
		if compname = "KHARTOUM" then
			domain = "africa2"
			pair = "NAIROBI"
			ip = ".23"
			pairip = ".24"
			listen = "10.1.23.1"
		end if
		
		
		cmd = "c:\moc\setup\dnscmd.exe " & compname & " /config " & domain & ".nwtraders.msft /AllowUpdate 0x0"
		wshshell.run cmd, 6, true 
		cmd = "c:\moc\setup\dnscmd.exe " & compname & " /recorddelete " & domain & ".nwtraders.msft " & compname & " A 192.168." & clsrm & ip & " /f"
		wshshell.Run cmd, 6, true
		cmd = "c:\moc\setup\dnscmd.exe " & compname & " /recorddelete " & domain & ".nwtraders.msft " & pair & " A 192.168." & clsrm & pairip & " /f"
		wshshell.Run cmd, 6, true
		cmd = "c:\moc\setup\dnscmd.exe " & compname & " /recorddelete " & domain & ".nwtraders.msft @ A 192.168." & clsrm & ip & " /f"
		wshshell.Run cmd, 6, true
		cmd = "c:\moc\setup\dnscmd.exe " & compname & " /recorddelete " & domain & ".nwtraders.msft @ A 192.168." & clsrm & pairip & " /f"
		wshshell.Run cmd, 6, true
		cmd = "c:\moc\setup\dnscmd.exe " & compname & " /RecordDelete " & domain & "nwtraders.msft gc._msdcs." & domain & "nwtraders.msft A 192.168." & clsrm & IP & " /f"
		wshshell.Run cmd, 6, true
		cmd = "c:\moc\setup\dnscmd.exe " & compname & " /ZoneDelete . /dsdel /f"
		wshshell.Run cmd, 6, true
		cmd = "c:\moc\setup\dnscmd.exe " & compname & " /ResetListenAddresses " & listen & " /f"
		wshshell.Run cmd, 6, true
		cmd = "c:\moc\setup\dnscmd.exe " & compname & " /ResetForwarders 192.168." & clsrm & ".200 & /f"
		wshshell.Run cmd, 6, true
	End if
Next	

			