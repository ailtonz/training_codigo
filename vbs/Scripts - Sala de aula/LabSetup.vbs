' labans.vbs
'
' This script creates the "Lab Answers" folder on the Desktop

dim fso

set fso = CreateObject("Scripting.FileSystemObject")

if not(fso.FolderExists("C:\Documents and Settings\All Users\Desktop\Lab Answers")) then fso.CreateFolder "C:\Documents and Settings\All Users\Desktop\Lab Answers"
