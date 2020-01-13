set wshshell = CreateObject("Wscript.Shell")
set oNet = CreateObject("Wscript.Network")
set fso = CreateObject("Scripting.FileSystemObject")

' get full path of the script location
mydir = wscript.ScriptFullName 

' strip off the file name
loc = instr(mydir, wscript.ScriptName)
mydir = left(mydir, loc-1)

' set working directory to script location
wshshell.currentDirectory = mydir

servers = Array ("vancouver", "perth", "lisbon", "lima", "bangalore", "casablanca", "acapulco", "auckland", "stockholm", "caracas", "manila", "khartoum")

for each server in servers
	wshshell.Run "RAS.cmd " & server, 6, true
next