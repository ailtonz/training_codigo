on error resume next
Dim fso, d, dc, s, n, WshShell
  Set fso = CreateObject("Scripting.FileSystemObject")
  Set dc = fso.Drives

do until foundCD = true
	  For Each d in dc
		 If d.IsReady Then
		setuppath = d.DriveLetter & ":\Win\System\msvci70d.dll"
		if fso.FileExists(setuppath) then
		   source = d.DriveLetter & ":\*.*"
		   dest = " c:\flats\VSNET\"
		   args = "/E /Y"
			  set WshShell = CreateObject("WScript.Shell")
			  foundCD = True
			  WshShell.Run "xcopy " & source & dest & args, 0, True
		   Exit For
		end if
		end if
	  Next
	  if foundCD = false then 
		MsgBox "Please Insert the 'Microsoft Visual Studio .NET disc 2' into any cdrom drive.", vbOkOnly + VBSystemModal ,"Automated Classroom Setup"
	  end if
loop
