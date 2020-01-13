Dim objShell
Set objShell = WScript.CreateObject ("WScript.shell")
objShell.run("""7za.exe"" a pdf.7z C:\tmp\Outros\*.pdf")
Set objShell = Nothing