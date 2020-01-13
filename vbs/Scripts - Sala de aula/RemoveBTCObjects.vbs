wscript.echo "This script DELETES the OUs and Users for the lab in this module.", Chr(10), "Please wait until the script has finished.", Chr(10), "Please click OK to continue."
'**************************************************
'Script to delete the Compensation OU in the Active Directory
'**************************************************

'**************************************************
' Determine the LDAP path for your domain
'**************************************************
Set jRoot = GetObject("LDAP://RootDSE")
DomainPath = jRoot.Get("DefaultNamingContext")
Set Domain = GetObject("LDAP://" & DomainPath)

Set WshShell = Wscript.CreateObject("Wscript.Shell")
Set WshSysEnv = WshShell.Environment("Process")
upnDomain = WshSysEnv("USERDOMAIN")

'**************************************************
' Delete the HR OU
'**************************************************

Set jac = Domain.GetObject("organizationalUnit", "OU=Human Resources")
jac.DeleteObject(0)



wscript.echo "The Active Directory Structure has been deleted", Chr(10), "Please click OK to finish.", Chr(10), ""
