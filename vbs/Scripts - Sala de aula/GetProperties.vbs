'Get Office XP Product Key from user and create "offPID.txt"

set wshshell=wscript.createobject("wscript.shell")
set fso = CreateObject("Scripting.FileSystemObject")

Dim sPid
sPid = ""

while (sPid = "")
sPid = InputBox("Enter your Office XP Product Key (WITHOUT dashes) and then click OK.", "Enter Office XP Product Key") 
wend

Set ts = fso.CreateTextFile("C:\Setup\INSTRUCT\offPID.txt", True)
ts.writeline "PIDKEY=" & chr(34) & sPid & chr(34)
ts.Close