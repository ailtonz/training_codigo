Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegWrite "HKCU\Software\Microsoft\Internet Connection Wizard\DesktopChanged", 000000001 ,"REG_DWORD"
WshShell.RegWrite "HKCU\Software\Microsoft\Internet Connection Wizard\Completed", 1 ,"REG_BINARY"
WshShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main\Start Page", "http://london","REG_SZ"


'==========================================================================================================================
Set objNet = WScript.CreateObject("WScript.Network")
Namer = "administrator"
AccountName = "london.nwtraders.msft"
SMTPAddress = namer & "@nwtraders.msft"


Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegWrite "HKCU\Software\Microsoft\Internet Account Manager\Accounts", "00000001" 
WshShell.RegWrite "HKCU\Software\Microsoft\Internet Account Manager\Accounts\00000001\Account Name", AccountName, "REG_SZ"
WshShell.RegWrite "HKCU\Software\Microsoft\Internet Account Manager\Accounts\00000001\Connection Type", "3", "REG_DWORD"
WshShell.RegWrite "HKCU\Software\Microsoft\Internet Account Manager\Accounts\00000001\Pop3 prompt for password", "1", "REG_DWORD"
WshShell.RegWrite "HKCU\Software\Microsoft\Internet Account Manager\Accounts\00000001\Pop3 server", "london.nwtraders.msft", "REG_SZ"
WshShell.RegWrite "HKCU\Software\Microsoft\Internet Account Manager\Accounts\00000001\Pop3 use Sicily", "0", "REG_DWORD"
WshShell.RegWrite "HKCU\Software\Microsoft\Internet Account Manager\Accounts\00000001\Pop3 user name", Namer, "REG_SZ"
WshShell.RegWrite "HKCU\Software\Microsoft\Internet Account Manager\Accounts\00000001\SMTP display name", Namer, "REG_SZ"
WshShell.RegWrite "HKCU\Software\Microsoft\Internet Account Manager\Accounts\00000001\Smtp email address", SMTPAddress, "REG_SZ"
WshShell.RegWrite "HKCU\Software\Microsoft\Internet Account Manager\Accounts\00000001\SmtP server", "london.nwtraders.msft", "REG_SZ"
WshShell.RegWrite "HKCU\Software\Microsoft\Internet Account Manager\Accounts\00000001\Pop3 skip account", "1", "REG_DWORD"


displayname = WshShell.RegRead ("HKCU\Software\Microsoft\Internet Account Manager\Accounts\00000001\SMTP display name")
smtpaddress = WshShell.RegRead ("HKCU\Software\Microsoft\Internet Account Manager\Accounts\00000001\Smtp email address")

wscript.Echo "Seu email �: " & displayname & "(" & smtpaddress & ")"