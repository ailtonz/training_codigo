dim objSked, strPath, sUrl

strPath = WScript.ScriptFullName
strPath = Mid(strPath, 1, InStrRev(strPath, "\"))

sUrl = "sked:///" & strPath & "listenerapp.skx/GetSkedInfo"
set objSked = GetObject(sUrl)
objSked.GetSkedInfo strPath 
msgbox "Started ListenerApp", vbOKOnly, "QueueListener Sample"
