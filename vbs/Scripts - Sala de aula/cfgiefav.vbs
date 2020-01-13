'Enable guest account

Dim myUser
Dim userClass
Dim property

Set myUser = GetObject("WinNT://london/guest,user")
Set userClass = GetObject(myUser.Schema)

myUser.AccountDisabled = False
myUser.SetInfo