Dim fso, fldr

Set fso = CreateObject("Scripting.FileSystemObject")
Set fldr = fso.GetFolder("c:\setup\i386")
fldr.name = "winsrc"

