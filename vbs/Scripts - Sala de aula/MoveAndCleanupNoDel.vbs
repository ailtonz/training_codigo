Dim sourcePath, destPath,fso,shell

'Get the command line arguments entered for the script
	Dim objArgs: Set objArgs = WScript.Arguments

sourcePath =objArgs(0)
destPath= "C:\Labs\Work"

On Error Resume Next

ClearWorkFolder()
set shell= createobject("wscript.shell")
shell.run "xcopy " + "c:\labs\common" + " " + destPath + " /s /h /y /e"
shell.run "xcopy " + sourcePath + " " + destPath + " /s /h /y /e"


Sub ClearWorkFolder
	'Start by clearing the directory
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set f = fso.GetFolder(destPath)
	For Each file In f.Files
		file.delete
	Next
	For Each folder in f.SubFolders
		folder.Delete
	Next
End Sub

