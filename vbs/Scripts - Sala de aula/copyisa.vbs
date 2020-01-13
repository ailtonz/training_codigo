' This script copies the product installation files from a CD, Product Server, or
' an alternate location.  This script will copy all contents from the root.
' If only subfolders are required, you must make that change below.

ON ERROR RESUME NEXT
dim fso, d, dc, dl

set fso = CreateObject("Scripting.FileSystemObject")
set dc = fso.drives

include "c:\tools\readcfg.vbs"

'## Important!! ##  Product name listed here MUST match in software.cfg
' 					if a file server is to be used
strProductName = "Trainer"

strMsgInsert = "Please insert the " & strProductName & " compact disc into the CD drive." & CHR(10) & _
    		   "After you have inserted the CD, click OK or click Cancel to specify a path."

strMsgPath = "Please specify the path to the root of the " & strProductName & " compact disc."

strMsgError = "Setup cannot copy the " & strProductName & " CD files. After the automated setup finishes, " & chr(10) & _
		      "complete the installation of the instructor computer by following the instructions " & chr(10) & _
	    	  "for installing the lab solution files in the manual setup guide."

valid = false 	' path not yet found

' list possible paths from the cd root (Retail vs MSDN) where the check file can be found
' separate with a coma (,)
pathSet = Array("\setup")

' file to look for
lookfile = "\LabInstructor\CS\setup.bat"

' Check for a product server
ServerPath = ReadConfig(strProductName)
if ServerPath <> False then
	for each pathfromroot in pathset
		lookfor = ServerPath & pathfromroot & lookfile
		if fso.FileExists(lookfor) then 
			valid = true
			copyFiles(ServerPath & pathfromroot)
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
        	if dl.IsReady then
            	if (fso.FileExists(lookfor)) then
					valid = true
            		copyFiles(dl & pathfromroot)
            	end if
        	End If
        Next
    Next
    resp = Msgbox (strMsgInsert, vbOKCancel or vbinformation or vbSystemModal, "CD Path")
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
        			copyFiles(path & pathfromroot)
		        	valid = true
        		End If
		next
	Else	' cannot copy files.  User clicked cancel on input box
		valid = true
		msgbox strMsgError, vbcritical, "CD Path"
	End If
Loop



sub copyfiles(path)
	set wshshell = Wscript.CreateObject("Wscript.Shell")
	on error resume next
		'copy files folder
		folders = Array("\LabInstructor\*.*", "\LabStudent\*.*")
		for each folder in folders
			sSrc = path & folder
			sDest = "C:\Setup" & folder 
			wshshell.run "xcopy " & sSrc & " " & sDest & " /e /c /q /r /y", 6, true
		next
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