on error resume next	

dim rootDSE
set rootDSE = GetObject("LDAP://RootDSE")
domainname=rootDSE.Get("defaultnamingcontext")


	grpName = "OUAdmins"
	Set domain = GetObject("LDAP://" & domainname)
	set ou = domain.GetObject("Container", "CN=Users" )
	set grp = ou.Create("group", "cn=" & grpName )
	grp.Put "samAccountName", grpName
	grp.SetInfo


CnName = "Users"
grpName = "OUAdmins"

Set domain = GetObject("LDAP://" & domainname)
set ou = domain.GetObject("container", "CN=" & CnName )

set grp = ou.GetObject("group", "CN=" & grpName )

usrName = "Admin01" 
ServerName = "Vancouver OU"
set usr = GetObject("LDAP:// CN=" & usrName & ", OU=" & ServerName & "," & domainname)
grp.Add usr.AdsPath

usrName = "Admin02" 
ServerName = "Denver OU"
set usr = GetObject("LDAP:// CN=" & usrName & ", OU=" & ServerName & "," & domainname)
grp.Add usr.AdsPath

usrName = "Admin03" 
ServerName = "Perth OU"
set usr = GetObject("LDAP:// CN=" & usrName & ", OU=" & ServerName & "," & domainname)
grp.Add usr.AdsPath

usrName = "Admin04" 
ServerName = "Brisbane OU"
set usr = GetObject("LDAP:// CN=" & usrName & ", OU=" & ServerName & "," & domainname)
grp.Add usr.AdsPath

usrName = "Admin05" 
ServerName = "Lisbon OU"
set usr = GetObject("LDAP:// CN=" & usrName & ", OU=" & ServerName & "," & domainname)
grp.Add usr.AdsPath

usrName = "Admin06" 
ServerName = "Bonn OU"
set usr = GetObject("LDAP:// CN=" & usrName & ", OU=" & ServerName & "," & domainname)
grp.Add usr.AdsPath

usrName = "Admin07" 
ServerName = "Lima OU"
set usr = GetObject("LDAP:// CN=" & usrName & ", OU=" & ServerName & "," & domainname)
grp.Add usr.AdsPath

usrName = "Admin08" 
ServerName = "Santiago OU"
set usr = GetObject("LDAP:// CN=" & usrName & ", OU=" & ServerName & "," & domainname)
grp.Add usr.AdsPath

usrName = "Admin09" 
ServerName = "Bangalore OU"
set usr = GetObject("LDAP:// CN=" & usrName & ", OU=" & ServerName & "," & domainname)
grp.Add usr.AdsPath

usrName = "Admin10" 
ServerName = "Singapore OU"
set usr = GetObject("LDAP:// CN=" & usrName & ", OU=" & ServerName & "," & domainname)
grp.Add usr.AdsPath

usrName = "Admin11" 
ServerName = "Casablanca OU"
set usr = GetObject("LDAP:// CN=" & usrName & ", OU=" & ServerName & "," & domainname)
grp.Add usr.AdsPath

usrName = "Admin12" 
ServerName = "Tunis OU"
set usr = GetObject("LDAP:// CN=" & usrName & ", OU=" & ServerName & "," & domainname)
grp.Add usr.AdsPath

usrName = "Admin13" 
ServerName = "Acapulco OU"
set usr = GetObject("LDAP:// CN=" & usrName & ", OU=" & ServerName & "," & domainname)
grp.Add usr.AdsPath

usrName = "Admin14" 
ServerName = "Miami OU"
set usr = GetObject("LDAP:// CN=" & usrName & ", OU=" & ServerName & "," & domainname)
grp.Add usr.AdsPath

usrName = "Admin15" 
ServerName = "Auckland OU"
set usr = GetObject("LDAP:// CN=" & usrName & ", OU=" & ServerName & "," & domainname)
grp.Add usr.AdsPath

usrName = "Admin16" 
ServerName = "Suva OU"
set usr = GetObject("LDAP:// CN=" & usrName & ", OU=" & ServerName & "," & domainname)
grp.Add usr.AdsPath

usrName = "Admin17" 
ServerName = "Stockholm OU"
set usr = GetObject("LDAP:// CN=" & usrName & ", OU=" & ServerName & "," & domainname)
grp.Add usr.AdsPath

usrName = "Admin18" 
ServerName = "Moscow OU"
set usr = GetObject("LDAP:// CN=" & usrName & ", OU=" & ServerName & "," & domainname)
grp.Add usr.AdsPath

usrName = "Admin19" 
ServerName = "Caracas OU"
set usr = GetObject("LDAP:// CN=" & usrName & ", OU=" & ServerName & "," & domainname)
grp.Add usr.AdsPath

usrName = "Admin20" 
ServerName = "Montevideo OU"
set usr = GetObject("LDAP:// CN=" & usrName & ", OU=" & ServerName & "," & domainname)
grp.Add usr.AdsPath

usrName = "Admin21" 
ServerName = "Manila OU"
set usr = GetObject("LDAP:// CN=" & usrName & ", OU=" & ServerName & "," & domainname)
grp.Add usr.AdsPath

usrName = "Admin22" 
ServerName = "Tokyo OU"
set usr = GetObject("LDAP:// CN=" & usrName & ", OU=" & ServerName & "," & domainname)
grp.Add usr.AdsPath

usrName = "Admin23" 
ServerName = "Khartoum OU"
set usr = GetObject("LDAP:// CN=" & usrName & ", OU=" & ServerName & "," & domainname)
grp.Add usr.AdsPath

usrName = "Admin24" 
ServerName = "Nairobi OU"
set usr = GetObject("LDAP:// CN=" & usrName & ", OU=" & ServerName & "," & domainname)
grp.Add usr.AdsPath
