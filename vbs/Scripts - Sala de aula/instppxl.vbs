'Install PowerPoint XP from admin install point
Dim wshShell, fso

'copy the ini file
Set fso = CreateObject("Scripting.FileSystemObject")
fso.CopyFile "c:\tools\setup.ini", "c:\officexp\files\setup\", True

Set wshShell = CreateObject("WScript.Shell")

wshShell.Run "c:\OfficeXP\setup.exe /TRANSFORMS=c:\tools\pptxp.mst /qb-",6, True




