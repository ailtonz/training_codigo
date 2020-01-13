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

Intr1 = "Classroom Network Connection"
Intr2 = "Partner Network Connection"

ComputerName = oNet.ComputerName


' reset the RIP protocols
wshshell.Run "Reset.cmd """ & Intr1 & """ """ & Intr2 & """", 6, true

call ModifyFilter()
call DeleteInterface()


Private Function ModifyFilter()
	wshshell.Run "2.cmd """ & Intr2 & """ " & GetClassroomNumber, 6, true

End Function



Private Function DeleteInterface()
	wshshell.Run "1.cmd """ & GetInterfaceToModify & """", 6, true
End Function


Private Function GetInterfaceToModify()
	dim intr
	Randomize
	MyValue = int(2 * Rnd + 1)
	select case MyValue
		case 1: intr = Intr1
		case 2: intr = Intr2
	end select
	GetInterfaceToModify = intr
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