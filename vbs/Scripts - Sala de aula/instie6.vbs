set wshshell = wscript.CreateObject("wscript.shell")
wshshell.run "D:\exchange\setup\i386\setup.exe /unattendfile c:\tools\exchange.ini", 6, true
