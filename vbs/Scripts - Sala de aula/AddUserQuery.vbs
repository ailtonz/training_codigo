on error resume next
set netobj = wscript.CreateObject("wscript.network")
cname = netobj.ComputerName
set obj = GetObject("WinNT://" & cname)
set usr = obj.create("user", "iisadmin")
usr.setpassword("password")
usr.setinfo