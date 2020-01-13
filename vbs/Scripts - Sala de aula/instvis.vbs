'Install SQL Server 2000 unattended
Option Explicit

Dim WshNetwork, WshShell, fso, strComputerName, strSource, strLocal
Set WshNetwork = wscript.CreateObject("Wscript.Network")
Set Wshshell = wscript.CreateObject("Wscript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

strComputerName = WshNetwork.ComputerName

If UCase(strComputerName) = "LONDON" Then
   strSource = "C:"
   strLocal = "C:"
Else
   strSource = "\\LONDON"
   strLocal = "C:\MOC"
End If


'--------------------
'Create unattend file
'--------------------

Dim fnInput1, fnInput2, fnInput3, fnPidKey, fnOutput
Dim strInput1, strInput2, strInput3, strPidKey, strPerson
Dim fInput1, fInput2, fInput3, fPidKey, fOutput
Const ForReading = 1, ForWriting = 2, ForAppending = 8 

'Establish file names
fnInput1 = strSource & "\setup\instruct\sql2kde1.txt"
fnInput2 = strSource & "\setup\instruct\sql2kde2.txt"
fnInput3 = strSource & "\setup\instruct\sql2kde3.txt"
fnPidKey = strSource & "\setup\instruct\sqlpid.txt"
fnOutput = strLocal & "\setup\sql2kde.iss"

'Open files
Set fInput1 = fso.OpenTextFile(fnInput1, ForReading, True)
Set fInput2 = fso.OpenTextFile(fnInput2, ForReading, True)
Set fInput3 = fso.OpenTextFile(fnInput3, ForReading, True)
Set fPidKey = fso.OpenTextFile(fnPidKey, ForReading, True)
Set fOutput = fso.OpenTextFile(fnOutput, ForWriting, True)

'Read in all input files
strInput1 = fInput1.ReadAll
strInput2 = fInput2.ReadAll
strInput3 = fInput3.ReadAll
strPidKey = fPidKey.ReadAll

'Write first part to output unattend file
fOutput.Write strInput1

'Close output unattend file and reopen it for appending
fOutput.Close
Set fOutput = fso.OpenTextFile(fnOutput, ForAppending, True)

'Append person type to unattend file
If UCase(strComputerName) = "LONDON" Then
   strPerson = "szName=Instructor" & vbCRLF
Else
   strPerson = "szName=Student" & vbCRLF
End If
fOutput.Write strPerson

'Append second part to output unattend file
fOutput.Write strInput2

'Append PID Key to output unattend file
fOutput.Write strPidKey

'Append third part to output unattend file
fOutput.Write strInput3

'close all files
fInput1.Close
fInput2.Close
fInput3.Close
fPidKey.Close
fOutput.Close


'-----------------------------------
'Install product using unattend file
'-----------------------------------

'Run an AutoIT script to close the info prompt warning that SQL installed in Windows 2003 Server
'must use SQL Server SP3 or later.
WshShell.Run strLocal & "\Setup\CLOSEWRN.EXE", 6, false

WshShell.Run strSource & "\SQL2KDE\x86\setup\setupsql.exe -s -SMS -f1 " & fnOutput, 6, true


'-------------------------------------------------
'Start the SQL Server Service and SQL Server Agent
'-------------------------------------------------

Dim oSqlServer
Const SERVER_NAME = "(local)"
Set oSqlServer = CreateObject("SQLDMO.SQLServer")
oSqlServer.Name = SERVER_NAME

'Start the SQL Server Service
If oSQLServer.Status = 3 Then ' 3 = SQLDMOSvc_Stopped
    oSqlServer.Start False
End If

'Connect to the Server
oSqlServer.LoginSecure = True
oSqlServer.Connect SERVER_NAME

'Set the SQL server agent to auto-start
'Note: The JobServer object exposes attributes associated with SQL Server Agent
oSqlServer.JobServer.AutoStart = True

'Start the SQL Server Agent
oSqlServer.JobServer.Start
