' This script copies the product installation files from a CD, Product Server, or
' an alternate location.  This script will copy all contents from the root.
' If only subfolders are required, you must make that change below.

'ON ERROR RESUME NEXT
dim fso, d, dc, dl

set fso = CreateObject("Scripting.FileSystemObject")
set dc = fso.drives

include "C:\tools\readcfg.vbs"

'## Important!! ##  Product name listed here MUST match in software.cfg
' 					if a file server is to be used
strProductName = "SQL Server 2000 Service Pack 2"

strMsgInsert = "Please insert the " & strProductName & " compact disc into the CD drive. " & _
    		   "After you have inserted the CD, click OK or click Cancel to specify a path."

strMsgPath = "Please specify the path to the SQL Server 2000 Service Pack 2 CD"

strMsgError = "Setup cannot copy the " & strProductName & " files. After the automated setup finishes, " & chr(10) & _
		      "complete the installation of the instructor computer by following the instructions " & chr(10) & _
	    	  "for installing " & strProductName & " in the automated setup guide."

valid = false 	' path not yet found

' list possible paths from the cd root (Retail vs MSDN) where the check file can be found
' separate with a coma (,)
pathSet = Array("")

' file to look for
lookfile = "\sql2ksp2.exe"	'user-created CD from download
lookfile2 = "\sql2kdef.bat"	'retail CD ordered from Microsoft

' Check for a product server
ServerPath = ReadConfig(strProductName)
if ServerPath <> False then
	for each pathfromroot in pathset
		lookfor = ServerPath & pathfromroot & lookfile
		if fso.FileExists(lookfor) then 
			valid = true
			copyFiles(ServerPath)
		else
			' msgbox "The file was not found or the network path is not available."
		end if
	next
end if

do until resp = VBCANCEL or valid = true
	' check each drive
    For each d in dc
        set dl = fso.GetDrive(d)
        ' check each possible path
        For each pathfromroot in pathSet
	    	lookfor=dl & pathfromroot & lookfile
		lookfor2=dl & pathfromroot & lookfile2
        	if dl.IsReady then
        		if (fso.FileExists(lookfor)) then
				'User inserted a CD with the downloaded file
				valid = true
            			extract(dl)
			else if (fso.FileExists(lookfor2)) then
				'User inserted a retail CD ordered from Microsoft
				valid = true
            			copyFiles(dl)
			end if
            		end if
        	End If
        Next
    Next
    resp = Msgbox (strMsgInsert, vbOKCancel or vbinformation, "CD Path")
loop


Do While valid = false
	path = InputBox(strMsgPath, "CD Path", dl)
	If path <> "" Then
		'format input string
		If right(path, 1) = "\" Then
			path = left(path, len(path)-1)
		End IF
		
		'verify path and copy if correct
		for each pathfromroot in pathset
			if fso.FileExists(path & pathfromroot & lookfile) then
        			copyFiles(path)
		        	valid = true
        		End If
		next
	Else	' cannot copy files.  User clicked cancel on input box
		valid = true
		msgbox strMsgError, vbcritical, "CD Path"
	End If
Loop

sub extract(path)	'For copying a user-created CD
	set wshshell = Wscript.CreateObject("Wscript.Shell")
	if not(fso.FolderExists("D:\SQL2KDE\SP2")) then fso.CreateFolder "D:\SQL2KDE\SP2"

	on error resume next
		'Extract sql2ksp2.exe to c:\sql2ksp2 (this is the default)
		wshshell.Run path & "\sql2ksp2.exe" & " -s", 1, true
	on error goto 0

	' Move the contents of c:\sql2ksp2 folder to D:\SQL2KDE\SP2
	sSrc = "c:\sql2ksp2\*.*"
	sDest = "D:\SQL2KDE\SP2" 
	wshshell.run "xcopy " & sSrc & " " & sDest & " /E /Y /R /H", 0, true

	wscript.Sleep 5000

	'Delete the c:\sql2ksp2 folder
	if fso.FolderExists ("c:\sql2ksp2") then
		Set MyFolder = fso.GetFolder("c:\sql2ksp2\")
		MyFolder.Delete
	end if

	wscript.Quit
end sub

sub copyfiles(path)	'For copying a retail CD ordered from Microsoft
	set wshshell = Wscript.CreateObject("Wscript.Shell")
	if not(fso.FolderExists("D:\SQL2KDE\SP2")) then fso.CreateFolder "D:\SQL2KDE\SP2"

	on error resume next
		'copy setup folder
		sSrc = path & "\*.*"
		sDest = "D:\SQL2KDE\SP2" 

		wshshell.run "xcopy " & sSrc & " " & sDest & " /E /Y /R /H", 0, true
	on error goto 0

	wscript.Quit
end sub

Function Include(vbsFile)
  Set fso = CreateObject("Scripting.FileSystemObject")
  Set f = fso.OpenTextFile(vbsFile)
  s = f.ReadAll()
  f.Close 
  ExecuteGlobal s
End Function