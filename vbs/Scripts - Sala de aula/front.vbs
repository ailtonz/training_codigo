set WshShell = CreateObject("WScript.Shell")
WshShell.Run "d:\exchange\setup\i386\setup.exe /forestprep /unattendfile c:\tools\fprep.ini", 1, true