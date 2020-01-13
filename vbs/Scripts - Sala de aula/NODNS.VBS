set wshshell = wscript.CreateObject("wscript.shell")
wshshell.Run "Control Panel", 1, false
wscript.sleep 2000
wshshell.Run "c:\moc\setup\nicdis.exe", 1, true
