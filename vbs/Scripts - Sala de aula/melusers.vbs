on error resume next
Dim IE
Set WshShell = WScript.CreateObject("WScript.Shell")
Set IE = CreateObject("InternetExplorer.Application")
ie.left=0
ie.top=0
ie.height=570
ie.width=800
ie.menubar=0
ie.toolbar=0
ie.addressbar=0
ie.statusbar=0
ie.navigate "file:///c:\moc\setup\mochtml\mel_end.htm"
ie.visible=1

wscript.Sleep 5000
 
'Disable Auto Logon
WshShell.RegWrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\AutoAdminLogon", 0 ,"REG_SZ"
    
'remove startup file
Set fso = CreateObject("Scripting.FileSystemObject")
set dest = fso.getfolder("c:\documents and settings\all users\Start Menu\Programs\startup")
set fl = fso.getfile(dest & "\" & "runnext.vbs")
fl.delete


ie.navigate "file:///c:\moc\setup\mochtml\mel_end.htm"