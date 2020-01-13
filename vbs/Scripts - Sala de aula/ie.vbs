on error resume next

Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegWrite "HKCU\Software\Microsoft\Internet Explorer\Main\Start Page", "about:blank" ,"REG_SZ"

Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegWrite "HKLM\Software\Microsoft\Internet Explorer\Main\Default_Page_URL", "about:blank" ,"REG_SZ"

Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegWrite "HKLM\Software\Microsoft\Internet Explorer\Main\Start Page", "about:blank" ,"REG_SZ"
