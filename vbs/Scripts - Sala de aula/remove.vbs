on error resume next
set fso = createobject("scripting.filesystemobject")
set wshshell = wscript.CreateObject("wscript.shell")
fso.CreateFolder ("c:\Remotedir")
fso.CreateFolder ("c:\Remotedir\Virtual")
fso.CopyFile "c:\inetpub\ftproot\LON.BMP","c:\Remotedir\Virtual\lon.bmp"
fso.CopyFile "c:\inetpub\ftproot\default.htm","c:\Remotedir\Virtual\default.htm"
set shobj = GetObject("WinNT://london/lanmanserver,FileService")
set shr = shobj.create("FileShare","Remotedir")
shr.path = "c:\Remotedir"
shr.MaxUserCount = -1
shr.setinfo
wshshell.Run "c:\tools\subinacl /share \\london\remotedir /grant=everyone=R", 6, true