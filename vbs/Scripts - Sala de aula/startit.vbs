'The Strater.vbs file creates the following: 
'Sample Src Org
'Sample1 Org
'Sample2 Org
'Sample Outbound Def
'Sample Inbound Def
'Sample1 Port
'Sample2 Port
'
'-----------------------------------------------------------------------------------  
    'Object variables
    Dim objConfig, objOrganization, objDocument, objPort, objPort2, objDocument2, objOrganization2, objOrganization3
    Dim objADO
	
 
'-----------------------------------------------------------------------------------   

'------------------------------------------------------------------------------------

	Const BIZTALK_TRANSPORT_TYPE_FILE = 256

    'Server Name
     strServerName = SetGetEnvVar("PROCESS", "COMPUTERNAME", "localhost", False)
'------------------------------------------------------------------------------------

'Database  variables
    Dim idSourceOrg, idSourceAlias, idDocument, idDocument2,iddestOrg, iddestAlias, iddestOrg2,     iddestAlias2, idPort,idPort2

'   Create the configuration object. This is the root object by which all other 
'   objects are created.

    Set objConfig = CreateObject("BizTalk.BizTalkConfig")
    If err.number <> 0 then Wscript.Echo "[FAIL] Failed Creating Config Object with error - " & err.description

   Set objOrganization = objConfig.CreateOrganization()
    
'------------------------------------------------------------------------------------
'   Create the source organization and obtain its 
'------------------------------------------------------------------------------------
    objOrganization.Name = "Sample Src Org"
    idSourceOrg = objOrganization.Create

'   Check to see if the organization already exists, then clear the error, load
'   the existing , and continue
'------------------------------------------------------------------------------------
    
    if err.number = -1061154272 then 
    	Set objADO = objConfig.Organizations
    	
    	do while not objADO.EOF
    	    if objADO.fields("Name").Value = "Sample Src Org" then
    		idSourceOrg = objADO.fields("id").Value
    		objOrganization.Load idSourceOrg
    		exit do
    	    end if
    	   objADO.MoveNext
    	loop
    	err.clear
    end if
    	
    If err.number <> 0 then 
        Wscript.Echo "[FAIL] Failed Creating Source Organization with error - " & err.description
        Wscript.Quit
    else
    	Wscript.Echo "[PASS] Successfully Created Source Organization with  - " & idSourceOrg
    End If
    
    idSourceAlias = objOrganization.GetDefaultAlias()

     Set objOrganization2 = objConfig.CreateOrganization()
    
'------------------------------------------------------------------------------------
'   Create the source organization and obtain its 
'------------------------------------------------------------------------------------
    objOrganization2.Name = "Sample1 Org"
    iddestOrg = objOrganization2.Create

'   Check to see if the organization already exists, then clear the error, load
'   the existing , and continue
'------------------------------------------------------------------------------------
    
    if err.number = -1061154272 then 
    	Set objADO = objConfig.Organizations
    	
    	do while not objADO.EOF
    	    if objADO.fields("Name").Value = "Sample1 Org" then
    		iddestOrg = objADO.fields("id").Value
    		objOrganization2.Load iddestOrg
    		exit do
    	    end if
    	   objADO.MoveNext
    	loop
    	err.clear
    end if
    	
    If err.number <> 0 then 
        Wscript.Echo "[FAIL] Failed Creating Source Organization with error - " & err.description
        Wscript.Quit
    else
    	Wscript.Echo "[PASS] Successfully Created Source Organization with  - " & iddestOrg
    End If
    
    iddestAlias = objOrganization2.GetDefaultAlias()


Set objOrganization3 = objConfig.CreateOrganization()
    
'------------------------------------------------------------------------------------
'   Create the source organization and obtain its 
'------------------------------------------------------------------------------------
    objOrganization3.Name = "Sample2 Org"
    iddestOrg2 = objOrganization3.Create

