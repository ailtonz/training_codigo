set wshshell=wscript.createobject("wscript.shell")
wshshell.run "sysocmgr.exe /i:%windir%\inf\sysoc.inf /u:c:\setup\instmsmq.txt", 1, true    