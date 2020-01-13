' labans.vbs
'
' This script creates the Lab Browser shortcut on the Desktop

Dim fso
Dim source
Dim file
Dim dest

set fso = Wscript.CreateObject("Scripting.FileSystemObject")
source = "C:\MOC\2810\Labfiles\Setup\"
file = "Lab Browser.lnk"
dest = "C:\Documents and Settings\All Users\Desktop\"

if fso.FileExists(source & file) then
   fso.CopyFile source & file, dest & file
end if
