Dim IE, fso, MyFile
Set fso = CreateObject("Scripting.FileSystemObject")
Set IE = CreateObject("InternetExplorer.Application")
set wshshell = wscript.CreateObject("wscript.shell")
ie.left=0
ie.top=0
ie.height=600
ie.width=800
ie.menubar=0
ie.toolbar=0
ie.addressbar=0
ie.statusbar=0
ie.navigate "file:///c:\moc\setup\mocahtml\moccust7.htm"
ie.visible=1

'Wait for London to be available
done = 0
while done = 0
	if fso.FolderExists("\\london\setup") then
		done = 1
	else
		wscript.sleep 5000
	end if
wend

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'' Establish computer's domain name
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
set oNet = CreateObject("wscript.network")
strServer = LCase(oNet.ComputerName)
Select Case strServer
	Case "vancouver"  strDomain = "adatum"
	Case "perth"      strDomain = "fabrikam"
	Case "lisbon"     strDomain = "lucernpublish"
	Case "lima"       strDomain = "litwareinc"
	Case "bangalore"  strDomain = "tailspintoys"
	Case "casablanca" strDomain = "wingtiptoys"
	Case "acapulco"   strDomain = "thephonecompany"
	Case "auckland"   strDomain = "cpandl"
	Case "stockholm"  strDomain = "adventureworks"
	Case "caracas"    strDomain = "blueyonderair"
	Case "manila"     strDomain = "woodgrovebank"
	Case "khartoum"   strDomain = "treyresearch"
	Case Else MsgBox "Invalid student computer name."
End Select

'Setting Auto Logon
WshShell.RegWrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\AutoAdminLogon", 1 ,"REG_SZ"
wshshell.Regwrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultUserName", "administrator", "REG_SZ"
wshshell.Regwrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultPassword", "P@ssw0rd", "REG_SZ"
wshshell.RegWrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultDomainName", strDomain, "REG_SZ"


'set mocfina.vbs to run after reboot
if fso.FileExists ("c:\moc\setup\mocfina.vbs") then
	set strt = fso.getfolder("c:\documents and settings\all users\start menu\programs\startup")
	fn = "runnext.vbs"
	set nxt = fso.getfile("c:\moc\setup\mocfina.vbs")
	set fl = fso.createtextfile(strt & "\" & fn, true)
	fl.writeline("set wshshell = wscript.createobject" & chr(40) & chr(34) & "wscript.shell" & chr(34) & chr(41))
	fl.writeline("wshshell.run " & chr(34) & nxt & chr(34))
	fl.Close
else
	set MyFile = fso.GetFile("C:\Documents and Settings\All Users\Start Menu\Programs\Startup\runnext.vbs")
	MyFile.Delete
end if


'Populate Active Directory
ie.Navigate "file:///c:\moc\setup\mocahtml\moccust7.htm"
wshshell.run "c:\moc\setup\popad.vbs", 6, true

'Install GPMC
ie.Navigate "file:///c:\moc\setup\mocahtml\moccust8.htm"
WshShell.run "c:\moc\setup\gpmc.msi /qb", 1, true

'Configure Group Policy Settings
ie.Navigate "file:///c:\moc\setup\mocahtml\moccust9.htm"
WshShell.Run "c:\moc\setup\stugp.exe /auto" , 6, true
wshshell.run "c:\moc\setup\stugp.vbs", 1, true

'verify that the NIC is configured correctly
WshShell.run "c:\moc\setup\cfgnic1.vbs", 6, true

'Set the wallpaper now that we're logged into the domain
WshShell.run "c:\setup\images\display.vbs", 6, true

'Reboot the machine
WshShell.run "c:\tools\reboot.cmd", 6, true