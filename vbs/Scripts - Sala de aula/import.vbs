' iisfiles.vbs
'
' This script copies files into the web folder.

Option Explicit

dim fso, wshshell, onet

set fso = CreateObject("Scripting.FileSystemObject")
set wshshell = Wscript.CreateObject("Wscript.Shell")

'Copy C:\MOC\2192\Labfiles\Setup\default.htm into the C:\Inetpub\wwwroot folder
if fso.FileExists("C:\MOC\2192\Labfiles\Setup\default.htm") then
   fso.CopyFile "C:\MOC\2192\Labfiles\Setup\default.htm", "C:\Inetpub\wwwroot\default.htm"
end if

'Copy C:\MOC\2192\Labfiles\Setup\default.htm into the C:\Inetpub\wwwroot folder
if fso.FileExists("C:\MOC\2192\Labfiles\Setup\Dix_07Deck61702.jpg") then
   fso.CopyFile "C:\MOC\2192\Labfiles\Setup\Dix_07Deck61702.jpg", "C:\Inetpub\wwwroot\Dix_07Deck61702.jpg"
end if