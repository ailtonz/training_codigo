set shell=wscript.createobject("wscript.shell")
set fs=createobject("scripting.filesystemobject")

Shell.RegWrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\AutoAdminLogon", 0 ,"REG_SZ"
if (fs.folderexists("c:\program files\exchsrvr")) then
	fs.deletefolder ("c:\program files\exchsrvr")
end if
if (fs.folderexists("d:\program files\exchsrvr")) then
	fs.deletefolder ("d:\program files\exchsrvr")
end if

shell.run "net share moc=c:\moc", 1, true
fs.createfolder("c:\moc\exundone")

msgbox "Exchange 2000 has been removed"