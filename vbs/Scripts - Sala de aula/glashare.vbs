option explicit
dim wshshell,fso,curdir,pword,done,f,strUser,objUser
pword = "P@ssw0rd"
set wshshell = wscript.createobject("wscript.shell")
set fso = createobject("scripting.filesystemobject")
curdir = wshshell.currentdirectory
set f = fso.OpenTextFile(curdir & "\corpuser.txt",1)
done = 0
while done = 0
	strUser = f.readline
	if strUser = "EndAdmin" then
		done = 1
	else
		set objUser=GetObject("LDAP://cn=" & strUser & ",OU=IT Users,OU=IT Admin,dc=Corp,dc=nwtraders,dc=msft")
		objUser.setPassword pword
		objUser.AccountDisabled = False
		objUser.Put "pwdLastSet", 0
		objUser.SetInfo
		end if
wend
done = 0
while done = 0
	strUser = f.readline
	if strUser = "end" then
		done = 1
	else
		set objUser=GetObject("LDAP://cn=" & strUser & ",CN=Users,dc=Corp,dc=nwtraders,dc=msft")
		objUser.setPassword pword
		objUser.AccountDisabled = False
		objUser.Put "pwdLastSet", 0
		objUser.SetInfo
		end if
wend

done = 25
while done < 100
	set objUser=getObject("WinNT://corp/user00" & done & ",user")
	objUser.setPassword pword
	objUser.AccountDisabled = False
	objUser.Put "PasswordExpired", 1
	objUser.SetInfo
	done = done + 1
wend
done = 100
while done < 1000
	set objUser=getObject("WinNT://corp/user0" & done & ",user")
	objUser.setPassword pword
	objUser.AccountDisabled = False
	objUser.Put "PasswordExpired", 1
	objUser.SetInfo
	done = done + 1
wend
done = 1000
while done < 2452
	set objUser=getObject("WinNT://corp/user" & done & ",user")
	objUser.setPassword pword
	objUser.AccountDisabled = False
	objUser.Put "PasswordExpired", 1
	objUser.SetInfo
	done = done + 1
wend
