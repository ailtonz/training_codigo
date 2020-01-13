' Determine the LDAP path for your domain
On error resume next

Set Root = GetObject("LDAP://RootDSE")
DomainPath = Root.Get("DefaultNamingContext")
Set Domain = GetObject("LDAP://" & DomainPath)

Set acctOU = Domain.GetObject("organizationalUnit" , "OU=Accounting")
Set apOU = acctOU.GetObject("organizationalUnit" , "OU=Accounts Payable")
Set arOU = acctOU.GetObject("organizationalUnit" , "OU=Accounts Receivable")

Set salesOU = Domain.GetObject("organizationalUnit" , "OU=Sales")
Set tmktOU = salesOU.GetObject("organizationalUnit" , "OU=Telemarketing")
Set rtlOU = salesOU.GetObject("organizationalUnit" , "OU=Retail")

Set isOU = Domain.GetObject("organizationalUnit" , "OU=Information Services")
Set csOU = isOU.GetObject("organizationalUnit" , "OU=Customer Support")
Set devOU = isOU.GetObject("organizationalUnit" , "OU=Development")
Set hdOU = isOU.GetObject("organizationalUnit" , "OU=Help Desk")



' Delete OUs

domain.delete "organizationalUnit" , "OU=Sales"
domain.delete "organizationalUnit" , "OU=Administration"
domain.delete "organizationalUnit" , "OU=Production"
domain.delete "organizationalUnit" , "OU=Servers"

apOU.delete "user" , "CN=AP User"
arOU.delete "user" , "CN=AR User"
acctOU.delete "organizationalUnit" , "OU=Accounts Payable"
acctOU.delete "organizationalUnit" , "OU=Accounts Receivable"

acctOU.delete "user" , "CN=Accounting Admin"
acctOU.delete "user" , "CN=Accounting User"
acctOU.delete "user" , "CN=Application User"

domain.delete "organizationalUnit" , "OU=Accounting"

tmktOU.delete "user" , "CN=Telemarketing User"
rtlOU.delete "user" , "CN=Retail User"

salesOU.delete "organizationalUnit" , "OU=Telemarketing"
salesOU.delete "organizationalUnit" , "OU=Retail"
salesOU.delete "user" , "CN=Sales User"

domain.delete "organizationalUnit" , "OU=Sales"

csOU.delete "user" , "CN=CSUser"
devOU.delete "user" , "CN=DUser"
hdOU.delete "user" , "CN=HDUser"

isOU.delete "organizationalUnit" , "OU=Customer Support"
isOU.delete "organizationalUnit" , "OU=Development"
isOU.delete "organizationalUnit" , "OU=Help Desk"

isOU.delete "user" , "CN=ISAdmin"

domain.delete "organizationalUnit", "OU=Information Services"


