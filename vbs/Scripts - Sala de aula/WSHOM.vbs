Set fso = CreateObject("Scripting.FileSystemObject")
Set ts = fso.OpenTextFile("c:\temp\script.txt", 8, True)
ts.WriteLine("The Service has stopped")
ts.close

