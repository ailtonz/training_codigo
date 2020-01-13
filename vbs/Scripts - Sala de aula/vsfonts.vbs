strProcToWait = "ACMSETUP.EXE"

wscript.Sleep 5000

set wbemObjectSet = GetObject("winmgmts://LocalHost").InstancesOf("Win32_Process")

finished = false
while not finished
	for each wbemObject in wbemObjectSet
		strLastProc = UCASE(wbemObject.Name)
		if strLastProc = strProcToWait then
			' wait for possible completion of process
			wscript.Sleep 5000
			'get new set of current processes
			set wbemObjectSet = GetObject("winmgmts://LocalHost").InstancesOf("Win32_Process")
			exit for
		end if
	next
	if strLastProc = strProcToWait then
		finished = false
	else
		finished = true
	end if		
wend