'   Check to see if the organization already exists, then clear the error, load
'   the existing , and continue
'------------------------------------------------------------------------------------
    
    if err.number = -1061154272 then 
    	Set objADO = objConfig.Organizations
    	
    	do while not objADO.EOF
    	    if objADO.fields("Name").Value = "Sample2 Org" then
    		iddestOrg2 = objADO.fields("id").Value
    		objOrganization3.Load iddestOrg2
    		exit do
    	    end if
    	   objADO.MoveNext
    	loop
    	err.clear
    end if
    	
    If err.number <> 0 then 
        Wscript.Echo "[FAIL] Failed Creating Source Organization with error - " & err.description
        Wscript.Quit
    else
    	Wscript.Echo "[PASS] Successfully Created Source Organization with  - " & iddestOrg2
    End If
    
    iddestAlias2 = objOrganization3.GetDefaultAlias()



	Set objOrganization = Nothing
	Set objOrganization2 = Nothing
	Set objOrganization3 = Nothing
'------------------------------------------------------------------------------------
Set objDocument = objConfig.CreateDocument()
    
'------------------------------------------------------------------------------------
'   Create the CommonInvoice document
'------------------------------------------------------------------------------------
    objDocument.Name = "Sample Outbound Def"
    objDocument.Reference = "http://" & strServerName & "/BiztalkServerRepository/DocSpecs/Microsoft/CommonInvoice.xml"
    idDocument = objDocument.Create
    
'------------------------------------------------------------------------------------
'  Check to see if document already exists. If found, clear the error and continue
'------------------------------------------------------------------------------------
    if err.number = -1061154262 then 
    	Set objADO = objConfig.Documents
    	
    	do while not objADO.EOF
    	    if objADO.fields("Name").Value = "Sample Outbound Def" then
    		idDocument = objADO.fields("id").Value
    		exit do
    	    end if
    	   objADO.MoveNext
    	loop
    	err.clear
    end if
    
    If err.number <> 0 then 
        Wscript.Echo "[FAIL] Failed Creating Document with error - " & err.description
        Wscript.Quit        
    else
    	Wscript.Echo "[PASS] Successfully Created Document with  - " & idDocument
    End If    
    
    Set objDocument = Nothing
    
'------------------------------------------------------------------------------------    


Set objDocument2 = objConfig.CreateDocument()
    
'------------------------------------------------------------------------------------
'   Create the CommonInvoice document
'------------------------------------------------------------------------------------
    objDocument2.Name = "Sample Inbound Def"
    objDocument2.Reference = "http://" & strServerName & "/BiztalkServerRepository/DocSpecs/Microsoft/CommonPO.xml"
    idDocument2 = objDocument2.Create
    
'------------------------------------------------------------------------------------
'  Check to see if document already exists. If found, clear the error and continue
'------------------------------------------------------------------------------------
    if err.number = -1061154262 then 
    	Set objADO = objConfig.Documents
    	
    	do while not objADO.EOF
    	    if objADO.fields("Name").Value = "Sample Inbound Def" then
    		idDocument2 = objADO.fields("id").Value
    		exit do
    	    end if
    	   objADO.MoveNext
    	loop
    	err.clear
    end if
    
    If err.number <> 0 then 
        Wscript.Echo "[FAIL] Failed Creating Document with error - " & err.description
        Wscript.Quit        
    else
    	Wscript.Echo "[PASS] Successfully Created Document with  - " & idDocument2
    End If    
    
    Set objDocument2 = Nothing
    






'------------------------------------------------------------------------------------
'   Use the configuration object to get a poitner to the Port object
'------------------------------------------------------------------------------------
    Set objPort = objConfig.CreatePort()    
    
'------------------------------------------------------------------------------------
'   Create the Port object and set up for local file submit 
'------------------------------------------------------------------------------------
    objPort.Name = "Sample1 Port"
    objPort.DestinationEndpoint.Organization = iddestOrg
    objPort.DestinationEndpoint.Alias = iddestAlias    
    objPort.PrimaryTransport.Type = BIZTALK_TRANSPORT_TYPE_FILE
    objPort.PrimaryTransport.Address = "file://c:\%tracking_id%.txt"
    idPort = objPort.Create
