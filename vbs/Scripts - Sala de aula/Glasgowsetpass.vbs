'This script is executed during the setup phase calling for
'the IT Groups OU to have the ACL modified so that the appropriate
'admin has the "Managed By" property and can update the member list



const ADS_RIGHT_DS_WRITE_PROP = &H20
const ADS_ACETYPE_ACCESS_ALLOWED_OBJECT = &H5
const ADS_ACEFLAG_NONE = &H0
const ADS_FLAG_OBJECT_TYPE_PRESENT = &H1

'Container=Array("G BonnAdmins","G BangaloreAdmins","G AcapulcoAdmins","G AucklandAdmins")

Container=Array("G GlasgowAdmins","G VancouverAdmins","G DenverAdmins","G PerthAdmins","G BrisbaneAdmins","G LisbonAdmins","G BonnAdmins","G LimaAdmins","G SantiagoAdmins","G BangaloreAdmins","G SingaporeAdmins","G CasablancaAdmins","G TunisAdmins","G AcapulcoAdmins","G MiamiAdmins","G AucklandAdmins","G SuvaAdmins","G StockholmAdmins","G MoscowAdmins","G CaracasAdmins","G MontevideoAdmins","G ManilaAdmins","G TokyoAdmins","G KhartoumAdmins","G NairobiAdmins")

 
const WRITE_MEMBERS_GUID = "{bf9679c0-0de6-11d0-a285-00aa003049e2}"
'const ADMINISTRATOR_SID = "S-1-5-21-599447635-340806436-2569744974-500"
'const GROUP_MANAGER = "CORP.NWTRADERS\AcapulcoAdmin"

For each z in Container
	'wscript.echo z

	Set oTarget = GetObject( "LDAP://cn=" & z & ",ou=IT Groups,ou=IT Admin,dc=corp,dc=nwtraders,dc=msft")
	
	posA=InStr(1, z, "G")+2
	posB=InStrRev(z, "s")
	substr=Mid(z, posA, posB - posA)
	'WScript.echo "Extracted :" & substr
	'WScript.Echo "Attempting to bind to object " & oArgs(0)
	 
'	'WScript.Echo "Reading security descriptor"
	Set oSD = oTarget.Get( "ntSecurityDescriptor" )
	Set oACL = oSD.DiscretionaryAcl
	oTarget.Put "ManagedBy", "cn=" & substr & ",ou=it users,ou=it admin,dc=corp,dc=nwtraders,dc=msft"
 
'	WScript.Echo "Creating new ACE & setting properties"
	Set oACE = CreateObject( "AccessControlEntry" )
 
	oACE.AccessMask = ADS_RIGHT_DS_WRITE_PROP
	oACE.AceType = ADS_ACETYPE_ACCESS_ALLOWED_OBJECT
	oACE.AceFlags = ADS_ACEFLAG_NONE
	oACE.Flags = ADS_FLAG_OBJECT_TYPE_PRESENT
	oACE.ObjectType = WRITE_MEMBERS_GUID
	'oACE.Trustee = ADMINISTRATOR_SID
	oACE.Trustee = "CORP\" & substr
 
'	WScript.Echo "Applying modified security descriptor to object"
	oACL.AddAce oACE
	oSD.DiscretionaryAcl = oAcl
	oTarget.Put "ntSecurityDescriptor", oSD
	oTarget.SetInfo
'	WScript.Echo "Done!"
Next
