Dim fso, fldr

Set fso = CreateObject("Scripting.FileSystemObject")
Set fldr = fso.GetFolder("c:\pptview\pfiles\ppv")
fldr.name = "PowerPoint Viewer"

Set fso = CreateObject("Scripting.FileSystemObject")
Set fldr = fso.GetFolder("c:\pptview\pfiles")
fldr.name = "Program Files"

