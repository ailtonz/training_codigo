option explicit
dim serverName, DLL, SDOU, Result, askGUID, i, currentGPLIST
Dim WSHNetwork, objArgs, ADOconnObj, bstrADOQueryString, RootDom, RSObj
Dim FSMOobj,CompNTDS, Computer, Path, HelpText, objRootDSE, DNSPath

'Determine domain name
Set WSHNetwork = CreateObject("WScript.Network")
Set objArgs = WScript.Arguments
Set objRootDSE = GetObject("LDAP://RootDSE")
Path = objRootDSE.Get("defaultNamingContext")
Set ADOconnObj = CreateObject("ADODB.Connection")
ADOconnObj.Provider = "ADSDSOObject"
ADOconnObj.Open "ADs Provider"


' Determine PDC FSMO
bstrADOQueryString = "<LDAP://"&Path&">;(&(objectClass=domainDNS)(fSMORoleOwner=*));adspath;subtree"
Set RootDom = GetObject("LDAP://RootDSE")
Set RSObj = ADOconnObj.Execute(bstrADOQueryString)
Set FSMOobj = GetObject(RSObj.Fields(0).Value)
Set CompNTDS = GetObject("LDAP://" & FSMOobj.fSMORoleOwner)
Set Computer = GetObject(CompNTDS.Parent)
'Set DNSPath to the DNS name of the Domain
DNSPath = Right(Computer.dnsHostName, (Len(computer.dnsHostName) - (Len(Computer.cn) + 1)))

On Error Resume Next

'the IADSTOOLS com object that ships with the Support Tools has many
'functions that make it easier to retrieve data stored in the DS
'Set the serverName value to the name of the DC that is the PDC
serverName=Computer.cn

'instance the object
Set DLL=CreateObject("iadstools.dcfunctions")

'bind to the Site, Domain, or OU (SDOU) that you want to manage the links on
'specify the PDC name when doing this
Set SDOU=GetObject("LDAP://" & serverName & "/" & Path)

'call the IADSTOOLS function to enumerate the Group Policy Objects (GPOs)
Result=DLL.GetGPOs(CStr(DNSPath), CStr(serverName))



'If a positive number of GPOs is returned, than we can link a GPO to the selected SDOU
if Result > 0 then
	askGUID = "Software"
	
	if askGUID="" then
		'do nothing
	else
		'cycle through the GPOs we got back from IADSTOOLS and find the GPO the user
		'entered
		for i=1 to result
			'we drop both items being compared to lower case to rule out case
			if lcase(DLL.gponame(i))=lcase(askGUID) then
				'we found a match.  Determine the links that already exist, if any
				currentGPLIST=SDOU.get("gpLink")

				'construct a new link to add to the existing links
				currentGPLIST=currentGPLIST & "[LDAP://CN=" & DLL.gpoguid(i) & ",CN=Policies,CN=System," & DLL.getdefaultnamingcontext(CStr(serverName)) & ";0]"
				'write the new list back to the gpLink attribute on the SDOU
				SDOU.put "gpLink",currentGPLIST

				'commit the change
				SDOU.SetInfo

				'tell the user we completed successfully
				
				msgbox "The Troubleshooting Script Completed Successfully!"

				'only process the first one we come to that has the correct name
				Exit For
			end if
		next
	end if
end if
