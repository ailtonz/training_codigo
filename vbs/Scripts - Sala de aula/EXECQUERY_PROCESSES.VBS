dim count: count=0
vStart = time()
Set objSvc = GetObject("winmgmts:")
Set objSet = objSvc.ExecQuery("Select * From Win32_NtLogEvent Where Logfile = 'Application'",,48)
For Each obj in objSet
	count  = count + 1
Next
vFinish = time()
vElapsedTime = round((vFinish-vStart) * 100000,2)
Wscript.echo "There were " & count & " messages and it took " & vElapsedTime & " seconds"
