' sus10sp1.vbs
'
' This script installs Microsoft Software Update Services 1.0 Service Pack 1

set wshshell = wscript.CreateObject("wscript.shell")
set fso = CreateObject("Scripting.FileSystemObject")
Const TemporaryFolder = 2

tempdir = fso.GetSpecialFolder(TemporaryFolder)

wshshell.run "C:\moc\Setup\sus10sp1.exe /t:" & tempdir & " /c", 0, true

wshshell.run tempdir & "\sussetup.msi /Q", 0, true

wshshell.run "c:\moc\setup\cfgieg.vbs", 0, true

' Copy the \\London\Labfiles\Setup\Unit9 folder to the root of Drive C.
fso.CreateFolder "C:\Unit9"
fso.MoveFile "\\London\Labfiles\Setup\Unit9\*.*", "C:\Unit9"

' Run C:\Unit9\Install.cmd.
wshshell.run "C:\Unit9\Install.cmd", 0, true