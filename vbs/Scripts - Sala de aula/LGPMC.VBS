Dim fso, fle

Set fso = CreateObject("Scripting.FileSystemObject")
Set fle= fso.GetFile("c:\fonts\course~1.exe")
fle.name = "courseware.exe"
