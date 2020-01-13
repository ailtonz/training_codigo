' prevlkup.vbs
'
' This script creates two primary reverse lookup zones on Glasgow

Option Explicit

Dim WshShell, CmdStr, ServerStr

ServerStr = "glasgow"

Set WshShell = WScript.CreateObject("WScript.Shell")

AddRevLkupZone("0.0.10")
AddRevLkupZone(getclsrm & ".168.192")

WScript.Quit 0


' Add a reverse lookup zone
'
Sub AddRevLkupZone(RevIPAddress)
	' Add reverse lookup zone
	CmdStr = "c:\moc\setup\dnscmd " & ServerStr & " /zoneadd " & _
                RevIPAddress & ".in-addr.arpa /Primary /file " & RevIPAddress & ".in-addr.arpa.dns"
	WshShell.Run CmdStr, 6, True
	CmdStr = "c:\moc\setup\dnscmd " & ServerStr & " /Config " & _
		RevIPAddress & ".in-addr.arpa /AllowUpdate 0x00000001"
	WshShell.Run CmdStr, 6, True
End Sub

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