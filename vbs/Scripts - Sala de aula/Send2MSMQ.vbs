On Error resume Next

Set objSvc = GetObject("WinMgmts:")
'Set objSvc = GetObject("WinMgmts:\\serverName")
'Set objSvc = GetObject("WinMgmts:{impersonationlevel=delegate,authenticationLevel=Pkt,(CreatePageFile,RemoteShutdown,Security)}")
'Set objSvc = GetObject("WinMgmts:{impersonationlevel=delegate,authenticationLevel=Pkt,(CreatePageFile,RemoteShutdown,!Security)}!\\serverName")

Set objSec = objSvc.security_
if Err <> 0  Then
	WScript.Echo "Something went wrong " & Hex(Err.number )
End If
	strResult = strResult & "Impersonation Level: " & objSec.impersonationLevel & vbcrlf
	strResult = strResult & "Authentication Level: " & objSec.authenticationLevel & vbcrlf
	strResult = strResult & "Privileges: " & vbcrlf
	Set objPrivilegeSet = objSec.privileges
	For Each objPrivilege in objPrivilegeSet
		strResult = strResult & space(10) & objPrivilege.name & ": " & objPrivilege.isEnabled & vbcrlf
	next
Wscript.Echo strResult
