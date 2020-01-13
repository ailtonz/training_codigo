Option Explicit
Dim aCon, aCmd, aRst, sResultText
Set aCon = CreateObject("ADODB.Connection") 
Set aCmd = CreateObject("ADODB.Command") 
aCon.Provider = "ADsDSOObject"  
aCon.Open 	
aCmd.ActiveConnection = aCon 	
aCmd.CommandText = "<LDAP://OU=WST,DC=NWTraders,DC=msft>;" _
	& "(objectClass=user);name,SamAccountName,givenName," _
	& "sN,telephonenumber;subTree"
Set aRst = aCmd.Execute() 
Do While Not aRst.EOF 
	sResultText = sResultText _
		& aRst.Fields("samaccountname") _
		& ", " & aRst.Fields("givenname") _
		& ", " 	& aRst.Fields("sN") _
		& ", " & aRst.Fields("telephonenumber") _
		& vbCRLF
	aRst.MoveNext 
Loop
WScript.Echo sResultText