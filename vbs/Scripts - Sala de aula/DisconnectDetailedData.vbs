Const ForReading = 1, ForWriting = 2
 
Dim fso, MyFile
Set fso = CreateObject("Scripting.FileSystemObject")

Set MyFile = fso.OpenTextFile("c:\params.txt", ForReading)
CDLetter = MyFile.ReadLine	
InstallDrive = MyFile.ReadLine
ClassroomNumber = MyFile.ReadLine
DebugFile = MyFile.ReadLine	
MyFile.close
	

if ClassroomNumber = 1 then
Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.run "c:\tools\dhcpadd\dhcp1.cmd", 6, true
end if

if ClassroomNumber = 2 then
Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.run "c:\tools\dhcpadd\dhcp2.cmd", 6, true
end if

if ClassroomNumber = 3 then
Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.run "c:\tools\dhcpadd\dhcp3.cmd", 6, true
end if

if ClassroomNumber = 4 then
Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.run "c:\tools\dhcpadd\dhcp4.cmd", 6, true
end if

if ClassroomNumber = 5 then
Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.run "c:\tools\dhcpadd\dhcp5.cmd", 6, true
end if

if ClassroomNumber = 6 then
Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.run "c:\tools\dhcpadd\dhcp6.cmd", 6, true
end if

if ClassroomNumber = 7 then
Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.run "c:\tools\dhcpadd\dhcp7.cmd", 6, true
end if

if ClassroomNumber = 8 then
Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.run "c:\tools\dhcpadd\dhcp8.cmd", 6, true
end if

if ClassroomNumber = 9 then
Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.run "c:\tools\dhcpadd\dhcp9.cmd", 6, true
end if

