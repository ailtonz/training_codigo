


set objsam = getobject("WinNT://singapore")

for each x in objsam 
txt = txt & x.name & " - " & x.class & vbnewline
next
set fso=createobject("scripting.filesystemobject")
set arquivo = fso.CreateTextFile("c:\lista.txt")
arquivo.Write(txt)
arquivo.Close
'wscript.Echo txt