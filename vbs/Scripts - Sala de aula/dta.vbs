set IPConfigSet = GetObject("winmgmts:").ExecQuery _
		("select IPAddress from Win32_NetworkAdapterConfiguration where IPEnabled=TRUE")

for each IPConfig in IPConfigSet
	if Not IsNull(IPConfig.IPAddress) then 
		for i=LBound(IPConfig.IPAddress) to UBound(IPConfig.IPAddress)
						bob = IPConfig.IPAddress(i)
			
		next
	end if
next



mantis = left(bob,9)
mantis= right(mantis,1)

Set WshShell = Wscript.CreateObject("Wscript.Shell")
Set WshSysEnv = WshShell.Environment("Process")
compName = LCase(WshSysEnv("COMPUTERNAME")) & "dom.nwtraders.msft"


wshShell.run "dnscmd.exe . /ZoneResetType " + compName & " /DSPrimary", 6, true
wshShell.run "dnscmd.exe . /ZoneResetType " + mantis & ".168.192.in-addr.arpa /DSPrimary", 6, true
wshShell.run "net stop netlogon", 6, true
wshShell.run "net start netlogon", 6, true