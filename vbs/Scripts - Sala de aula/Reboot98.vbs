'This reboot is required so that the CD AutoRun gets disabled.

Set fso = CreateObject("Scripting.FileSystemObject")
set wshshell = wscript.CreateObject("wscript.shell")

'Setting Auto Logon
WshShell.RegWrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\AutoAdminLogon", 1 ,"REG_SZ"
wshshell.Regwrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultUserName", "administrator", "REG_SZ"
wshshell.Regwrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultPassword", "P@ssw0rd", "REG_SZ"
'wshshell.RegWrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultDomainName", "londondom", "REG_SZ"

'set loncust.vbs to run after reboot
if fso.FileExists ("c:\setup\LONCUST.vbs") then
	set strt = fso.getfolder("c:\documents and settings\all users\start menu\programs\startup")
	fn = "runnext.vbs"
	set nxt = fso.getfile("c:\setup\LONCUST.vbs")
	set fl = fso.createtextfile(strt & "\" & fn, true)
	fl.writeline("set wshshell = wscript.createobject" & chr(40) & chr(34) & "wscript.shell" & chr(34) & chr(41))
	fl.writeline("wshshell.run " & chr(34) & nxt & chr(34))
	fl.Close
end if

'Delete the startup file
if fso.FileExists ("C:\Documents and Settings\All Users\Start Menu\Programs\Startup\mocsetup.cmd") then
	Set MyFile = fso.GetFile("C:\Documents and Settings\All Users\Start Menu\Programs\Startup\mocsetup.cmd")
	MyFile.Delete
end if

'reboot machine
wshShell.Run "c:\tools\reboot.cmd", 6, true