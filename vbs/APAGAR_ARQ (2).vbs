' STUNIC2.VBS
'
' Configures the second network adapter for the student machines

set wshshell = wscript.CreateObject("wscript.shell")

LACName = "Local Area Connection"	'name of the Local Area Connection to modify
'Declare qual a classe que vc esta:
classroom = 11


set onet   = CreateObject("wscript.network")
cname      = ucase(onet.ComputerName)

' now make it lowercase
lcname  = LCase(cname)

'set Ip Address and Subnet Mask
Select  Case lcname
	Case "london"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".200 mask=255.255.255.0", 0, true
	Case "LONDON"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".200 mask=255.255.255.0", 0, true
	Case "vancouver"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".1 mask=255.255.255.0", 0, true
	Case "denver"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".2 mask=255.255.255.0", 0, true
	Case "perth"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".3 mask=255.255.255.0", 0, true
	Case "brisbane"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".4 mask=255.255.255.0", 0, true
	Case "lisbon"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".5 mask=255.255.255.0", 0, true
	Case "bonn"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".6 mask=255.255.255.0", 0, true
	Case "lima"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".7 mask=255.255.255.0", 0, true
	Case "santiago"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".8 mask=255.255.255.0", 0, true
	Case "bangalore"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".9 mask=255.255.255.0", 0, true
	Case "singapore"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".10 mask=255.255.255.0", 0, true
	Case "casablanca"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".11 mask=255.255.255.0", 0, true
	Case "tunis"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".12 mask=255.255.255.0", 0, true
	Case "acapulco"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".13 mask=255.255.255.0", 0, true
	Case "miami"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".14 mask=255.255.255.0", 0, true
	Case "auckland"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".15 mask=255.255.255.0", 0, true
	Case "suva"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".16 mask=255.255.255.0", 0, true
	Case "stockholm"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".17 mask=255.255.255.0", 0, true
	Case "moscow"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".18 mask=255.255.255.0", 0, true
	Case "caracas"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".19 mask=255.255.255.0", 0, true
	Case "montevideo"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".20 mask=255.255.255.0", 0, true
	Case "manila"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".21 mask=255.255.255.0", 0, true
	Case "tokyo"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".22 mask=255.255.255.0", 0, true
	Case "khartoum"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".23 mask=255.255.255.0", 0, true
	Case "nairobi"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".24 mask=255.255.255.0", 0, true
	
	Case "VANCOUVER"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".1 mask=255.255.255.0", 0, true
	Case "DENVER"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".2 mask=255.255.255.0", 0, true
	Case "PERTH"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".3 mask=255.255.255.0", 0, true
	Case "BRISBANE"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".4 mask=255.255.255.0", 0, true
	Case "LISBON"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".5 mask=255.255.255.0", 0, true
	Case "BONN"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".6 mask=255.255.255.0", 0, true
	Case "LIMA"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".7 mask=255.255.255.0", 0, true
	Case "SANTIAGO"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".8 mask=255.255.255.0", 0, true
	Case "BANGALORE"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".9 mask=255.255.255.0", 0, true
	Case "SINGAPORE"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".10 mask=255.255.255.0", 0, true
	Case "CASABLANCA"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".11 mask=255.255.255.0", 0, true
	Case "TUNIS"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".12 mask=255.255.255.0", 0, true
	Case "ACAPULCO"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".13 mask=255.255.255.0", 0, true
	Case "MIAMI"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".14 mask=255.255.255.0", 0, true
	Case "AUCKLAND"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".15 mask=255.255.255.0", 0, true
	Case "SUVA"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".16 mask=255.255.255.0", 0, true
	Case "STOCKHOLM"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".17 mask=255.255.255.0", 0, true
	Case "MOSCOW"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".18 mask=255.255.255.0", 0, true
	Case "CARACAS"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".19 mask=255.255.255.0", 0, true
	Case "MONTEVIDEO"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".20 mask=255.255.255.0", 0, true
	Case "MANILA"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".21 mask=255.255.255.0", 0, true
	Case "TOKYO"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".22 mask=255.255.255.0", 0, true
	Case "KHARTOUM"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".23 mask=255.255.255.0", 0, true
	Case "NAIROBI"
		wshshell.Run "netsh interface ip set address name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".24 mask=255.255.255.0", 0, true	

	Case Else
		wscript.Echo "Problema no IP.vbs... O nome do computador, n�o esta listado como STUDENT. Como resultado, o IP da placa de rede, n�o foi Configurado."
end select

'set Preferred DNS Server
wshshell.Run "netsh interface ip set dns name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".200 register=PRIMARY", 0, true

'set WINS Server
'wshshell.Run "netsh interface ip set wins name=" & chr(34) & LACName & chr(34) & " source=static addr=192.168." & classroom & ".200", 0, true
