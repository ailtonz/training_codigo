on error resume next
rem Set objNet = WScript.CreateObject("WScript.Network")
rem rem bob = objNet.ComputerName
Set fso = CreateObject("Scripting.FileSystemObject")
Set f = fso.CreateFolder("c:\moc")
Set f = fso.CreateFolder("c:\moc\win2267a")
Set f = fso.CreateFolder("c:\moc\win2267a\labfiles")
Set f = fso.CreateFolder("c:\moc\win2267a\labfiles\Lab07")

Set f = fso.CreateFolder("c:\moc\win2267a\labfiles\Lab07\Apps")
Set f = fso.CreateFolder("c:\moc\win2267a\labfiles\Lab07\Apps\Application 1")
Set f = fso.CreateFolder("c:\moc\win2267a\labfiles\Lab07\APps\Application 2")
Set f = fso.CreateFolder("c:\moc\win2267a\labfiles\Lab07\Apps\Application 3")

Set f = fso.CreateFolder("c:\moc\win2267a\labfiles\Lab07\Site Reports")

rem mantis = "C:\MOC\Win2267a\Labfiles\Lab07\" & bob & " Reports"
rem set f = fso.CreateFolder(mantis)

rem Set fso = CreateObject("Scripting.FileSystemObject")
rem Set ts = fso.CreateTextFile("c:\tools\shareout.cmd", True)
rem ts.WriteLine "net share Reports=" & chr(34) & mantis & chr(34)
rem ts.Close


Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.run "c:\tools\shareout.cmd", 6, true
