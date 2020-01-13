' mocusers.vbs
'
' This script creates and configures the Users for the student machines

set wshshell = wscript.CreateObject("wscript.shell")


' Create Sally's account
wshshell.Run "net user Sally /ADD /FULLNAME:Sally", 0, true

' Create Bob's account
wshshell.Run "net user Bob /ADD /FULLNAME:Bob", 0, true

' Add Sally to the Administrators group
wshshell.Run "net localgroup Administrators Sally /ADD", 0, true

' Add Bob to the Administrators group
wshshell.Run "net localgroup Administrators Bob /ADD", 0, true



' Now add Admin# from contoso as an admin on this machine... We will need to do a switch to determine
' which # to use.
set onet   = CreateObject("wscript.network")
cname      = ucase(onet.ComputerName)
Select  Case cname
	Case "VANCOUVER"
		wshshell.Run "net localgroup Administrators contoso\Admin1 /ADD", 0, true
	Case "DENVER"
		wshshell.Run "net localgroup Administrators contoso\Admin2 /ADD", 0, true
	Case "PERTH"
		wshshell.Run "net localgroup Administrators contoso\Admin3 /ADD", 0, true
	Case "BRISBANE"
		wshshell.Run "net localgroup Administrators contoso\Admin4 /ADD", 0, true
	Case "LISBON"
		wshshell.Run "net localgroup Administrators contoso\Admin5 /ADD", 0, true
	Case "BONN"
		wshshell.Run "net localgroup Administrators contoso\Admin6 /ADD", 0, true
	Case "LIMA"
		wshshell.Run "net localgroup Administrators contoso\Admin7 /ADD", 0, true
	Case "SANTIAGO"
		wshshell.Run "net localgroup Administrators contoso\Admin8 /ADD", 0, true
	Case "BANGALORE"
		wshshell.Run "net localgroup Administrators contoso\Admin9 /ADD", 0, true
	Case "SINGAPORE"
		wshshell.Run "net localgroup Administrators contoso\Admin10 /ADD", 0, true
	Case "CASABLANCA"
		wshshell.Run "net localgroup Administrators contoso\Admin11 /ADD", 0, true
	Case "TUNIS"
		wshshell.Run "net localgroup Administrators contoso\Admin12 /ADD", 0, true
	Case "ACAPULCO"
		wshshell.Run "net localgroup Administrators contoso\Admin13 /ADD", 0, true
	Case "MIAMI"
		wshshell.Run "net localgroup Administrators contoso\Admin14 /ADD", 0, true
	Case "AUCKLAND"
		wshshell.Run "net localgroup Administrators contoso\Admin15 /ADD", 0, true
	Case "SUVA"
		wshshell.Run "net localgroup Administrators contoso\Admin16 /ADD", 0, true
	Case "STOCKHOLM"
		wshshell.Run "net localgroup Administrators contoso\Admin17 /ADD", 0, true
	Case "MOSCOW"
		wshshell.Run "net localgroup Administrators contoso\Admin18 /ADD", 0, true
	Case "CARACAS"
		wshshell.Run "net localgroup Administrators contoso\Admin19 /ADD", 0, true
	Case "MONTEVIDEO"
		wshshell.Run "net localgroup Administrators contoso\Admin20 /ADD", 0, true
	Case "MANILA"
		wshshell.Run "net localgroup Administrators contoso\Admin21 /ADD", 0, true
	Case "TOKYO"
		wshshell.Run "net localgroup Administrators contoso\Admin22 /ADD", 0, true
	Case "KHARTOUM"
		wshshell.Run "net localgroup Administrators contoso\Admin23 /ADD", 0, true
	Case "NAIROBI"
		wshshell.Run "net localgroup Administrators contoso\Admin24 /ADD", 0, true
	Case Else
		wscript.Echo "Problem in CreateStudentUsers.vbs... the computer name did not match the any of the expected student computer names.  As a result, we could not add contoso\Admin## to the local administrators group.  We will add contoso\admin25 just for the hell of it."
		wshshell.Run "net localgroup Administrators contoso\Admin25 /ADD", 0, true
end select



' Set the local administrator's password to be blank
wshshell.Run "net user administrator """"", 0, true


