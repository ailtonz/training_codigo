'Add local user and group accounts

Dim Users, Groups, wshShell, wshNet, i, sName, group

Set wshNet = CreateObject("WScript.Network")
sName = UCase(wshNet.ComputerName)
If sName = "LONDON" Then
	Users = Array("Instructor", "P@ssw0rd", "Student", "P@ssw0rd")
Else
	Users = Array("Student", "P@ssw0rd")
End If

set wshshell = wscript.CreateObject("wscript.shell")

set myComp = GetObject("WinNT://" & sname)

for i = 0 to ubound(Users) step 2
	'wshshell.Run "net user " & Users(i) & " " & Users(i+1) & " /ADD /FULLNAME:" & Users(i) & " /EXPIRES:NEVER /PASSWORDCHG:NO", 0, true
	set myUser = myComp.Create("user", Users(i))
	myUser.SetPassword Users(i+1)
	myUser.SetInfo
	myUser.Put "UserFlags", 66113
	myUser.SetInfo
	set myUser = nothing
	wshShell.Run "net localgroup """ & "Administrators" & """ " & Users(i) & " /ADD", 0, TRUE
next