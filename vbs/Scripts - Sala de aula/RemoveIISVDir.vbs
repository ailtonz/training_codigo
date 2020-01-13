set net=wscript.createobject("wscript.network")
set shell=wscript.createobject("wscript.shell")
if net.computername=VANCOUVER then
	set ou = GetObject("LDAP://ou=vancouver,dc=namerica,dc=nwtraders,dc=msft")
	ou.deleteobject(0)
	set ou = GetObject("LDAP://ou=denver,dc=namerica,dc=nwtraders,dc=msft")
	ou.deleteobject(0)
	set ou = GetObject("LDAP://ou=acapulco,dc=namerica,dc=nwtraders,dc=msft")
	ou.deleteobject(0)
	set ou = GetObject("LDAP://ou=miami,dc=namerica,dc=nwtraders,dc=msft")
	ou.deleteobject(0)
	deleteGroup("users","Exchange Admins")
	shell.run "net share moc=c:\moc", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.createfolder("c:\moc\adprepdone")
	shell.run "d:\exchange\setup\i386\setup /unattendfile c:\tools\unexch.ini", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.deletefolder ("c:\program files\exchsrvr"), true
end if
		
if net.computername=LISBON then
	set ou = GetObject("LDAP://ou=lisbon,dc=europe,dc=nwtraders,dc=msft")
	ou.deleteobject(0)
	set ou = GetObject("LDAP://ou=bonn,dc=europe,dc=nwtraders,dc=msft")
	ou.deleteobject(0)
	set ou = GetObject("LDAP://ou=stockholm,dc=europe,dc=nwtraders,dc=msft")
	ou.deleteobject(0)
	set ou = GetObject("LDAP://ou=moscow,dc=europe,dc=nwtraders,dc=msft")
	ou.deleteobject(0)
	deleteGroup("users","Exchange Admins")
	shell.run "net share moc=c:\moc", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.createfolder("c:\moc\adprepdone")
	shell.run "d:\exchange\setup\i386\setup /unattendfile c:\tools\unexch.ini", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.deletefolder ("c:\program files\exchsrvr"), true
end if

if net.computername=BANGALORE
	set ou = GetObject("LDAP://ou=bangalore,dc=asia,dc=nwtraders,dc=msft")
	ou.deleteobject(0)
	set ou = GetObject("LDAP://ou=singapore,dc=asia,dc=nwtraders,dc=msft")
	ou.deleteobject(0)
	set ou = GetObject("LDAP://ou=manila,dc=asia,dc=mwtraders,dc=msft")
	ou.deleteobject(0)
	set ou = GetObject("LDAP://ou=Tokyo,dc=asia,dc=nwtraders,dc=msft")
	ou.deleteobject(0)
	deleteGroup("users","ExchangeAdmins")
	shell.run "net share moc=c:\moc", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	shell.run "d:\exchange\setup\i386\setup /unattendfile c:\tools\unexch.ini", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.deletefolder ("c:\program files\exchsrvr"), true
end if

