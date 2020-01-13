' pfwdlkup.vbs
'
' This script creates the forward lookup zone on Glasgow

Option Explicit

Dim WshShell, ServerStr, CmdStr

ServerStr = "glasgow"

Set WshShell = WScript.CreateObject("WScript.Shell")

' Add forward lookup zone
CmdStr = "c:\moc\setup\dnscmd " & ServerStr & " /zoneadd nwtraders.msft /Primary /file nwtraders.msft.dns"
WshShell.Run CmdStr, 6, True
CmdStr = "c:\moc\setup\dnscmd " & ServerStr & " /Config nwtraders.msft /AllowUpdate 0x00000001"
WshShell.Run CmdStr, 6, True

CmdStr = "c:\moc\setup\dnscmd " & ServerStr & " /RecordAdd nwtraders.msft london A 10.0.0.1"
WshShell.Run CmdStr, 6, True
CmdStr = "c:\moc\setup\dnscmd " & ServerStr & " /RecordAdd nwtraders.msft london A 192.168." & getclsrm & ".200"
WshShell.Run CmdStr, 6, True

private function getclsrm
Dim fso, fl, x, lgn
	set fso = createobject("scripting.filesystemobject")
	set fl = fso.OpenTextFile ("c:\moc\setup\mocset\mocset2.cmd")
	while left (x,13) <> "set classroom"
		x = fl.readline
	wend
	fl.close
	rtrim x
	lgn = len(x)
	getclsrm = left(right(x,lgn-14),1)
end function