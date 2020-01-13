set wshshell=wscript.createobject("wscript.shell")
wshshell.run "sysocmgr.exe /i:sysoc.inf /u:c:\setup\instmsmq.txt", 1, true    