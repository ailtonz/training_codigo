dim objSked, strPath, WshShell

strPath = WScript.ScriptFullName
strPath = Mid(strPath, 1, InStrRev(strPath, "\"))

Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.Run """" & strPath & "SendReportMsgToQueue.vbs" & """"
set objSked = GetObject("sked:///" & strPath & "GeneratePO.skx")
