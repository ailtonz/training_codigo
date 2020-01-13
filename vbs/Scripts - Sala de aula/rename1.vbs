Dim fso, fldr

Set fso = CreateObject("Scripting.FileSystemObject")
Set fldr = fso.GetFolder("c:\setup\winsrc")
fldr.name = "i386"

