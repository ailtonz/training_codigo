option explicit

dim astDir(6)
const stRoot = "2559"

astDir(0) = "Labfiles\Lab101\Ex01\Solution"
astDir(1) = "Labfiles\Lab101\Ex02\Starter"
astDir(2) = "Labfiles\Lab101\Ex02\Solution"
astDir(3) = "Labfiles\Lab101\Ex02\WebService"
astDir(4) = "Practices\Mod10\MyWebFormsPage\Solution"
astDir(5) = "Democode\Mod10\UseCalcService\Solution"
astDir(6) = "Democode\Mod10\WebForm\Solution"

const stDirDefault = "C:\program files\msdntrain"

Dim objArgs
Dim stDirBase
Dim WebRoot 
Dim webVDir
Dim webServer
Dim wshShell 
Dim oNet

	Set objArgs = WScript.Arguments

	if objArgs.Count > 1 then
		wscript.echo "If the path you specified contains a space, please surround it in quotes."
		wscript.quit(1)
	end if

	if objArgs.Count = 1 then
		stDirBase = objArgs(0)
	else
		stDirBase = stDirDefault
	end if

Dim stDir
Dim i
	
for i = 0 to ubound(astDir) 
	stDir = stDirBase + "\" + stRoot + "\" + astDir(i)

	if not CheckFolder(stDir) then
		wscript.echo "The lab and democode files must be installed to:" + vbcrlf + stDir + vbcrlf + "before this script is run." + vbcrlf + vbcrlf + "Please run Allfiles.exe as described" + vbcrlf + "in the Classroom Setup Guide before continuing."
		wscript.quit
	end if
next

	Set WebRoot = GetObject("IIS://LocalHost/W3SVC/1/ROOT") 
	stDir = stDirBase + "\" + stRoot
	Set WshShell = WScript.CreateObject("WScript.Shell")
	WshShell.Run "cacls """ + stDir + """ /E /T /G Everyone:R", 0, true
	WshShell.Run "cacls """ + stDir + """ /E /T /G Everyone:W", 0, true
	
	set webVDir = getVDir(webRoot, stRoot)
	SetVDirInfo webVDir, stDir
	CreateApp webVDir
	Set WebRoot = nothing
	set webVDir = nothing

for i = 0 to ubound(astDir) 
	Set WebRoot = GetObject("IIS://LocalHost/W3SVC/1/ROOT") 
	set webVDir = getVDir(webRoot,  stRoot + "\" + astDir(i))
	CreateApp webVDir
next
Set WebRoot = nothing
set webVDir = nothing

wscript.echo "Done"

function getVDir(Root, stVirtDir)
Dim V

on error resume next
	Set V = Root.Create("IIsWebVirtualDir", stVirtDir)

	if err then
		Set V = Root.GetObject("IIsWebVirtualDir", stVirtDir)
	End if

on error goto 0
	set getVDir = V
end function

sub CreateApp(vDir)
    With vDir
    .AppCreate TRUE
	.AppFriendlyName = .Name
	.SetInfo
    end with
end sub

sub SetVDirInfo(vDir, stPhysDir)
    With vDir
	.path = stPhysDir
	.AccessScript = TRUE
	.AccessRead = TRUE
	.EnableDirBrowsing = TRUE
	.SetInfo
    end with

end sub

function CheckFolder(stFolder)
dim ofs
'On Error Resume Next 
	Set ofs = CreateObject("Scripting.FileSystemObject") 
	If (Not ofs.FolderExists(stFolder)) Then 
		CheckFolder = false
	else
		CheckFolder = true
	end if
	set ofs = nothing
on error goto 0
end function

