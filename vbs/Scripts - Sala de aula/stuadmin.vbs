set objnet = wscript.CreateObject("wscript.network")
set wshshell = wscript.CreateObject("wscript.shell")
cname = objnet.ComputerName
dname = objnet.userdomain
y = split (cname,"-",-1)
if y(1) = "MBX1" then
	set fso = createobject("scripting.filesystemobject")
	set x = fso.createtextfile("c:\tools\dname.txt")
	x.writeline dname
	x.writeline y(0)
	x.close
	wshshell.Run "c:\tools\storgrp.exe", 6, true
else
	wscript.Quit
end if

