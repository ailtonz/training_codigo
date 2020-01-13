Function Zip(sFile,sArchiveName)
  'This function executes the command line
  'version of WinZip and reports whether
  'the archive exists after WinZip exits.
  'If it exists then it returns true. If
  'not it returns an error message.

  'This script is provided under the Creative Commons license located
  'at http://creativecommons.org/licenses/by-nc/2.5/ . It may not
  'be used for commercial purposes with out the expressed written consent
  'of NateRice.com

  Set oFSO = WScript.CreateObject("Scripting.FileSystemObject")
  Set oShell = WScript.CreateObject("Wscript.Shell")

  '--------Find Working Directory--------
  aScriptFilename = Split(Wscript.ScriptFullName, "\")
  sScriptFilename = aScriptFileName(Ubound(aScriptFilename))
  sWorkingDirectory = Replace(Wscript.ScriptFullName, sScriptFilename, "")
  '--------------------------------------

  '-------Ensure we can find WZZIP.exe------
  If oFSO.FileExists(sWorkingDirectory & " " & "WZZIP.EXE") Then
    sWinZipLocation = ""
  ElseIf oFSO.FileExists("C:\program files\WinZip\WZZIP.EXE") Then
    sWinZipLocation = "C:\program files\WinZip\"
  Else
    Zip = "Error: Couldn't find WZZIP.EXE"
    Exit Function
  End If
  '--------------------------------------

  oShell.Run """" & sWinZipLocation & "wzzip.exe"" -ex -r -p -whs -ybc """ & _
  sArchiveName & """ """ & sFile & """", 0, True  

  If oFSO.FileExists(sArchiveName) Then
    Zip = 1
  Else
    Zip = "Error: Archive Creation Failed."
  End If
End Function