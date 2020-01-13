'============================================================


wscript.Echo getobject("winmgmts:{impersonationlevel=impersonate}!\\bfins23/root/cimv2:win32_logicaldisk.deviceid='c:'").freespace



