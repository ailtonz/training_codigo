'Install Visual Studio .NET 2003 Prerequisites
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

Dim fnInput1, fnInput2, fnOutput
Dim strInput1, strInput2, strPerson
Dim fInput1, fInput2, fOutput
Const ForReading = 1, ForWriting = 2, ForAppending = 8 

'Establish file names
fnInput1 = strSource & "\setup\instruct\vspre1.txt"
fnInput2 = strSource & "\setup\instruct\vspre2.txt"
fnOutput = "c:\setup\vspre.ini"

'Open files
Set fInput1 = fso.OpenTextFile(fnInput1, ForReading, True)
Set fInput2 = fso.OpenTextFile(fnInput2, ForReading, True)
Set fOutput = fso.OpenTextFile(fnOutput, ForWriting, True)

'Read in all input files
strInput1 = fInput1.ReadAll
strInput2 = fInput2.ReadAll

'Write first part to output unattend file
fOutput.Write strInput1

'Close output unattend file and reopen it for appending
fOutput.Close
Set fOutput = fso.OpenTextFile(fnOutput, ForAppending, True)

'Append person type to unattend file
If UCase(strComputerName) = "LONDON" Then
   strPerson = "gfn_pid core user name=Instructor" & vbCRLF
Else
   strPerson = "gfn_pid core user name=Student" & vbCRLF
End If
fOutput.Write strPerson

'Append second part to output unattend file
fOutput.Write strInput2

'close all files
fInput1.Close
fInput2.Close
fOutput.Close


'-----------------------------------
'Install product using unattend file
'-----------------------------------

Wshshell.Run strSource & "\VS2003\Pre\Setup.exe /UnattendFile " & fnOutput, 1, true

'Wait until Windows Components Update 'Setup' Process Drops off the face of the Task List
WshShell.Run strLocal & "\Setup\WaitProc.vbs", 1, true