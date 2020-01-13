Dim objShell
Set objShell = WScript.CreateObject ("WScript.shell")
objShell.run("""%ProgramFiles%\7-Zip\7z.exe"" a pdf.7z C:\tmp\*.txt")
Set objShell = Nothing