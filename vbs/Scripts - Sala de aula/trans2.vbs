dim objSked, strPath, WshShell

strPath = WScript.ScriptFullName
strPath = Mid(strPath, 1, InStrRev(strPath, "\"))

Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.Run """" & strPath & "SendTrans.vbs" & """"
set objSked = GetObject("sked:///" & strPath & "TxDemo1.skx")
