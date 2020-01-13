on error resume next

 
Const UF_DONT_EXPIRE_PASSWD =&H10000

Dim Input
Dim InputChecker
Input = ""

Do until Input <>""

dim rootDSE
set rootDSE = GetObject("LDAP://RootDSE")
domainname=rootDSE.Get("defaultnamingcontext")

	usrName = "SQLService" 
	usrName2 = "SQLService"
	Set domain = GetObject("LDAP://" & domainname)
	set ou = domain.GetObject("container", "CN=Users" )

	set usr = ou.Create("user", "cn=" & usrName )
	usr.Put "samAccountName", usrName2
	usr.SetInfo

	set usr = GetObject("LDAP:// CN=" & usrName & ", CN=Users, "  & domainname)


	usr.AccountDisabled = FALSE


	usr.SetPassword "sqlservice"


	flag = usr.Get("UserAccountControl")
	newFlag = flag Or UF_DON'T_EXPIRE_PASSWD
	usr.Put "userAccountControl", newFlag


	usr.Put "pwdLastSet", CLng(-1)
	usr.SetInfo

Input = 24

InputChecker = CInt(Input)


	Dim Cont
	Dim OU
	Dim OUName
	Dim ServerName


For x = 1 to InputChecker

Select Case x
	Case 1 ServerName="Vancouver"
	Case 2 ServerName="Denver"
	Case 3 ServerName="Perth"
	Case 4 ServerName="Brisbane"
	Case 5 ServerName="Lisbon"
	Case 6 ServerName="Bonn"
	Case 7 ServerName="Lima"
	Case 8 ServerName="Santiago"
	Case 9 ServerName="Bangalore"
	Case 10 ServerName="Singapore"
	Case 11 ServerName="Casablanca"
	Case 12 ServerName="Tunis"
	Case 13 ServerName="Acapulco"
	Case 14 ServerName="Miami"
	Case 15 ServerName="Auckland"
	Case 16 ServerName="Suva"
	Case 17 ServerName="Stockholm"
	Case 18 ServerName="Moscow"
	Case 19 ServerName="Caracas"
	Case 20 ServerName="Montevideo"
	Case 21 ServerName="Manila"
	Case 22 ServerName="Tokyo"
	Case 23 ServerName="Khartoum"
	Case 24 ServerName="Nairobi"
End Select

	OUName = ServerName
	Set cont = GetObject("LDAP://" & domainname)
	Set OU = cont.Create("organizationalUnit", "OU=" & OUName)
	OU.SetInfo

	Set cont = GetObject("LDAP://OU=" & OUName & "," & domainname)
	Set OU = cont.Create("organizationalUnit", "OU=SQL Administrators")
	OU.SetInfo

	OUName = ServerName
	usrName = "SQLAdmin" & x
	usrName2 = "SQLAdmin" & x
	Set domain = GetObject("LDAP://OU=" & ServerName & "," & domainname)
	set ou = domain.GetObject("organizationalUnit", "OU=SQL Administrators" )

	set usr = ou.Create("user", "cn=" & usrName )
	usr.Put "samAccountName", usrName2
	usr.SetInfo

	set usr = GetObject("LDAP:// CN=" & usrName & ", OU=SQL Administrators, OU=" & ServerName & "," & domainname)

	usr.FirstName = "SQL"
	usr.LastName = "Admin" & x
	usr.AccountDisabled = FALSE
	usr.SetPassword "password"

	flag = usr.Get("UserAccountControl")
	newFlag = flag Or UF_DON'T_EXPIRE_PASSWD
	usr.Put "userAccountControl", newFlag

	usr.Put "pwdLastSet", CLng(-1)
	usr.SetInfo


Next

loop


