set objlocator = createobject("wbemscripting.swbemlocator")
set connect = objlocator.ConnectServer ("denver","root/cimv2","nwtraders\administrator","password")

set disk = connect.Get("win32_logicaldisk.deviceid='c:'")


wscript.Echo disk.freespace