Set objNet = WScript.CreateObject("WScript.Network")
domName = objNet.UserDomain


If domName = "NAMERICA" then
set WshShell = CreateObject("WScript.Shell")
WshShell.Run "d:\exchange\setup\i386\setup.exe /unattendfile c:\tools\namerica.ini", 1, true
end if 

If domName = "SAMERICA" then
set WshShell = CreateObject("WScript.Shell")
WshShell.Run "d:\exchange\setup\i386\setup.exe /unattendfile c:\tools\samerica.ini" ,1, true
end if 


If domName = "ASIA" then
set WshShell = CreateObject("WScript.Shell")
WshShell.Run "d:\exchange\setup\i386\setup.exe /unattendfile c:\tools\asia.ini", 1, true
end if 


If domName = "AFRICA" then
set WshShell = CreateObject("WScript.Shell")
WshShell.Run "d:\exchange\setup\i386\setup.exe /unattendfile c:\tools\africa.ini", 1, true
end if 


If domName = "EUROPE" then
set WshShell = CreateObject("WScript.Shell")
WshShell.Run "d:\exchange\setup\i386\setup.exe /unattendfile c:\tools\europe.ini", 1, true
end if 


If domName = "SPACIFIC" then
set WshShell = CreateObject("WScript.Shell")
WshShell.Run "d:\exchange\setup\i386\setup.exe /unattendfile c:\tools\spacific.ini", 1, true
end if 