' AdbeRdr.vbs
'
' This script installs Adobe Reader 6.0

set wshshell = wscript.CreateObject("wscript.shell")
set fso = CreateObject("Scripting.FileSystemObject")
Const TemporaryFolder = 2
set onet = CreateObject("wscript.network")

cname = ucase(onet.ComputerName)
lcname  = LCase(cname)

tempdir = "C:\WINDOWS\Cache"

if (lcname = "london") then
	wshshell.run "C:\Setup\AdbeRdr60_enu.exe", 0, false
else
	wshshell.run "C:\moc\Setup\AdbeRd~1.exe", 0, false
end if


'check to see that the setup files have been extracted
nxt = 0
while nxt = 0

	if (lcname = "london") then		
		wshshell.run "C:\Setup\AdbeRdr.cmd", 6, true 'AdbeRdr.cmd uses attrib to find the .exe and write the path to a text file
	else
		wshshell.run "C:\moc\Setup\AdbeRdr.cmd", 6, true 'AdbeRdr.cmd uses attrib to find the .exe and write the path to a text file
	end if

	set fl = fso.OpenTextFile ("C:\AdbeRdrpath.txt")
	txt = fl.readline
	fl.close
	if left(txt,14)="Path not found" then 'path not found indicates that the files haven't been extracted yet
		nxt = 0
	elseif left(txt,14)="File not found" then 'file not found indicates that the files haven't been extracted yet
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
txt = left(txt,lgn-9)
lgn = len(txt)
txt = right(txt,lgn-11)

'create AdbeRdr folder if it doesn't already exist
if not fso.folderexists("c:\AdbeRdr") then
	fso.CreateFolder "c:\AdbeRdr"
end if

'copy files from temp folder to AdbeRdr
fso.CopyFile txt & "*.*","c:\AdbeRdr",1

'cancel the Adobe Reader 6.0 setup that is already running
if (lcname = "london") then		
	wshshell.run "C:\Setup\closeadb.exe", 6, false
else
	wshshell.run "C:\moc\Setup\closeadb.exe", 6, false
end if

wscript.sleep 10000

'run msi in silent mode
szPath = chr(34) & "c:\AdbeRdr\Adobe Reader 6.0.msi" & chr(34) & " -q"
wshshell.run szPath, 1, true
