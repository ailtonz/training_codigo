set FSo = CreateObject("Scripting.FileSystemObject")
set folder = FSO.getFolder ("C:\Teste\") 
  
for each file in folder.files

MSGBOX dateDiff("d", file.datecreated, now())

'if (dateDiff("d", file.datecreated, now()) >15) then
'	msgbox "deleta: " & file.name
'else
'	msgbox "mantem: " & file.name
'end if

'if (dateDiff("d", file.datecreated, now) >15) then File.delete 
next