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
strProductName = "Adobe Acrobat Reader 5.1 (vers�o em portugu�s)"

strMsgInsert = "Insira o CD do " & strProductName & " na unidade de CD-ROM. " & _
    		   "Depois de inserir o CD, clique em OK ou em Cancelar para especificar um caminho."

strMsgPath = "Especifique o caminho para a raiz do CD do " & strProductName & ""

strMsgError = "A instala��o n�o pode copiar os arquivos do " & strProductName & ". Depois que a instala��o autom�tica for finalizada, " & chr(10) & _
		      "termine a instala��o do computador do instrutor seguindo as instru��es de " & chr(10) & _
	    	  "instala��o do " & strProductName & " no guia de instala��o autom�tica."

valid = false 	' path not yet found

' list possible paths from the cd root (Retail vs MSDN) where the check file can be found
' separate with a coma (,)
pathSet = Array("")

' file to look for
lookfile = "\AcroReader51_PTB.exe"

' Check for a product server
ServerPath = ReadConfig(strProductName)
if ServerPath <> False then
	for each pathfromroot in pathset
		lookfor = ServerPath & pathfromroot & lookfile
		if fso.FileExists(lookfor) then 
			valid = true
			copyFiles(ServerPath)
		else
			' msgbox "O arquivo n�o foi encontrado ou o caminho de rede n�o est� dispon�vel."
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
            		copyFiles(dl)
            	end if
        	End If
        Next
    Next
    resp = Msgbox (strMsgInsert, vbOKCancel or vbinformation, "Caminho do CD")
loop


Do While valid = false
	path = InputBox(strMsgPath, "Caminho do CD", dl)
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
		msgbox strMsgError, vbcritical, "Caminho do CD"
	End If
Loop


sub copyfiles(path)
	set wshshell = Wscript.CreateObject("Wscript.Shell")

	on error resume next
		'copy setup folder
		sSrc = path & "\AcroReader51_PTB.exe"
		sDest = "C:\SETUP" 

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