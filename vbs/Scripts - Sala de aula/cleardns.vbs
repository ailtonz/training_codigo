option explicit 
dim wshShell,fso, MyFolder
set wshShell = wscript.createobject("wscript.shell")
set fso = createobject("scripting.filesystemobject")

'Delete the sqlce folder
if fso.FolderExists ("c:\sqlce") then
	Set MyFolder = fso.GetFolder("c:\sqlce")
	MyFolder.Delete
end if
