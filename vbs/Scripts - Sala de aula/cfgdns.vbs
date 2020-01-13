option explicit 
dim wshShell,fso,fl,txt,lgn,cmd,nxt,onet,CompName,NotLondon
set wshShell = wscript.createobject("wscript.shell")
set fso = createobject("scripting.filesystemobject")
set onet = CreateObject("wscript.network")

'delete sqlcepath.txt if it exists
if fso.fileexists("c:\sqlcepath.txt") then
	fso.deletefile("c:\sqlcepath.txt")
end if

'Determine if this machine is a London machine or a secondary instructor/student
CompName = ucase(onet.ComputerName)
if (CompName = "LONDON") then
	NotLondon = 0
else
	NotLondon = 1
end if

'copy cetools executable to setup folder because for some reason it won't run from original location
fso.copyfile "C:\Program Files\Microsoft Visual Studio .NET 2003\CompactFrameworkSDK\v1.0.5000\Windows CE\sqlce20sql2ksp2.exe", "c:\setup\",1

'run the cdtool executable to extract temporary setup files
cmd = "c:\setup\sqlce20sql2ksp2.exe"

wshshell.run cmd, 1, false

'check to see that the setup files have been extracted
nxt = 0
while nxt = 0

	'run the cdtool executable to extract temporary setup files
	if (NotLondon) then
		wshshell.run "c:\moc\setup\cetool.cmd", 6, true 'cetool.cmd uses attrib to find the .msi and write the path to a text file
	else
		wshshell.run "c:\setup\cetool.cmd", 6, true 'cetool.cmd uses attrib to find the .msi and write the path to a text file
	end if

	set fl = fso.OpenTextFile ("c:\sqlcepath.txt")
	txt = fl.readline
	fl.close
	if left(txt,14)="File not found" then 'file not found indicates that the files haven't been extracted yet
		nxt = 0
	else
		nxt = 1
	end if
	wscript.sleep 10000
wend

'parse the text string to get the path
txt = rtrim(txt)
txt = ltrim(txt)
lgn = len(txt)
txt = left(txt,lgn-15)

'create sqlce folder if it doesn't already exists
if not fso.folderexists("c:\sqlce") then
	fso.CreateFolder "c:\sqlce"
end if

'copy files from temp folder to sqlce
fso.CopyFile txt & "\*.*","c:\sqlce",1

'kill msi file portion of setup
if (NotLondon) then
	wshshell.run "c:\moc\setup\kill msiexec.exe", 6
else
	wshshell.run "c:\setup\kill msiexec.exe", 6
end if


'run msi in silent mode
wshshell.run "c:\sqlce\SSCEServer.msi -q", 1, true