if net.computername=LIMA
	set ou = GetObject("LDAP://ou=lima,dc=samerica,dc=nwtraders,dc=msft")
	ou.deleteobject(0)
	set ou = GetObject("LDAP://ou=santiago,dc=samerica,dc=nwtraders,dc=msft")
	ou.deleteobject(0)
	set ou = GetObject("LDAP://ou=caracas,dc=samerica,dc=nwtraders,dc=msft")
	ou.deleteobject(0)
	set ou = GetObject("LDAP://ou=montevideo,dc=samerica,dc=nwtraders,dc=msft)
	ou.deleteobject(0)
	deleteGroup("users","ExchangeAdmins")
	shell.run "net share moc=c:\moc", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	shell.run "d:\exchange\setup\i386\setup /unattendfile c:\tools\unexch.ini", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.deletefolder ("c:\program files\exchsrvr"), true
end if

if net.computername=CASABLANCA
	set ou = GetObject("LDAP://ou=casablanca,dc=africa,dc=nwtraders,dc=msft")
	ou.deleteobject(0)
	set ou = GetObject("LDAP://ou=tunis,dc=africa,dc=nwtraders,dc=msft")
	ou.deleteobject(0)
	set ou = GetObject("LDAP://ou=khartoum,dc=africa,dc=nwtraders,dc=msft")
	ou.deleteobject(0)
	set ou = GetObject("LDAP://ou=nairobi,dc=africa,dc=nwtraders,dc=msft")
	ou.deleteobject(0)
	deleteGroup("users","ExchangeAdmins")
	shell.run "net share moc=c:\moc", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	shell.run "d:\exchange\setup\i386\setup /unattendfile c:\tools\unexch.ini", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.deletefolder ("c:\program files\exchsrvr"), true
end if

if net.computername=PERTH
	set ou = GetObject("LDAP://ou=perth,dc=spacific,dc=nwtraders,dc=msft")
	ou.deleteobject(0)
	set ou = GetObject("LDAP://ou=brisbane,dc=spacific,dc=nwtraders,dc=msft")
	ou.deleteobject(0)
	set ou = GetObject("LDAP://ou=auckland,dc=spacific,dc=nwtraders,dc=msft")
	ou.deleteobject(0)
	set ou = GetObject("LDAP://ou=suva,dc=spacific,dc=nwtraders,dc=msft")
	ou.deleteobject(0)
	deleteGroup("users","ExchangeAdmins")
	shell.run "net share moc=c:\moc", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	shell.run "d:\exchange\setup\i386\setup /unattendfile c:\tools\unexch.ini", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.deletefolder ("c:\program files\exchsrvr"), true
end if

if net.computername=DENVER
	x=0
	do while x=0
	msg = "Waiting for Domain Configuration on Vancouver"
	msg2 = "Remove Exchange"
	Set WshShell = WScript.CreateObject("WScript.Shell")
	bob = WshShell.Popup(msg,5,msg2,64)
	Set fso = CreateObject("Scripting.FileSystemObject")
	If (fso.FileExists("\\vancouver\moc\adprepdone")) Then
    	x=1
	End If
	if x=0 then
	wscript.sleep 10000
	end if
	Loop
	shell.run "d:\exchange\setup\i386\setup /unattendfile c:\tools\unexch.ini", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.deletefolder ("c:\program files\exchsrvr"), true
End if

if net.computername=MIAMI
	x=0
	do while x=0
	msg = "Waiting for Domain Configuration on Vancouver"
	msg2 = "Remove Exchange"
	Set WshShell = WScript.CreateObject("WScript.Shell")
	bob = WshShell.Popup(msg,5,msg2,64)
	Set fso = CreateObject("Scripting.FileSystemObject")
	If (fso.FileExists("\\vancouver\moc\adprepdone")) Then
    	x=1
	End If
	if x=0 then
	wscript.sleep 10000
	end if
	Loop
	shell.run "d:\exchange\setup\i386\setup /unattendfile c:\tools\unexch.ini", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.deletefolder ("c:\program files\exchsrvr"), true
end if

if net.computername=ACAPULCO
	x=0
	do while x=0
	msg = "Waiting for Domain Configuration on Vancouver"
	msg2 = "Remove Exchange"
	Set WshShell = WScript.CreateObject("WScript.Shell")
	bob = WshShell.Popup(msg,5,msg2,64)
	Set fso = CreateObject("Scripting.FileSystemObject")
	If (fso.FileExists("\\vancouver\moc\adprepdone")) Then
    	x=1
	End If
	if x=0 then
	wscript.sleep 10000
	end if
	Loop
	shell.run "d:\exchange\setup\i386\setup /unattendfile c:\tools\unexch.ini", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.deletefolder ("c:\program files\exchsrvr"), true
end if

if net.computername=BONN
	x=0
	do while x=0
	msg = "Waiting for Domain Configuration on Lisbon"
	msg2 = "Remove Exchange"
	Set WshShell = WScript.CreateObject("WScript.Shell")
	bob = WshShell.Popup(msg,5,msg2,64)
	Set fso = CreateObject("Scripting.FileSystemObject")
	If (fso.FileExists("\\Lisbon\moc\adprepdone")) Then
    	x=1
	End If
	if x=0 then
	wscript.sleep 10000
	end if
	Loop
	shell.run "d:\exchange\setup\i386\setup /unattendfile c:\tools\unexch.ini", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.deletefolder ("c:\program files\exchsrvr"), true
end if

if net.computername=STOCKHOLM
	x=0
	do while x=0
	msg = "Waiting for Domain Configuration on Lisbon"
	msg2 = "Remove Exchange"
	Set WshShell = WScript.CreateObject("WScript.Shell")
	bob = WshShell.Popup(msg,5,msg2,64)
	Set fso = CreateObject("Scripting.FileSystemObject")
	If (fso.FileExists("\\Lisbon\moc\adprepdone")) Then
    	x=1
	End If
	if x=0 then
	wscript.sleep 10000
	end if
	Loop
	shell.run "d:\exchange\setup\i386\setup /unattendfile c:\tools\unexch.ini", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.deletefolder ("c:\program files\exchsrvr"), true
end if

if net.computername=MOSCOW
	x=0
	do while x=0
	msg = "Waiting for Domain Configuration on Vancouver"
	msg2 = "Remove Exchange"
	Set WshShell = WScript.CreateObject("WScript.Shell")
	bob = WshShell.Popup(msg,5,msg2,64)
	Set fso = CreateObject("Scripting.FileSystemObject")
	If (fso.FileExists("\\Lisbon\moc\adprepdone")) Then
    	x=1
	End If
	if x=0 then
	wscript.sleep 10000
	end if
	Loop
	shell.run "d:\exchange\setup\i386\setup /unattendfile c:\tools\unexch.ini", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.deletefolder ("c:\program files\exchsrvr"), true
end if



if net.computername=SINAGAPORE
	x=0
	do while x=0
	msg = "Waiting for Domain Configuration on Bangalore"
	msg2 = "Remove Exchange"
	Set WshShell = WScript.CreateObject("WScript.Shell")
	bob = WshShell.Popup(msg,5,msg2,64)
	Set fso = CreateObject("Scripting.FileSystemObject")
	If (fso.FileExists("\\Bangalore\moc\adprepdone")) Then
    	x=1
	End If
	if x=0 then
	wscript.sleep 10000
	end if
	Loop
	shell.run "d:\exchange\setup\i386\setup /unattendfile c:\tools\unexch.ini", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.deletefolder ("c:\program files\exchsrvr"), true
end if

if net.computername=MANILA
	x=0
	do while x=0
	msg = "Waiting for Domain Configuration on Bangalore"
	msg2 = "Remove Exchange"
	Set WshShell = WScript.CreateObject("WScript.Shell")
	bob = WshShell.Popup(msg,5,msg2,64)
	Set fso = CreateObject("Scripting.FileSystemObject")
	If (fso.FileExists("\\Bangalore\moc\adprepdone")) Then
    	x=1
	End If
	if x=0 then
	wscript.sleep 10000
	end if
	Loop
	shell.run "d:\exchange\setup\i386\setup /unattendfile c:\tools\unexch.ini", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.deletefolder ("c:\program files\exchsrvr"), true
end if

if net.computername=TOKYO
	x=0
	do while x=0
	msg = "Waiting for Domain Configuration on Bangalore"
	msg2 = "Remove Exchange"
	Set WshShell = WScript.CreateObject("WScript.Shell")
	bob = WshShell.Popup(msg,5,msg2,64)
	Set fso = CreateObject("Scripting.FileSystemObject")
	If (fso.FileExists("\\Bangalore\moc\adprepdone")) Then
    	x=1
	End If
	if x=0 then
	wscript.sleep 10000
	end if
	Loop
	shell.run "d:\exchange\setup\i386\setup /unattendfile c:\tools\unexch.ini", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.deletefolder ("c:\program files\exchsrvr"), true
end if
	

if net.computername=SANTIAGO
	x=0
	do while x=0
	msg = "Waiting for Domain Configuration on Lima"
	msg2 = "Remove Exchange"
	Set WshShell = WScript.CreateObject("WScript.Shell")
	bob = WshShell.Popup(msg,5,msg2,64)
	Set fso = CreateObject("Scripting.FileSystemObject")
	If (fso.FileExists("\\Lima\moc\adprepdone")) Then
    	x=1
	End If
	if x=0 then
	wscript.sleep 10000
	end if
	Loop
	shell.run "d:\exchange\setup\i386\setup /unattendfile c:\tools\unexch.ini", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.deletefolder ("c:\program files\exchsrvr"), true
end if

if net.computername=CARACAS
	x=0
	do while x=0
	msg = "Waiting for Domain Configuration on Lima"
	msg2 = "Remove Exchange"
	Set WshShell = WScript.CreateObject("WScript.Shell")
	bob = WshShell.Popup(msg,5,msg2,64)
	Set fso = CreateObject("Scripting.FileSystemObject")
	If (fso.FileExists("\\Lima\moc\adprepdone")) Then
    	x=1
	End If
	if x=0 then
	wscript.sleep 10000
	end if
	Loop
	shell.run "d:\exchange\setup\i386\setup /unattendfile c:\tools\unexch.ini", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.deletefolder ("c:\program files\exchsrvr"), true
end if

if net.computername=MONTEVIDEO
	x=0
	do while x=0
	msg = "Waiting for Domain Configuration on Lima"
	msg2 = "Remove Exchange"
	Set WshShell = WScript.CreateObject("WScript.Shell")
	bob = WshShell.Popup(msg,5,msg2,64)
	Set fso = CreateObject("Scripting.FileSystemObject")
	If (fso.FileExists("\\Lima\moc\adprepdone")) Then
    	x=1
	End If
	if x=0 then
	wscript.sleep 10000
	end if
	Loop
	shell.run "d:\exchange\setup\i386\setup /unattendfile c:\tools\unexch.ini", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.deletefolder ("c:\program files\exchsrvr"), true
end if

if net.computername=TUNIS
	x=0
	do while x=0
	msg = "Waiting for Domain Configuration on Casablanca"
	msg2 = "Remove Exchange"
	Set WshShell = WScript.CreateObject("WScript.Shell")
	bob = WshShell.Popup(msg,5,msg2,64)
	Set fso = CreateObject("Scripting.FileSystemObject")
	If (fso.FileExists("\\Casablanca\moc\adprepdone")) Then
    	x=1
	End If
	if x=0 then
	wscript.sleep 10000
	end if
	Loop
	shell.run "d:\exchange\setup\i386\setup /unattendfile c:\tools\unexch.ini", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.deletefolder ("c:\program files\exchsrvr"), true
end if

if net.computername=KHARTOUM
	x=0
	do while x=0
	msg = "Waiting for Domain Configuration on Casablanca"
	msg2 = "Remove Exchange"
	Set WshShell = WScript.CreateObject("WScript.Shell")
	bob = WshShell.Popup(msg,5,msg2,64)
	Set fso = CreateObject("Scripting.FileSystemObject")
	If (fso.FileExists("\\Casablanca\moc\adprepdone")) Then
    	x=1
	End If
	if x=0 then
	wscript.sleep 10000
	end if
	Loop
	shell.run "d:\exchange\setup\i386\setup /unattendfile c:\tools\unexch.ini", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.deletefolder ("c:\program files\exchsrvr"), true
end if

if net.computername=NAIROBI
	x=0
	do while x=0
	msg = "Waiting for Domain Configuration on Casablanca"
	msg2 = "Remove Exchange"
	Set WshShell = WScript.CreateObject("WScript.Shell")
	bob = WshShell.Popup(msg,5,msg2,64)
	Set fso = CreateObject("Scripting.FileSystemObject")
	If (fso.FileExists("\\Casablanca\moc\adprepdone")) Then
    	x=1
	End If
	if x=0 then
	wscript.sleep 10000
	end if
	Loop
	shell.run "d:\exchange\setup\i386\setup /unattendfile c:\tools\unexch.ini", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.deletefolder ("c:\program files\exchsrvr"), true
end if
	

if net.computername=BRISBANE
	x=0
	do while x=0
	msg = "Waiting for Domain Configuration on Perth"
	msg2 = "Remove Exchange"
	Set WshShell = WScript.CreateObject("WScript.Shell")
	bob = WshShell.Popup(msg,5,msg2,64)
	Set fso = CreateObject("Scripting.FileSystemObject")
	If (fso.FileExists("\\Perth\moc\adprepdone")) Then
    	x=1
	End If
	if x=0 then
	wscript.sleep 10000
	end if
	Loop
	shell.run "d:\exchange\setup\i386\setup /unattendfile c:\tools\unexch.ini", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.deletefolder ("c:\program files\exchsrvr"), true
end if

if net.computername=AUCKLAND
	x=0
	do while x=0
	msg = "Waiting for Domain Configuration on Perth"
	msg2 = "Remove Exchange"
	Set WshShell = WScript.CreateObject("WScript.Shell")
	bob = WshShell.Popup(msg,5,msg2,64)
	Set fso = CreateObject("Scripting.FileSystemObject")
	If (fso.FileExists("\\Perth\moc\adprepdone")) Then
    	x=1
	End If
	if x=0 then
	wscript.sleep 10000
	end if
	Loop
	shell.run "d:\exchange\setup\i386\setup /unattendfile c:\tools\unexch.ini", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.deletefolder ("c:\program files\exchsrvr"), true
end if

if net.computername=SUVA
	x=0
	do while x=0
	msg = "Waiting for Domain Configuration on Perth"
	msg2 = "Remove Exchange"
	Set WshShell = WScript.CreateObject("WScript.Shell")
	bob = WshShell.Popup(msg,5,msg2,64)
	Set fso = CreateObject("Scripting.FileSystemObject")
	If (fso.FileExists("\\Perth\moc\adprepdone")) Then
    	x=1
	End If
	if x=0 then
	wscript.sleep 10000
	end if
	Loop
	shell.run "d:\exchange\setup\i386\setup /unattendfile c:\tools\unexch.ini", 1, true
	set fs = CreateObject("Scripting.FileSystemObject")
	fs.deletefolder ("c:\program files\exchsrvr"), true
end if
