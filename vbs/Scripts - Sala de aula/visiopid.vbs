on error resume next


 Const ForReading = 1, ForWriting = 2, ForAppending = 8
  Const TristateUseDefault = -2, TristateTrue = -1, TristateFalse = 0


 
Dim fso, MyFile, d, t, f, ts
Set fso = CreateObject("Scripting.FileSystemObject")

Set MyFile = fso.OpenTextFile("c:\params.txt", ForReading)
ReadLineTextFile = MyFile.ReadLine	

bob = left(ReadLineTextFile,2)

  Set fso = CreateObject("Scripting.FileSystemObject")
  Set d = fso.GetDrive(bob)
  Select Case d.DriveType
    Case 0: t = "Unknown"
    Case 1: t = "Removable"
    Case 2: t = "Fixed"
    Case 3: t = "Network"
    Case 4: t = "CD-ROM"
    Case 5: t = "RAM Disk"
  End Select
  ShowDriveType = "Drive " & d.DriveLetter & ": - " & t

If t = "CD-ROM" then
lookfor = d.DriveLetter & ":\install\mssup.exe"
Input = d.driveletter
else 
Input = InputBox("Please enter the drive letter of your compact disc drive.")
lookfor = Input  & ":\install\mssup.exe"
end if


  Set fso = CreateObject("Scripting.FileSystemObject")
  Set d = fso.GetDrive(Input)
  Select Case d.DriveType
    Case 0: t = "Unknown"
    Case 1: t = "Removable"
    Case 2: t = "Fixed"
    Case 3: t = "Network"
    Case 4: t = "CD-ROM"
    Case 5: t = "RAM Disk"
  End Select
  ShowDriveType = "Drive " & d.DriveLetter & ": - " & t

If t = "CD-ROM" then
lookfor = d.DriveLetter & ":\install\mssup.exe"
Input = d.driveletter
else 
Msgbox "Setup is unable to copy the Visio 2000 files. Please refer to the Setup Guide for instructions on copying these files manually."

Wscript.quit
end if


Set fso = CreateObject("Scripting.FileSystemObject")

 
If (fso.FileExists(lookfor)) Then

else
Message1 = "Please insert the Visio 2000 compact disc into drive " & d.DriveLetter
Message2 = ". After you have inserted the CD, click OK. if the Visio 2000 Title Screen should appear, click Exit."
message3 = Message1 & message2
Msgbox Message3

end if


Set fso = CreateObject("Scripting.FileSystemObject")

 
If (fso.FileExists(lookfor)) Then

  Set fso = CreateObject("Scripting.FileSystemObject")
  Set ts = fso.CreateTextFile("c:\tools\visio2.cmd", True)
  ts.WriteLine "xcopy " & Input & ":\*.* d:\visio\*.* /e"
  ts.Close


Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.run "c:\tools\visio.cmd", 6, true

Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.run "c:\tools\visio2.cmd", 1, true



else
Msgbox "Setup is unable to copy the Visio 2000 files. Please refer to the Setup Guide for instructions on copying these files manually."

end if







