Option Explicit

On Error Resume Next

Const APPLICATION_IN_PROCESS_IIS5 = 0
Const APPLICATION_OUT_PROCESS_IIS5 = 1
Const APPLICATION_POOLED_PROCESS_IIS5 = 2

Dim WebRoot, strVirName, strPhysDir, strSubDir, strErr
strErr = ""
Set WebRoot = GetObject("IIS://localhost/W3SVC/1/ROOT") 
strSubDir = ""

'=========== Create Main Virtual Directory ===========
strVirName = "2559"
strPhysDir = "C:\Program Files\Msdntrain\2559"
MakeVirDir strVirName, strPhysDir
'=====================================================

'======== Create Application Subdirectories ==========
MakeSubDir "C:\Program Files\Msdntrain\2559\Labfiles\Lab101\Ex01\Solution"
MakeSubDir "C:\Program Files\Msdntrain\2559\Labfiles\Lab101\Ex02\Starter"
MakeSubDir "C:\Program Files\Msdntrain\2559\Labfiles\Lab101\Ex02\Solution"
MakeSubDir "C:\Program Files\Msdntrain\2559\Labfiles\Lab101\Ex02\WebService"
MakeSubDir "C:\Program Files\Msdntrain\2559\Practices\Mod10\MyWebFormsPage\Solution"
MakeSubDir "C:\Program Files\Msdntrain\2559\Democode\Mod10\UseCalcService\Solution"
MakeSubDir "C:\Program Files\Msdntrain\2559\Democode\Mod10\WebForm\Solution"


If strSubDir = "" Then
	strSubDir = "No applications created"
Else
	WScript.Echo "Created applications at subdirectories:" & vbCrLf & strSubDir
End If

If strErr <> "" Then
	strErr = strErr & "Please run Allfiles.exe prior to executing this script."
	WScript.Echo "Errors:" & vbCrLf & strErr
End If

'=====================================================

Set WebRoot = nothing

Sub MakeVirDir(VirName, PhysDir)
	If Not CheckFolder(PhysDir) then
		WScript.Echo "The physical directory " & PhysDir & " does not exist! Please run Allfiles.exe prior to executing this script."
		WScript.Quit
	Else
		Dim WebVDir
		Set WebVDir = WebRoot.Create("IIsWebVirtualDir", VirName) 
		If Err.Number = -2147024713 Or Err.Number = 0 Then
			SetVDirInfo WebVDir, VirName, PhysDir
			WScript.Echo "Created main virtual directory " & PhysDir
			Set WebVDir = nothing
		Else
			WScript.Echo "Could not create virtual directory!" & vbCrLf & Err.Message
			WScript.Quit
		End If
	End If
End Sub

Sub MakeSubDir(SubDir)
	If Not CheckFolder(SubDir) then
		strErr = strErr & "The physical directory " & SubDir & " does not exist!" & vbCrLf
	Else
		Dim VRoot, SubVDir, SubVDirName
		SubVDirName = ParsePath(strPhysDir, SubDir)
		Set VRoot = GetObject("IIS://localhost/W3SVC/1/ROOT/" & strVirName) 
		Set SubVDir = VRoot.Create("IIsWebDirectory", SubVDirName) 
		SubVDir.AppCreate2 APPLICATION_POOLED_PROCESS_IIS5
		SubVDir.AppFriendlyName = Right(SubVDirName, Len(SubVDirName)-InStrRev(SubVDirName, "/"))
		SubVDir.SetInfo
		strSubDir = strSubDir & SubDir & vbCrLf
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

