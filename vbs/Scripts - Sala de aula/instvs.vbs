'Install Visio 2002 Professional


set wshshell = wscript.CreateObject("wscript.shell")

'--------------------------------------------------------------------------------------
'Create unattend file
'--------------------------------------------------------------------------------------

dim filesys, offset1, contents
Const ForReading = 1, ForWriting = 2, ForAppending = 8 
Set filesys = CreateObject("Scripting.FileSystemObject")


'Open visioun1.txt for reading
Set visioun1 = filesys.OpenTextFile("c:\setup\instruct\visioun1.txt", ForReading, True)

'open offsetup.ini for writing
Set vissetup = filesys.OpenTextFile("c:\setup\vissetup.ini", ForWriting, True)

'readall visioun1.txt
contents = visioun1.ReadAll

'write visioun1.txt to vissetup.ini
vissetup.write contents

'close vissetup.ini
vissetup.close

'open visPID.txt for reading
Set visPID = filesys.OpenTextFile("c:\setup\instruct\visPID.txt", ForReading, True)

'get PID Key from visPID.txt
contents = visPID.ReadAll

'open vissetup.ini for appending
Set vissetup = filesys.OpenTextFile("c:\setup\vissetup.ini", ForAppending, True)

'append VL Key to vissetup.ini
vissetup.write contents

'open visioun2.txt for reading
Set visioun2 = filesys.OpenTextFile("c:\setup\instruct\visioun2.txt", ForReading, True)

'readall visioun2.txt
contents = visioun2.ReadAll

'append to vissetup.ini
vissetup.write contents

'close all files
visioun1.close
visioun2.close
vissetup.close



'--------------------------------------------------------------------------------------
'Run Install with unattend file that was just created
'--------------------------------------------------------------------------------------

wshshell.Run "D:\VISIOPRO\setup.exe /settings c:\setup\vissetup.ini", 1, true


