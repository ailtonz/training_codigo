on error resume next
dim wshShell

set wshShell = Wscript.CreateObject("WScript.Shell")
wshShell.run "c:\setup\cosmo1.exe /auto", 0, True