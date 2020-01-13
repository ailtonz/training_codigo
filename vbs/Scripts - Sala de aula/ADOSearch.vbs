Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegWrite "HKLM\System\CurrentControlSet\Control\Lsa\TcpipClientSupport ", 1 ,"REG_DWORD"