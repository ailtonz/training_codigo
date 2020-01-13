Option Explicit

On Error Resume Next

Const APPLICATION_IN_PROCESS_IIS5 = 0
Const APPLICATION_OUT_PROCESS_IIS5 = 1
Const APPLICATION_POOLED_PROCESS_IIS5 = 2

Dim WebRoot, strVirName, strPhysDir, strSubDir
Set WebRoot = GetObject("IIS://localhost/W3SVC/1/ROOT") 

'=========== Create Main Virtual Directory ===========
strVirName = "2663"
strPhysDir = "C:\Program Files\Msdntrain\2663"
MakeVirDir strVirName, strPhysDir
'=====================================================

'======== Create Application Subdirectories ==========
MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab02\Solution\Ex1\CS\ParseXmlService"
MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab02\Solution\Ex1\CS\ParseXmlWeb"
MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab02\Solution\Ex1\VB\ParseXmlService"
MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab02\Solution\Ex1\VB\ParseXmlWeb"

MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab03\Solution\Ex1\CS\ParseXmlService"
MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab03\Solution\Ex1\CS\ParseXmlWeb"
MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab03\Solution\Ex1\VB\ParseXmlService"
MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab03\Solution\Ex1\VB\ParseXmlWeb"
MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab03\Starter\CS\ParseXmlService"
MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab03\Starter\CS\ParseXmlWeb"
MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab03\Starter\VB\ParseXmlService"
MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab03\Starter\VB\ParseXmlWeb"'''

MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab04\Solution\Ex1\CS\WriteXmlService"
MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab04\Solution\Ex1\CS\WriteXmlWeb"
MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab04\Solution\Ex1\VB\WriteXmlService"
MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab04\Solution\Ex1\VB\WriteXmlWeb"

MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab05\Solution\Ex1\CS\Lab05Ex1Solution"
MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab05\Starter\Ex1\CS\Lab05Ex1Starter"
MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab05\Solution\Ex2\CS\Lab05Ex2Solution"
MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab05\Starter\Ex2\CS\Lab05Ex2Starter"
MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab05\Solution\Ex3\CS\Lab05Ex3Solution"
MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab05\Starter\Ex3\CS\Lab05Ex3Starter"
MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab05\Solution\Itp\CS\Lab05ItpSolution"
MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab05\Starter\Itp\CS\Lab05ItpStarter"

MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab07\Solution\Ex1\CS"
MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab07\Solution\Ex2\CS"
MakeSubDir "C:\Program Files\Msdntrain\2663\Labfiles\Lab07\Solution\Ex3\CS"

'WScript.Echo "Created applications at subdirectories:" & strSubDir
'=====================================================

Set WebRoot = nothing

Sub MakeVirDir(VirName, PhysDir)
	If Not CheckFolder(PhysDir) then
		'WScript.Echo "The physical directory " & PhysDir & " does not exist!"
		WScript.Quit 
	Else
		Dim WebVDir
		Set WebVDir = WebRoot.Create("IIsWebVirtualDir", VirName) 
		If Err.Number = -2147024713 Or Err.Number = 0 Then
			SetVDirInfo WebVDir, VirName, PhysDir
			'WScript.Echo "Created main virtual directory " & PhysDir
			Set WebVDir = nothing
		Else
			'WScript.Echo "Could not create virtual directory!" & vbCrLf & Err.Message
			WScript.Quit
		End If
	End If
End Sub

Sub MakeSubDir(SubDir)
	If Not CheckFolder(SubDir) then
		'WScript.Echo "The physical directory " & SubDir & " does not exist!"
	Else
		Dim VRoot, SubVDir, SubVDirName
		SubVDirName = ParsePath(strPhysDir, SubDir)
		Set VRoot = GetObject("IIS://localhost/W3SVC/1/ROOT/" & strVirName) 
		Set SubVDir = VRoot.Create("IIsWebDirectory", SubVDirName) 
		SubVDir.AppFriendlyName = Right(SubVDirName, Len(SubVDirName)-InStrRev(SubVDirName, "/"))
		SubVDir.SetInfo
		SubVDir.AppCreate2 APPLICATION_POOLED_PROCESS_IIS5
		strSubDir = strSubDir & vbCrLf & SubDir
		Set SubVDir = nothing
		Set VRoot = nothing
	End If
End Sub

Sub SetVDirInfo(VDir, stName, stPath)
    With VDir
	.AccessScript = TRUE
	.AccessRead = TRUE
	.AppFriendlyName = stName
	.AuthAnonymous = True
	.AuthBasic = False
	.AuthNTLM = True
	.EnableDirBrowsing = TRUE
	.Path = stPath
	.SetInfo
	.AppCreate2 APPLICATION_POOLED_PROCESS_IIS5
    End With
End Sub

Function ParsePath(PhysPath, SubPath)
	Dim PhysArray, SubArray
	PhysArray = Split(PhysPath, "\", -1, 1)
	SubArray = Split(SubPath, "\", -1, 1)
	Dim i, strOut
	For i = UBound(PhysArray)+1 To UBound(SubArray)
		strOut = strOut & SubArray(i) & "/"
	Next
	ParsePath = Left(strOut, Len(strOut)-1)
End Function

Function CheckFolder(stFolder)
	Dim fso
	Set fso = CreateObject("Scripting.FileSystemObject") 
	CheckFolder = fso.FolderExists(stFolder)
	Set fso = Nothing
End Function

