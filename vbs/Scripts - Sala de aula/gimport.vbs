'Get Windows XP PID from user and create "winXPpid.txt"

set wshshell=wscript.createobject("wscript.shell")
set fso = CreateObject("Scripting.FileSystemObject")

Dim sPid
sPid = ""

while (sPid = "")
sPid = InputBox("Enter your Windows XP Product Key (with dashes) and then click OK.", "Enter Windows XP Product Key") 
wend

Set ts = fso.CreateTextFile("C:\setup\mocset\winXPpid.txt", True)
ts.writeline "ProductKey=" & chr(34) & sPid & chr(34)
ts.Close