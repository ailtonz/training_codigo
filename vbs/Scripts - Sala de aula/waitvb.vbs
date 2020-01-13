'Customization
SearchProcess = "setup.exe" 'from the 'Image Name' field in the Windows Task Manager
SearchCondition = false
Dim service
Dim sink
Set service = GetObject("WinMgmts:{impersonationLevel=impersonate}")
Set sink = WScript.CreateObject("WbemScripting.SWbemSink","SINK_") 
wscript.Sleep 1000
FoundProcess = false
ListComplete = false
FoundThisTime = false

Sub SINK_OnCompleted(iHResult, objErrorObject, objAsyncContext)
    ListComplete = true
    if FoundThisTime = true then 
    	FoundProcess = True
    else
    	FoundProcess = false
    end if
    FoundThisTime = false
End Sub

Sub SINK_OnObjectReady(objObject, objAsyncContext)
    if ucase(trim(objObject.name)) = ucase(trim(SearchProcess)) then FoundThisTime = true
End Sub

'execution starts here
do 
	listcomplete = false
	service.instancesOfAsync sink, "WIN32_Process"
	do until ListComplete = true
		
		' Wait until all processes have listed their existance
		wscript.Sleep 500
	loop
loop until FoundProcess = SearchCondition