set fso = createobject("scripting.filesystemobject")
set wshshell = wscript.CreateObject("wscript.shell")
'create and share win2kpro folder
if fso.FolderExists("d:\win2kpro") then
	fso.Deletefolder("d:\win2kpro")
end if
fso.CreateFolder("d:\win2kpro")
wshshell.Run "net share win2kpro=d:\win2kpro", 1, true

'determine if the right cd is in the drive and create another file to copy the source files
set dc = fso.Drives
do until resp = vbcancel
	For each d in dc
		set dl = fso.GetDrive(d)
		lookfor = dl & "\i386\discover.ex_"
		if dl.IsReady then
			if fso.FileExists(lookfor) then
				Set ts = fso.CreateTextFile("c:\tools\procopy.vbs", true)
				ts.WriteLine "set fso = Createobject(" & chr(34) & "scripting.filesystemobject" & chr (34) & ")"
				ts.WriteLine "src = " & chr(34) & dl & "\i386" & chr(34)
				ts.WriteLine "dest = " & chr(34) & "d:\win2kpro" & chr(34)
				ts.WriteLine "fso.copyfolder src,dest,true"
				ts.Close
				wshshell.Run "c:\tools\procopy.vbs", 1, true
				wscript.Quit
			end if
		end if
	Next
resp = Msgbox ("Please insert the Microsoft Windows 2000 Professional compact disk into the CD-ROM drive" & chr(10) & "After you have inserted the CD, click OK. If the Microsoft Windows 2000 Professional Setup Screen should appear, close it.", vbOKCancel)
loop

msgbox "Setup cannot copy Windows 2000 Professional source files. After the automated setup finishes complete" & chr(10) & "the installation of the instructor computer by copying the \i386 directory from the Windows 2000 Professional compact disc" & chr(10) & "to d:\win2kpro on the instructor computer"
wscript.quit