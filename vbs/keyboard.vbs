Set objLocator = CreateObject("WbemScripting.SWbemLocator")
Set objService = objLocator.ConnectServer(".", "root\cimv2")
objService.Security_.ImpersonationLevel = 3
Set Jobs = _
    objService.ExecQuery("SELECT * FROM Win32_ScheduledJob")
i=0
For each Job in Jobs
    i = i+1   
    WScript.Echo Job.JobId & "  " _
        & Job.Command & VBNewLine
Next
If i = 0 Then
    WScript.Echo "No Jobs Scheduled with the AT command were found"
End If