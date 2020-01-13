' DHCPadmin.vbs
'
' This script creates the DHCP Administrator Account

'--Set the LDAP path for the domain
Set Root = GetObject("LDAP://RootDSE")
DomainPath = Root.Get("DefaultNamingContext")
Set Domain = GetObject("LDAP://" & DomainPath)
Set UsrContainer = Domain.GetObject("container", "CN=Users")

'--Create a Student Administrator account
Set usr = UsrContainer.Create("user", "CN=DHCPAdmin")
usr.Put "samAccountName", "DHCPAdmin"
usr.Put "userPrincipalName", "DHCPAdmin@nwtraders.msft" 
usr.Put "givenName", "DHCPAdmin"
usr.Put "displayName", "DHCPAdmin"
usr.SetInfo

'--Set Group Memberships
Dim Grp
Dim Usr
Set Grp = GetObject("WinNT://nwtraders.msft/Domain Admins,group")
Set Usr = GetObject("WinNT://nwtraders.msft/DHCPAdmin,user")
Grp.Add(Usr.ADsPath)


'--Now that the user is created, reset the user's password and
'--enable its account
usr.SetPassword "P@ssw0rd"
usr.AccountDisabled = False
usr.SetInfo