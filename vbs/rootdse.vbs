Dim fso
Set fso = CreateObject("Scripting.FileSystemObject")

fso.MoveFile "bkp.cmd", year(now)&Month(now)&day(now)&".cmd"