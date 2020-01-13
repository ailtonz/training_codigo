'--------------------------------------------------------------------------
'---  Script skeleton to be used for removing ACE's from AD in 2299 Course
'--------------------------------------------------------------------------

'This script is used to set security rights for the DL location OU Administrators group
'to full control for their location


Dim x 
Dim sd 
Dim acl
Dim Ace1
Dim container
'Container=Array("Bonn","Bangalore","Acapulco","Auckland")


Container=Array("Glasgow","Vancouver","Denver","Perth","Brisbane","Lisbon","Bonn","Lima","Santiago","Singapore","Bangalore","Casablanca","Tunis","Acapulco","Miami","Auckland","Suva","Stockholm","Moscow","Caracas","Montevideo","Manila","Tokyo","Khartoum","Nairobi")

'----Setup the loop to enum the locations
For each z in Container
	'----Bind x to the target container

	Set x = GetObject("LDAP://ou=" & z & ",ou=Locations,dc=Corp,dc=nwtraders,dc=msft")
'wscript.echo z

	'----Bind sd to the security descriptor
	set sd = x.Get("ntSecurityDescriptor")

	'----Bind Ace1 to ACE object
	Set Ace1 = CreateObject("AccessControlEntry")
	Set dacl = CreateObject("AccessControlList")

	'----Bind dacl to the DACL
	Set dacl=sd.DiscretionaryAcl
	
	'----Set the properties of the ACE we are interested in
	Ace1.AccessMask = 983551
	Ace1.AceType = 0
	Ace1.AceFlags = 2		' This object and all child objects
	Ace1.Trustee = "CORP\DL " & z & " OU Administrators"

	'----Set the dacl to the new ACE
	dacl.AddAce Ace1
	sd.DiscretionaryAcl = dacl


	'Commit the changes 
	x.Put "ntSecurityDescriptor", sd
	x.SetInfo
Next

