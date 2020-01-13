'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Script to delete users from in Active Directory
' 
' This script reads user names and attributes from the file called remove.txt
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
wscript.echo "Script starting. Please click OK to continue."

DIM arrRecord
Const ForReading = 1

''''''''''''''''''''''''''''''''''''''''''
' Determine the LDAP path for your domain
' Nothing in this section needs to be customized
''''''''''''''''''''''''''''''''''''''''''
Set Root = GetObject("LDAP://RootDSE")
DomainPath = Root.Get("DefaultNamingContext")

''''''''''''''''''''''''''''''''''''''''
' Get the pointer to your domain object
' Nothing in this section needs to be customized
''''''''''''''''''''''''''''''''''''''''
Set Domain = GetObject("LDAP://" & DomainPath)


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' The file system object is your entry point into the file system
' Nothing in this section needs to be customized
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
set fso = CreateObject ("Scripting.FileSystemObject")

''''''''''''''''''''''''''''''''''''''''''''''''''''
' Get the object to the C:\ADSI\remove.txt text file
' Name and location of the text file can be changed
''''''''''''''''''''''''''''''''''''''''''''''''''''
Set tsTextFile = fso.OpenTextFile ("C:\ADSI\remove.txt", ForReading, False)

'''''''''''''''''''''''''''''''''''''''''''''''''
' Get the object to the Human Resources OU
' You would need to customize the OU name/path
'''''''''''''''''''''''''''''''''''''''''''''''''

Set ou_Current = GetObject("LDAP://OU=Human Resources, " & DomainPath)

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Begin reading the input file and loop until you reach EOF
' Read a line in the file
' Nothing in this section needs to be customized
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

While Not tsTextFile.AtEndOfStream    ' START OF LOOP

 strRecord = tsTextFile.ReadLine

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Parse the line into string segments using the colon as a delimiter
'
' (You can change the delimiter.)
'
' Put each string segment into an array named arrRecord
'
' The first string segment is referenced as arrRecord(0)
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 arrRecord = Split (strRecord, ":")
 
'''''''''''''''''''''''''''''''''''
' Find the user in the Human Resources OU
' Not that the username is retrieved from the first (0) field
' Nothing in this section needs to be customized
'''''''''''''''''''''''''''''''''''
 Set adsUser = ou_Current.GetObject("user", "CN=" & arrRecord(0))

'''''''''''''''''''''''''''''''''''''''''''''''''''''
' Delete the user account from the OU
'
' Nothing in this section needs to be customized
'''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 ou_Current.Delete "user", adsUser.Name
 
'''''''''''''''''''''''''''''''''''''''''''''''''''''
' SetInfo flushes the attributes in cache to disk
' Reset adsUser in preparation for the next user object
' Close the text file adsUser.SetInfo
'
' Nothing in this section needs to be customized
'''''''''''''''''''''''''''''''''''''''''''''''''''''

 Set adsUser = Nothing
Wend                                   ' END OF LOOP

tsTextFile.Close

wscript.echo "Users deleted.", Chr(10),Chr(10),"Please click OK to finish."
