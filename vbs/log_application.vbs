for each soft in getobject("winmgmts://london").instancesof("win32_product")
txt = txt & soft.name & vbnewline
next
wscript.Echo txt