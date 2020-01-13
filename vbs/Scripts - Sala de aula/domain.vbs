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

Set WshShell = WScript.CreateObject("WScript.Shell")
wshShell.run "attrib.exe -r dnssuf.txt", 6, true

  Const ForReading = 1, ForWriting = 2, ForAppending = 8
  Const TristateUseDefault = -2, TristateTrue = -1, TristateFalse = 0

  Dim fso, f, ts
  Set fso = CreateObject("Scripting.FileSystemObject")
  Set f = fso.GetFile("dnssuf.txt")
  Set ts = f.OpenAsTextStream(ForAppending, TristateUseDefault)
  ts.WriteBlankLines 1 
  ts.WriteLine "DNSDomain=" + compName
  ts.WriteBlankLines 1 
  'ts.Close


WshShell.run "netset.exe dnssuf.txt", 6, true
wshShell.run "attrib -h %systemroot%\inf", 6, true
wshShell.run "sysocmgr /x /q /i:%systemroot%\inf\sysoc.inf /u:c:\moc\win2154a\labfiles\custom\autodns\adddns.txt", 6, true
wshShell.run "dnscmd.exe . /ZoneAdd " + compName & " /Primary /file " + compname & ".dns", 6, true
wshShell.run "dnscmd.exe . /ZoneAdd " + mantis & ".168.192.in-addr.arpa /Primary /file " + mantis & ".168.192.in-addr.arpa.dns", 6, true
wshShell.run "dnscmd.exe . /Config ..AllZones /AllowUpdate 0x1", 6, true
wshShell.run "dnscmd.exe . /RecordAdd /RootHints @ NS london.nwtraders.msft", 6, true
wshShell.run "dnscmd.exe . /RecordAdd /RootHints london.nwtraders.msft A 192.168." + mantis & ".200", 6, true
wshShell.run "dnscmd.exe . /Config /AdminConfigured 1", 6, true


  ts.WriteBlankLines 1
  ts.WriteLine "[Adapter1.tcpip]"
  ts.WriteLine "SpecificTo=Adapter1"
  ts.WriteLine "DHCP = No"
  ts.WriteLine "DNS = NO"
  ts.writeline "SubnetMask=255.255.255.0"
  ts.WriteLine "IPAddress=" + bob
  ts.WriteLine "DNSServerSearchOrder=" + bob
  ts.Close

WshShell.run "netset.exe dnssuf.txt", 6, true
wshShell.run "c:\moc\setup\shutdown.exe /L /Y /R /T:00", 6, true