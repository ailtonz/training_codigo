Set WshShell = Wscript.CreateObject("Wscript.Shell")
Set WshSysEnv = WshShell.Environment("Process")
netbName = wshSysEnv("COMPUTERNAME") & "DOM"
dnsName = LCase(WshSysEnv("COMPUTERNAME")) & "dom.nwtraders.msft"

Set WshShell = WScript.CreateObject("WScript.Shell")
wshShell.run "attrib -r c:\autodc\autodc.txt", 6, true

  Const ForReading = 1, ForWriting = 2, ForAppending = 8
  Const TristateUseDefault = -2, TristateTrue = -1, TristateFalse = 0

  Dim fso, f, ts
  Set fso = CreateObject("Scripting.FileSystemObject")
  Set f = fso.GetFile("autodc.txt")
  Set ts = f.OpenAsTextStream(ForAppending, TristateUseDefault)
  'ts.WriteBlankLines 1 
  ts.WriteLine "DomainNetBIOSName=" + netbName
  ts.writeLine "NewDomainDNSName=" + dnsName
  'ts.WriteBlankLines 1 
  ts.Close

wshShell.run "REG.EXE add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce\Native=c:\moc\win2154a\labfiles\autodc\native.vbs", 6, true
wshShell.run "REG.EXE add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce\ADIntegrated=c:\moc\win2154a\labfiles\dszone.vbs", 6, true
wshShell.run "dcpromo.exe /answer:autodc.txt", 6, true
