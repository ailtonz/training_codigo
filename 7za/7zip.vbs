Dim objShell
Set objShell = WScript.CreateObject ("WScript.shell")
objShell.run("""c:\Program Files\7-Zip\7z.exe"" a pdf.7z C:\tmp\Outros\*.pdf")
Set objShell = Nothing