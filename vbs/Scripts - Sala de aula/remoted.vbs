on error resume next
Dim IE
Set IE = CreateObject("InternetExplorer.Application")
ie.left=0
ie.top=0
ie.height=570
ie.width=800
ie.menubar=0
ie.toolbar=0
ie.addressbar=0
ie.statusbar=0
ie.navigate "file:///\\london\dcpromo\dc1.htm"
ie.visible=1


Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegWrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\AutoAdminLogon", 0 ,"REG_SZ"

Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.run "%comspec% /c net stop netlogon", 1, true
wscript.sleep 30000
WshShell.run "%comspec% /c net start netlogon", 1, true



Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.run "c:\setup\images\display.vbs", 6, true

Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.run "c:\tools\scriptit.exe c:\tools\setpaper.txt", 1, true

ie.navigate "file:///\\london\dcpromo\dc3.htm"

