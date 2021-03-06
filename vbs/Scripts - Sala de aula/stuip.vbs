'// stugp.vbs
'//
'//
'// This script configures the group policy settings on the Student computers

Dim GPM       : Set GPM = CreateObject("GPMgmt.GPM")
Dim Constants : Set Constants = GPM.GetConstants()
Dim strBackupLocation
Dim szTargetGPO
Dim strDomainName
Dim strFullDomainName
Dim GPMDomain
Dim GPMBackup

strBackupLocation = "C:\MOC\SETUP\2209 Policy Backups"
strDomainName = GetDomainName()
strFullDomainName = strDomainName & ".msft"

' Initialize the Domain object
Set GPMDomain = GPM.GetDomain(strFullDomainName, "", Constants.UseAnyDC)


' Get the backed-up "Default Domain Controllers Policy" GPO
Set GPMBackup = GetBackup(strBackupLocation, "Default Domain Controllers Policy")
' Import the "Default Domain Controllers Policy" GPO
ImportFromBackup GPMBackup, "Default Domain Controllers Policy", GPMDomain

' Get the backed-up "Default Domain Policy" GPO
Set GPMBackup = GetBackup(strBackupLocation, "Default Domain Policy")
' Import the "Default Domain Policy" GPO
ImportFromBackup GPMBackup, "Default Domain Policy", GPMDomain


' Run gpupdate to make sure the Group Policy settings take effect
Set WSHShell = WScript.CreateObject("wscript.shell")
WshShell.run "C:\WINDOWS\system32\gpupdate", 6, true



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
Function ImportFromBackup(GPMBackup, szTargetGPOName, GPMDomain)

	Dim GPMGPO

	' Get the existing GPO
	Set GPMSearchCriteria = GPM.CreateSearchCriteria()
	GPMSearchCriteria.Add Constants.SearchPropertyGPODisplayName, Constants.SearchOpEquals, cstr(szTargetGPOName)
	Set GPOList = GPMDomain.SearchGPOs(GPMSearchCriteria)
	Set GPMGPO = GPOList.Item(1)

	' Import the settings from the backup into the existing GPO
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


'// EnforceLink
'//
'// Enforces the GPO Link
Function EnforceLink(GPMDomain, strSOM, strLinkToEnforce)

	Dim GPMGPO
	Dim GPMSOM
	Dim GPMGPOLink
	Dim GPMGPOLinkList

	Set GPMSOM = GPMDomain.GetSOM(strSOM)
	Set GPMGPOLinkList = GPMSOM.GetGPOLinks()
	Set GPMGPOLink = GPMGPOLinkList.Item(2)
	GPMGPOLink.Enforced = True

End Function


'// GetDomainName
'//
'// Determines the domain name from the IP Address
Function GetDomainName()

	Set IPConfigSet = GetObject("winmgmts:").ExecQuery ("select IPAddress from Win32_NetworkAdapterConfiguration where IPenabled=TRUE and DHCPEnabled=FALSE")
	for each j in IpConfigSet
	   if Not IsNull(j.ipaddress) then
	      ipAddr = j.ipaddress(i)
	      pos = InStrRev(ipAddr, ".")
	      strDomainNum = Mid(ipAddr, pos + 1)
	      GetDomainName = "nwtraders" & strDomainNum
	   end if
	next

End Function