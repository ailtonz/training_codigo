Set WshShell = WScript.CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

WshShell.RegWrite "HKCU\Software\Microsoft\Internet Connection Wizard\DesktopChanged", 000000001 ,"REG_DWORD"
WshShell.RegWrite "HKCU\Software\Microsoft\Internet Connection Wizard\Completed", 1 ,"REG_BINARY"

'Delete the "Connect to the Internet" shortcut from the desktop

lookfor = "C:\Documents and Settings\Administrator\Desktop\Connect to the Internet.lnk"

if fso.FileExists(lookfor) then
	set MyFile = fso.GetFile("C:\Documents and Settings\Administrator\Desktop\Connect to the Internet.lnk")
	MyFile.Delete
end if