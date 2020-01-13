' Create.vbs File (To be placed in C:\)
wscript.echo "This script creates the OUs and Users for Deploying the Microsoft Business Desktop Experience", Chr(10), "Please wait until the script has finished executing before continuing with the Setup", Chr(10), "Please click OK to continue."
'Script to create users in the Active Directory

' Determine the LDAP path for your domain
Set Root = GetObject("LDAP://RootDSE")
DomainPath = Root.Get("DefaultNamingContext")
Set Domain = GetObject("LDAP://" & DomainPath)

Set WshShell = Wscript.CreateObject("Wscript.Shell")
Set WshSysEnv = WshShell.Environment("Process")
upnDomain = WshSysEnv("USERDOMAIN")

' Create Top Level OUs
Set ouAdmin = Domain.Create("organizationalUnit", "OU=Admin")
ouAdmin.Put "Description", "Admin"
ouAdmin.SetInfo

Set ouSales = Domain.Create("organizationalUnit", "OU=Sales")
ouSales.Put "Description", "Sales"
ouSales.SetInfo

Set ouMarketing = Domain.Create("organizationalUnit", "OU=Marketing")
ouMarketing.Put "Description", "Marketing"
ouMarketing.SetInfo

wscript.echo "OUs created. Now creating users.", Chr(10), "Please click OK to continue."

'Create users in the Top Level OUs

Set usr = ouAdmin.Create("user", "CN=Davidr")
usr.Put "samAccountName", "Davidr"
usr.Put "userPrincipalName", "Davidr" & "@" & ".hotlabs.msft"
usr.Put "userAccountControl", "0020"
usr.SetInfo
usr.SetPassword "password"

Set usr = ouSales.Create("user", "CN=Mikea")
usr.Put "samAccountName", "Mikea"
usr.Put "userPrincipalName", "Mikea" & "@" & ".hotlabs.msft"
usr.Put "userAccountControl", "0020"
usr.SetInfo
usr.SetPassword "password"

Set usr = ouMarketing.Create("user", "CN=Seanb")
usr.Put "samAccountName", "Seanb"
usr.Put "userPrincipalName", "Seanb" & "@" & ".hotlabs.msft"
usr.Put "userAccountControl", "0020"
usr.SetInfo
usr.SetPassword "password"


wscript.echo "Active Directory Structure Created", Chr(10), "Please click OK to finish.", Chr(10), "You may now proceed with the Setup."
