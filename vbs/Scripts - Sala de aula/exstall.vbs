set wshshell = wscript.createobject("wscript.shell")
set objnet = wscript.CreateObject("wscript.network")
set fso = createobject("scripting.filesystemobject")
cname = objnet.ComputerName
namearr = split(cname,"-",-1)
if (fso.FolderExists("\\van-gc\exchange\sp2")) then
	src = "\\van-gc\exchange\sp2"
end if
if (fso.FolderExists("\\van-gc\exchange\server")) then
	src = "\\van-gc\exchange\server"
end if
if namearr(1) = "PF1" then
	wshshell.Run src & "\setup\i386\update.exe /unattendfile c:\moc\setup\pf1.ini", 1, true
elseif namearr(1) = "MBX1" then
	wshshell.Run src & "\setup\i386\update.exe /unattendfile c:\moc\setup\mbx1.ini", 1, true
else
	wshshell.Run src & "\setup\i386\update.exe /unattendfile c:\moc\setup\fe.ini", 1, true
end if
