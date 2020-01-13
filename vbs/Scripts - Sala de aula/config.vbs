' confdns.vbs
'
' Creates the saopaolo.contoso.msft Forward Lookup Zone

Dim fso
Dim source
Dim file
Dim dest
Dim command

Set WshShell = WScript.CreateObject("WScript.Shell")
set fso = Wscript.CreateObject("Scripting.FileSystemObject")

' create the saopaolo.contoso.msft forward lookup zone
command = "c:\moc\setup\dnscmd /zoneadd saopaolo.contoso.msft /primary /file saopaolo.contoso.msft.dns"
wshshell.Run command, 6, true

' copy saopaolo.contoso.msft.dns from \\london\setup to C:\winnt\system32\dns
source = "c:\moc\2810\Labfiles\setup\"
file = "saopaolo.contoso.msft.dns"
dest = "C:\winnt\system32\dns\"

if fso.FileExists(source & file) then
   fso.CopyFile source & file, dest & file
end if

' reload the saopaolo.contoso.msft forward lookup zone so that it uses the info from the file that
' was just copied to C:\winnt\system32\dns
command = "c:\moc\setup\dnscmd /zonereload saopaolo.contoso.msft"
wshshell.Run command, 6, true
