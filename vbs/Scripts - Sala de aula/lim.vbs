'// lgpmc.vbs
'//
'//
'// This script configures group policy for GPMC on London

Dim GPM       : Set GPM = CreateObject("GPMgmt.GPM")
Dim Constants : Set Constants = GPM.GetConstants()
Dim strBackupLocation
Dim szTargetGPO
Dim strDomainName
Dim GPMDomain
Dim GPMBackup

strBackupLocation = "C:\Program Files\Microsoft Training\2209\Labfiles\Setup\BACKUP POLICIES"
strDomainName = "nwtraders.msft"

' Initialize the Domain object
Set GPMDomain = GPM.GetDomain(strDomainName, "", Constants.UseAnyDC)


' Get the backed-up "Finance Restrictions" GPO
Set GPMBackup = GetBackup(strBackupLocation, "Finance Restrictions")
' Import the "Finance Restrictions" GPO
ImportFromBackup GPMBackup, "Finance Restrictions", GPMDomain

' Get the backed-up "Allow Registry Editing" GPO
Set GPMBackup = GetBackup(strBackupLocation, "Allow Registry Editing")
' Import the "Allow Registry Editing" GPO
ImportFromBackup GPMBackup, "Allow Registry Editing", GPMDomain

' Link the "Finance Restrictions" GPO to the "Finance" OU
LinkGPO GPMDomain, "OU=Finance,DC=nwtraders,DC=msft", "Finance Restrictions"

' Link the "Allow Registry Editing" GPO to the "Finance" OU
LinkGPO GPMDomain, "OU=Finance,DC=nwtraders,DC=msft", "Allow Registry Editing"




'// GetBackup
'//
'// Returns the Backed up GPO
Function GetBackup(strBackupLocation, strBackupName)

	Set GPMBackupDir = GPM.GetBackupDir(strBackupLocation)
	Set GPMSearchCriteria = GPM.CreateSearchCriteria()
	GPMSearchCriteria.Add Constants.SearchPropertyGPODisplayName, Constants.SearchOpEquals, cstr(strBackupName)
	Set BackupList = GPMBackupDir.SearchBackups(GPMSearchCriteria)
	Set GetBackup = BackupList.Item(1)

End Function


'// ImportFromBackup
'//
'// Imports the backed up GPO
' Imports settings from a backup into a GPO. If a target GPO name is specified, that name
' is used for the GPO that is imported into. If a single GPO with that name already exists,
' it is used. If no GPO with that name exists, a new one is created.
' Also, if a blank target name is specified, then the name from the backup is re-used.
Function ImportFromBackup(GPMBackup, szTargetGPOName, GPMDomain)

	Dim GPMGPO

	' Create the GPO     
	Set GPMGPO = GPMDomain.CreateGPO()
			
	' Now set the display name.
	GPMGPO.DisplayName = szTargetGPOName

	' Import the settings from the backup into the new GPO
	Set GPMResult = GPMGPO.Import(0, GPMBackup)

End Function


'// LinkGPO
'//
'// Links a GPO to an SOM
Function LinkGPO(GPMDomain, strSOMToLinkTo, strGPOToLink)

	Dim GPMGPOLink
	Dim GPMGPO
	Dim GPMSOM

	Set GPMSearchCriteria = GPM.CreateSearchCriteria()
	GPMSearchCriteria.Add Constants.SearchPropertyGPODisplayName, Constants.SearchOpEquals, cstr(strGPOToLink)

	Set GPOList = GPMDomain.SearchGPOs(GPMSearchCriteria)
	Set GPMGPO = GPOList.Item(1)
	Set GPMSOM = GPMDomain.GetSOM(strSOMToLinkTo)
	GPMSOM.CreateGPOLink -1, GPMGPO

End Function