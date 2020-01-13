'Install PowerPoint XP and Excel (from Office XP Professional with FrontPage)


set wshshell = wscript.CreateObject("wscript.shell")

'--------------------------------------------------------------------------------------
'Create unattend file
'--------------------------------------------------------------------------------------

dim filesys, offsetup, contents
Const ForReading = 1, ForWriting = 2, ForAppending = 8 
Set filesys = CreateObject("Scripting.FileSystemObject")


'Open ofcpptx1.txt for reading
Set ofcpptx1 = filesys.OpenTextFile("c:\setup\instruct\ofcpptx1.txt", ForReading, True)

'open offsetup.ini for writing
Set offsetup = filesys.OpenTextFile("c:\setup\offsetup.ini", ForWriting, True)

'readall ofcpptx1.txt
contents = ofcpptx1.ReadAll

'write ofcpptx1.txt to offsetup.ini
offsetup.write contents

'close offsetup.ini
offsetup.close

'open offPID.txt for reading
Set offPID = filesys.OpenTextFile("c:\setup\instruct\offPID.txt", ForReading, True)

'get PID Key from offPID.txt
contents = offPID.ReadAll

'open offsetup.ini for appending
Set offsetup = filesys.OpenTextFile("c:\setup\offsetup.ini", ForAppending, True)

'append PID Key to Offsetup.ini
offsetup.write contents

'open ofcpptx2.txt for reading
Set ofcpptx2 = filesys.OpenTextFile("c:\setup\instruct\ofcpptx2.txt", ForReading, True)

'readall ofcpptx2.txt
contents = ofcpptx2.ReadAll

'append to offsetup.ini
offsetup.write contents

'close all files
ofcpptx1.close
ofcpptx2.close
offsetup.close



'--------------------------------------------------------------------------------------
'Run Install with unattend file that was just created
'--------------------------------------------------------------------------------------

wshshell.Run "c:\officexp\setup.exe /settings c:\setup\offsetup.ini", 1, true


