On Error Resume Next
'replace all references to instructorServer
Set objSvc = GetObject("WinMgmts:")
Set objConsumerClass = objSvc.GET("SMTPEventConsumer")
Set myInstance = objConsumerClass.spawninstance_
	myInstance.Name	= "you@instructorServer.NWTraders.msft"
	myInstance.Subject = "Print Job Too Big"
	myInstance.Message= "User %TargetInstance.Owner% has sent %TargetInstance.document% with size %TargetInstance.size%"
	myInstance.ToLine		= "you@instructorServer.NWTraders.msft"
	myInstance.SMTPServer	= "instructorServer"
myInstance.put_
If Err = 0 Then
	Wscript.Echo "Success! email instance created"
Else
	Wscript.Echo hex(err.number), err.Description
End If
wscript.quit