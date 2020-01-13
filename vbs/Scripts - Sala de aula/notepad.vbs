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



  Const ForReading = 1, ForWriting = 2, ForAppending = 8
  Const TristateUseDefault = -2, TristateTrue = -1, TristateFalse = 0

  Dim fso, f, ts
  Set fso = CreateObject("Scripting.FileSystemObject")
  Set f = fso.GetFile("c:\tools\nosuffix.txt")
  Set ts = f.OpenAsTextStream(ForAppending, TristateUseDefault)
  ts.WriteBlankLines 1 
  ts.WriteLine "DNSServerSearchOrder=192.168." + mantis + ".200"
  ts.WriteBlankLines 1 
  ts.WriteLine "IPAddress=" + bob
  ts.Close

Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.run "c:\tools\netset.exe c:\tools\nosuffix.txt", 6, true

