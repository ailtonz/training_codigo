set FSo = CreateObject("Scripting.FileSystemObject")
set folder = FSO.getFolder ("C:\tmp\") 
  
for each file in folder.files

if (dateDiff("d", file.datecreated, now) >15) then File.delete 

next