'------------------------------------------------------------------------------------
'   Check to see if the Port already exists. If found, clear the error and
'   continue
'------------------------------------------------------------------------------------

    if err.number = -1061154236 then 
    	Set objADO = objConfig.Ports
    	
    	do while not objADO.EOF
    	    if objADO.fields("Name").Value = "Sample1 Port" then
    		idPort = objADO.fields("id").Value
    		exit do
    	    end if
    	   objADO.MoveNext
    	loop
    	err.clear
    end if
    
    If err.number <> 0 then 
        Wscript.Echo "[FAIL] Failed Creating Port with error - " & err.description
        Wscript.Quit        
    else
    	Wscript.Echo "[PASS] Successfully Created Port with  - " & idPort
    End If        
    
    Set objPort = Nothing


    Set objPort2 = objConfig.CreatePort()    
    
'------------------------------------------------------------------------------------
'   Create the Port object and set up for local file submit 
'------------------------------------------------------------------------------------
    objPort2.Name = "Sample2 Port"
    objPort2.DestinationEndpoint.Organization = iddestOrg2
    objPort2.DestinationEndpoint.Alias = iddestAlias2    
    objPort2.PrimaryTransport.Type = BIZTALK_TRANSPORT_TYPE_FILE
    objPort2.PrimaryTransport.Address = "file://c:\outputfile%tracking_id%.txt"
    idPort2 = objPort2.Create
'------------------------------------------------------------------------------------
'   Check to see if the Port already exists. If found, clear the error and
'   continue
'------------------------------------------------------------------------------------

    if err.number = -1061154236 then 
    	Set objADO = objConfig.Ports
    	
    	do while not objADO.EOF
    	    if objADO.fields("Name").Value = "Sample2 Port" then
    		idPort2 = objADO.fields("id").Value
    		exit do
    	    end if
    	   objADO.MoveNext
    	loop
    	err.clear
    end if
    
    If err.number <> 0 then 
        Wscript.Echo "[FAIL] Failed Creating Port with error - " & err.description
        Wscript.Quit        
    else
    	Wscript.Echo "[PASS] Successfully Created Port with  - " & idPort2
    End If        
    
    Set objPort2 = Nothing










'------------------------------------------------------------------------------------    

'-------------------------------------------------------------------------------------------
' Fail() will always report a failure and exit the script
'-------------------------------------------------------------------------------------------
Sub Fail(strScope)
	WScript.Echo "[FAIL] " & SetGetEnvVar("PROCESS", "ComputerName", "DEFAULTSERVER", False) & ":" & strScript & ": " & strScope
	WScript.Quit
End Sub

'-------------------------------------------------------------------------------------------
' Pass() will report pass
'-------------------------------------------------------------------------------------------
Sub Pass(strScope)
	WScript.Echo "[PASS] " & SetGetEnvVar("PROCESS", "ComputerName", "DEFAULTSERVER", False) & ":" & strScript & ": " & strScope
End Sub

'-------------------------------------------------------------------------------------------
' FailOnError() will call Fail() on Error
'-------------------------------------------------------------------------------------------
Sub FailOnError(strScope)
	If Err.Number <> 0 Then
		Fail strScope & " Error: x" & Hex(Err.Number) & " Description: " & Err.Description & " Source: " & Err.Source
		Err.Clear
	End If
End Sub   

'-------------------------------------------------------------------------------------------
' Set or get environment variables
'-------------------------------------------------------------------------------------------
Function SetGetEnvVar(strType, strName, strDefaultValue, bSet)
	On Error Resume Next
	Dim wshShell, wshSysEnv
	SetGetEnvVar = strDefaultValue
	If (TypeName(strName) <> "String") Or IsEmpty(strName) Or Len(strName) = 0 Or (TypeName(strType) <> "String") Or IsEmpty(strType) Or Len(strType) = 0 Then
		FailOnError "SetGetEnvVar().CheckParameters"
		Exit Function
	End If
	Set wshShell = CreateObject("WScript.Shell")
	Set wshSysEnv = wshShell.Environment(strType)
	FailOnError "SetGetEnvVar().SetwshSysEnv"
	If bSet Then
		wshSysEnv(strName) = strDefaultValue
		FailOnError "SetGetEnvVar().Set_wshSysEnv(" & strName & ")"
	Else
		SetGetEnvVar = wshSysEnv(strName)
	End If
	If SetGetEnvVar = "" Then
		SetGetEnvVar = strDefaultValue
	End If
End Function
