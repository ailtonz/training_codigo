Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegWrite "HKCU\Software\Microsoft\Exchange\Client\Options\PickLogonProfile", "1" ,"REG_SZ"
