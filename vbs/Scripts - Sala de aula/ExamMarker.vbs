dim fso, d, dc, dl, run
set wshshell=wscript.createobject("wscript.shell")
set fso = CreateObject("Scripting.FileSystemObject")
set dc = fso.drives
do until resp=vbcancel
    For each d in dc
        set dl = fso.getdrive(d)
        lookfor=dl & "\setup\i386\exchmem.dll"
        lookfora=dl & "\EX2KSP2_server.exe"
        if dl.isready then
            if (fso.FileExists(lookfor)) then
            	set bob = fso.GetFile(lookfor)
            		if bob.Size = 29248 then
            			if (fso.FolderExists("d:\exchange\sp2")) then
            			else
							fso.CreateFolder "d:\exchange\sp2"
						end if
            			ssrc=dl & "\*.*"
            			sdest="d:\exchange\sp2"
            			set oshapp = createobject("shell.application")
            			oshapp.namespace(sdest).copyhere ssrc, &H10&
            			wscript.quit
                	end if
            elseif (fso.FileExists(lookfora)) then
            	wshshell.Run lookfora & " /auto d:\exchange", 1, true
            	wscript.Quit
            end if
        End If
    Next
set msg = fso.OpenTextFile("c:\tools\ex2ksp2.txt")
prmt = msg.ReadAll
resp=Msgbox(prmt, vbOKCancel or vbinformation)
loop
lookfor = null
lookfora = null

Call entpath

sub quitcopy
	set fl1 = fso.OpenTextFile("c:\tools\message2.txt")
	msg1 = fl1.ReadAll
	ans = msgbox(msg1,vbyesno,"1573 Setup")
	if ans = vbyes then
		wscript.Quit
	else
		call entpath
	end if
end sub

sub entpath
	set msg1 = fso.OpenTextFile("c:\tools\esp2inpt.txt")
	inprmt = msg1.ReadAll
	path = inputbox (inprmt,"1573 Setup")
	if path = "" then
		call quitcopy
	else
		call copysp2 (path)	
	end if
End Sub

Sub Copysp2 (path)   
	lookfor = path & "\EX2KSP2_server.exe"
	lookfora = path & "\setup\i386\exchmem.dll"
	if (fso.FileExists(lookfor)) then
		wshshell.Run path & "\ex2ksp2_server.exe /auto d:\exchange", 1, true
		wscript.Quit
	elseif (fso.FileExists(lookfora)) then
		if (fso.FolderExists("d:\exchange\sp2")) then
		else
			fso.CreateFolder "d:\exchange\sp2"
		end if
		src = path & "\*.*"
		sdest="d:\exchange\sp2"
		set oshapp = createobject("shell.application")
		oshapp.NameSpace(sdest).copyhere src, &H10&
		wscript.Quit
	end if
	call error1
End Sub

Sub Error1
	set fl2 = fso.OpenTextFile("c:\tools\error1.txt")
	err1 = fl2.ReadAll
	msgbox err1
	call entpath
End Sub