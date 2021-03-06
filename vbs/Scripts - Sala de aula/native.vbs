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

' server = Array ("vancouver", "perth", "lisbon", "lima", "bangalore", "casablanca", "acapulco", "auckland", "stockholm", "caracas", "manila", "khartoum")
' partner = Array("denver",    "brisbane", "bonn",   "santiago", "singapore", "tunis",      "miami",    "suva",     "moscow",    "montevideo", "tokyo",  "nairobi")


root = "C:\Windows\System32\drivers\etc\"
hosts = "hosts"
lmhosts = "lmhosts"

clsrm = GetClassroomNumber()

call ChangeHosts()
call ChangeLMHosts()



Private Function ChangeHosts()
'	cname = lcase(oNet.ComputerName)
' 	' find partner computer
' 	myserv = ""
' 	for i = 0 to ubound(partner)
' 		if strcomp(partner(i), cname) = 0 then
' 			myserv = server(i)
' 		end if
' 	next
' 	if myserv = "" then
' 		for i = 0 to ubound(server)
' 			if strcomp(server(i), cname) = 0 then
' 				myserv = partner(i)
' 			end if
' 		next
' 	end if
	
	set f = fso.OpenTextFile(root & hosts, 1)
	s = f.ReadAll		' read in entire file
	f.Close 
	
	' set search and replace patterns
	patrn = "(\d+\.\d+\.\d+\.\d+)(\s+glasgow)"
	rpltxt = vbcrlf & "192.168." & clsrm & ".39 $2"
	
	set regex = new RegExp
	regex.pattern = patrn
	regex.ignorecase = true			' make case insensitive
	s2 = regex.Replace(s, rpltxt)	' execute replace
	
' 	' append partner information
' 	s2 = s2 + "192.168.11.48" & vbtab & myserv & vbcrlf

	' create new hosts file
	set f = fso.OpenTextFile(root & hosts, 2)
	f.Write s2
	f.Close 
	
End Function



Private Function ChangeLMHosts()
	set f = fso.OpenTextFile(root & lmhosts, 8)
	f.Writeline vbcrlf & "192.168." & clsrm & ".39" & vbtab & "Glasgow" & vbtab & "#PRE"
	f.Close 
	wshshell.Run "nbtstat -R", 0, true
End Function


Private Function GetClassroomNumber()
	set osvc = getobject("winmgmts:root\cimv2")
	
	for each onic in osvc.execquery( _
	            "select * from win32_networkadapter where " & _
	            "netconnectionid = 'Partner Network Connection'")
	
	            set oniccfg = osvc.get( _
	                        "win32_networkadapterconfiguration=" & onic.index)
	
	            ip = join(oniccfg.ipaddress,",")
	next
	
	ip = split(ip,".")
	if ubound(ip) < 3 then
		GetClassroomNumber = Null
	else
		GetClassroomNumber = ip(2)
	end if
End Function