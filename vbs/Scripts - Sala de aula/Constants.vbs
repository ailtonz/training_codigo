GROUP_NAMESPACE = "MicrosoftBizTalkServer_Group"
SERVER_NAMESPACE = "MicrosoftBizTalkServer_SERVER"
   
Set g_objLocator = CreateObject("WbemScripting.SWbemLocator")
Set g_objService = g_objLocator.ConnectServer(, "root/MicrosoftBizTalkServer")
g_objService.Security_.AuthenticationLevel = 6
g_objService.Security_.ImpersonationLevel = 3
strLocalServer = GetLocalServerName()
Set objGroup = GetCurrentGroup(strLocalServer)

g_ConnStr = "Provider=SQLOLEDB.1" & _
    ";Perersist Security Info=False" & _
    ";User ID=" & objGroup.doctrackdblogon & _
    ";Password=" & objGroup.doctrackdbpassword & _
    ";Initial Catalog=" & objGroup.doctrackdbname & _
    ";Data Source=" & objGroup.doctrackdbserver & _
    ";Connect Timeout=15"

MsgBox g_ConnStr

Function GetCurrentGroup(ByVal strServerName)
    Dim objGroup
    Dim objServer
    
    Set objServer = GetServerByName(strServerName)
    Set objGroup = GetGroupByName(objServer.GroupName)
    Set GetCurrentGroup = objGroup
End Function


Function GetLocalServerName()
    Set wshShell = CreateObject("WScript.Shell")
    Set wshSysEnv = wshShell.Environment("Process")
    GetLocalServerName = wshSysEnv("ComputerName")
End Function

Function GetServerByName(ByVal strServerName)
    Set GetServerByName = g_objService.Get(SERVER_NAMESPACE & ".NAME=""" & strServerName & """")
End Function

Function GetGroupByName(ByVal strGroupName)
    Set GetGroupByName = g_objService.Get(GROUP_NAMESPACE & ".NAME=""" & strGroupName & """")
End Function
