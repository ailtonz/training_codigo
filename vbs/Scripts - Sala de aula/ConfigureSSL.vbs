'<%
'-------------------------------------------------------------------------------------------
' E2EXML.VBS generated from files Tutorial_en.xml Tutorial.xml  on 6/15/2000 3:33:57 PM
'-------------------------------------------------------------------------------------------
'Option Explicit
'On Error Resume Next
'-------------------------------------------------------------------------------------------

'-------------------------------------------------------------------------------------------
' VBSCript Converted from Tutorial_en.xml
'-------------------------------------------------------------------------------------------

'-------------------------------------------------------------------------------------------
' Resources Section

Const rBuyerReceivePOReq = "PORequest Receive Function at ProElectron"
Const rBuyerFILEPolling = "c:\TutorialFiles\Buyer\"
Const rBuyerFILEDrop = "file://C:\TutorialFiles\Seller\Payment%Tracking_id%.xml"
Const rWebDAVStandardApp = "Microsoft"
Const rWebDAVApp = "Microsoft"
Const rPOSpec = "CommonPO.xml"
Const rPOReqSpec = "POReq.xml"
Const rCommonInvoiceSpec = "CommonInvoice.xml"
Const rPaymentSpec = "PaymentSpec.xml"
Const rPOReqToPOMap = "POReqtoPO.xml"
Const rInvoiceToPaymentMap = "InvoicetoPayment.xml"
Const rBuyer = "ProElectron on Buyer"
Const rSeller = "Bits,Bytes,Chips on Buyer"
Const rPORequest = "Purchase Order Request"
Const rPO = "Purchase Order"
Const rCommonInvoice = "Invoice"
Const rPayment = "Payment"
Const rToSellerHTTP = "Port To Bits,Bytes,Chips via HTTP"
Const rToBuyerFILE = "Port To Bits,Bytes,Chips via Local FILE"
Const rBuyerPOReqToSellerPO = "Channel for POReq to PO"
Const rSellerCIToBuyerPayment = "Channel for Invoice to Payment"
Const rDocSpecandMapDir = "DocSpecsandMaps"

PassFail "Resources"



'-------------------------------------------------------------------------------------------
' VBSCript Converted from Tutorial.xml
'-------------------------------------------------------------------------------------------

' Tutorial
'-------------------------------------------------------------------------------------------
' Constants Section

Const BIZTALK_TRANSPORT_TYPE_HTTP = 4
Const BIZTALK_TRANSPORT_TYPE_FILE = 256

PassFail "Constants"

'-------------------------------------------------------------------------------------------
' Globals Section

Dim gBTSServerName
Dim gBTSGroupName
Dim gPORef
Dim gPOReqRef
Dim gCommonInvoiceRef
Dim gPaymentRef
Dim gMapPOReqToPORef
Dim gMapCIToPaymentRef
Dim gBuyerOrg
Dim gSellerOrg
Dim gPOReqDoc
Dim gPODoc
Dim gCommonInvoiceDoc
Dim gPaymentDoc
Dim gPortToSellerHTTP
Dim gPortToBuyerFILE
Dim gChannelBuyerPOToSellerPOReq
Dim gChannelSellerCIToBuyerPayment

PassFail "Globals"

'-------------------------------------------------------------------------------------------
' Script Section

gBTSServerName = SetGetEnvVar("PROCESS", "COMPUTERNAME", "", False)
   	gBTSGroupName = GetBTSGroupName(gBTSServerName)
   	gPORef = GetWebDAVURL(gBTSServerName) + "/DocSpecs/" + rWebDAVStandardApp + "/" + rPOSpec
   	gPOReqRef = GetWebDAVURL(gBTSServerName) + "/DocSpecs/" + rWebDAVApp + "/" + rPOReqSpec
		gCommonInvoiceRef = GetWebDAVURL(gBTSServerName) + "/DocSpecs/" + rWebDAVStandardApp + "/" + rCommonInvoiceSpec
   	gPaymentRef = GetWebDAVURL(gBTSServerName) + "/DocSpecs/" + rWebDAVApp + "/" + rPaymentSpec
   	gMapPOReqToPORef = GetWebDAVURL(gBTSServerName) + "/Maps/" + rWebDAVApp + "/" + rPOReqToPOMap
   	gMapCIToPaymentRef = GetWebDAVURL(gBTSServerName) + "/Maps/" + rWebDAVApp + "/" + rInvoiceToPaymentMap
PassFail "Script"

'-------------------------------------------------------------------------------------------
' SETUP Section

'************BEGIN SETUP CODE <PRE>
' ---- Workaround for Caching Issue Need to Stop and Start the Service

Set SETUPobjShell =  WScript.CreateObject("Wscript.Shell")
SETUPobjShell.Run "Net Stop BTSSVC", 0, TRUE
PASSFAIL "BizTalk Service Stopped"
SETUPobjShell.Run "Net Start BTSSVC", 0, TRUE
PASSFAIL "BizTalk Service Started"
Set SESTUPobjShell = Nothing

Set SETUPobjComPlus = CreateObject("COMAdmin.COMAdminCatalog")
SETUPobjComPlus.ShutdownApplication "BizTalk Server Out-of-process package"
Set SETUPobjComPlus = Nothing
PASSFAIL "BizTalk Out of Process Object Shut Down"

SETUPWebDavURL = GetWebDAVURL(SetGetEnvVar("PROCESS", "COMPUTERNAME", "", False))
' ----- End Workaround

'----- SETUP ReceiveFunctions Processing Started
StopServer()
InitAdminUtil

	Dim lRSName, lRSGroupName, lRSDocumentFormat, lRSProcessingServer, lRSFileMask, lRSProtocolType
	Dim lRSPollingLoc, lRSSourceValue, lRSSourceQualifier, lRSDestinationValue, lRSDestinationQualifier
	Dim lRSChannelName, lRSEnvelopeName

	
		lRSName = rBuyerReceivePOReq

		lRSGroupName = gBTSGroupName

		lRSProcessingServer = gBTSServerName

		lRSFileMask = "*.xml"

		lRSProtocolType = ADMIN_PROTOCOL_TYPE_FILE

		lRSPollingLoc = rBuyerFILEPolling

		lRSChannelName = rBuyerPOReqToSellerPO


	Call CreateReceiveService(lRSName, lRSGroupName, lRSDocumentFormat, lRSProcessingServer, lRSFileMask, lRSProtocolType, _
									  lRSPollingLoc, lRSDocumentName, lRSSourceValue, lRSSourceQualifier, lRSDestinationValue, _
									  lRSDestinationQualifier, lRSChannelName, lRSEnvelopeName)

CleanupAdminUtil()
StartServer()
Set SETUPTempShell = Nothing
'----- SETUP ReceiveFunctions Processing Complete
'----- SETUP File Processing Started
Set SETUPTempShell = WScript.CreateObject("WScript.Shell")
Set SETUPTempFS = CreateObject("Scripting.FileSystemObject")

SetupTempStr  = SETUPWebDavURL + "/DocSpecs/" + rWebDAVApp + "/"
MakeWebDAVApp SetupTempStr
SetupTempFile = SETUPTempFS.GetParentFolderName(SETUPTempFS.GetParentFolderName(SETUPTempFS.GetParentFolderName(WScript.ScriptFullName))) _
			& "\" & rDocSpecandMapDir & "\" & rPOReqSpec
PASSFAIL "Getting Absolute Path for DocSpec " + rPOReqSpec
AddFileToWebDAVURL SetupTempFile, SetupTempStr + GetFileNameFromPath(rPOReqSpec)

SetupTempStr  = SETUPWebDavURL + "/DocSpecs/" + rWebDAVApp + "/"
MakeWebDAVApp SetupTempStr
SetupTempFile = SETUPTempFS.GetParentFolderName(SETUPTempFS.GetParentFolderName(SETUPTempFS.GetParentFolderName(WScript.ScriptFullName))) _
			& "\" & rDocSpecandMapDir & "\" & rPaymentSpec
PASSFAIL "Getting Absolute Path for DocSpec " + rPaymentSpec
AddFileToWebDAVURL SetupTempFile, SetupTempStr + GetFileNameFromPath(rPaymentSpec)

SetupTempStr  = SETUPWebDavURL + "/Maps/" + rWebDAVApp + "/"
MakeWebDAVApp SetupTempStr
SetupTempFile = SETUPTempFS.GetAbsolutePathName(rPOReqToPOMap)
SetupTempFile = SETUPTempFS.GetParentFolderName(SETUPTempFS.GetParentFolderName(SETUPTempFS.GetParentFolderName(WScript.ScriptFullName))) _
			& "\" & rDocSpecandMapDir & "\" & rPOReqToPOMap
PASSFAIL "Getting Absolute Path for MAP " + rPOReqToPOMap
AddFileToWebDAVURL SetupTempFile, SetupTempStr + GetFileNameFromPath(rPOReqToPOMap)

SetupTempStr  = SETUPWebDavURL + "/Maps/" + rWebDAVApp + "/"
MakeWebDAVApp SetupTempStr
SetupTempFile = SETUPTempFS.GetParentFolderName(SETUPTempFS.GetParentFolderName(SETUPTempFS.GetParentFolderName(WScript.ScriptFullName))) _
			& "\" & rDocSpecandMapDir & "\" & rInvoiceToPaymentMap
PASSFAIL "Getting Absolute Path for MAP " + rInvoiceToPaymentMap
AddFileToWebDAVURL SetupTempFile, SetupTempStr + GetFileNameFromPath(rInvoiceToPaymentMap)

Set SETUPTempShell = Nothing
'----- SETUP File Processing Complete
'************END SETUP CODE </PRE>

PassFail "SETUP"

'-------------------------------------------------------------------------------------------
' BTC Section

'-------------------------------------------------------------------------------------------
Dim BTM, Handle, Port, PortGroup, Document, Envelope, Organization, Channel

set BTM = CreateObject("BizTalk.BizTalkConfig")
Set Port = BTM.CreatePort
Set PortGroup = BTM.CreatePortGroup
Set Document = BTM.CreateDocument
Set Envelope = BTM.CreateEnvelope
Set Organization = BTM.CreateOrganization
Set Channel = BTM.CreateChannel
'-------------------------------------------------------------------------------------------
RemoveManagementObject Channel, rBuyerPOReqToSellerPO
RemoveManagementObject Channel, rSellerCIToBuyerPayment
RemoveManagementObject Port, rToSellerHTTP
RemoveManagementObject Port, rToBuyerFILE
RemoveManagementObject Document, rPORequest
RemoveManagementObject Document, rPO
RemoveManagementObject Document, rCommonInvoice
RemoveManagementObject Document, rPayment
RemoveManagementObject Organization, rBuyer
RemoveManagementObject Organization, rSeller
PassFail "Remove Management Objects"

'-------------------------------------------------------------------------------------------
Organization.Clear
Organization.Name = rBuyer
gBuyerOrg = Organization.Create
Handle  = Organization.Handle
PassFail "Completed """ & Organization.Name & """ with Handle: " & Handle

'-------------------------------------------------------------------------------------------
Organization.Clear
Organization.Name = rSeller
gSellerOrg = Organization.Create
Handle  = Organization.Handle
PassFail "Completed """ & Organization.Name & """ with Handle: " & Handle

'-------------------------------------------------------------------------------------------
Document.Clear
Document.Name = rPORequest
Document.Reference = gPOReqRef
gPOReqDoc = Document.Create
Handle  = Document.Handle
PassFail "Completed """ & Document.Name & """ with Handle: " & Handle

'-------------------------------------------------------------------------------------------
Document.Clear
Document.Name = rPO
Document.Reference = gPORef
gPODoc = Document.Create
Handle  = Document.Handle
PassFail "Completed """ & Document.Name & """ with Handle: " & Handle

'-------------------------------------------------------------------------------------------
Document.Clear
Document.Name = rCommonInvoice
Document.Reference = gCommonInvoiceRef
gCommonInvoiceDoc = Document.Create
Handle  = Document.Handle
PassFail "Completed """ & Document.Name & """ with Handle: " & Handle

'-------------------------------------------------------------------------------------------
Document.Clear
Document.Name = rPayment
Document.Reference = gPaymentRef
gPaymentDoc = Document.Create
Handle  = Document.Handle
PassFail "Completed """ & Document.Name & """ with Handle: " & Handle

'-------------------------------------------------------------------------------------------
Port.Clear
Port.Name = rToSellerHTTP
Port.DestinationEndPoint.Organization = gSellerOrg
Port.PrimaryTransport.Type = BIZTALK_TRANSPORT_TYPE_HTTP
Port.PrimaryTransport.Address = "http://" & gBTSServerName  & "/SubmitPO/SubmitProElectronPO.asp"
gPortToSellerHTTP = Port.Create
Handle  = Port.Handle
PassFail "Completed """ & Port.Name & """ with Handle: " & Handle

'-------------------------------------------------------------------------------------------
Port.Clear
Port.Name = rToBuyerFILE
Port.DestinationEndPoint.Organization = gBuyerOrg
Port.PrimaryTransport.Type = BIZTALK_TRANSPORT_TYPE_FILE
Port.PrimaryTransport.Address = rBuyerFILEDrop
gPortToBuyerFILE = Port.Create
Handle  = Port.Handle
PassFail "Completed """ & Port.Name & """ with Handle: " & Handle

'-------------------------------------------------------------------------------------------
Channel.Clear
Channel.Name = rBuyerPOReqToSellerPO
Channel.SourceEndPoint.Organization = gBuyerOrg
Channel.InputDocument = gPOReqDoc
Channel.OutputDocument = gPODoc
Channel.MapReference = gMapPOReqToPORef
Channel.Port = gPortToSellerHTTP
gChannelBuyerPOToSellerPOReq = Channel.Create
Handle  = Channel.Handle
PassFail "Completed """ & Channel.Name & """ with Handle: " & Handle

'-------------------------------------------------------------------------------------------
Channel.Clear
Channel.Name = rSellerCIToBuyerPayment
Channel.SourceEndPoint.Organization = gSellerOrg
Channel.InputDocument = gCommonInvoiceDoc
Channel.OutputDocument = gPaymentDoc
Channel.MapReference = gMapCIToPaymentRef
Channel.Port = gPortToBuyerFILE
gChannelSellerCIToBuyerPayment = Channel.Create
Handle  = Channel.Handle
PassFail "Completed """ & Channel.Name & """ with Handle: " & Handle

'-------------------------------------------------------------------------------------------Set Port = Nothing
Set PortGroup = Nothing
Set Document = Nothing
Set Envelope = Nothing
Set Organization = Nothing
Set Channel = Nothing
PassFail "Destroy all BTM Objects"

PassFail "BTC"

WScript.Echo "Buyer Configuration Installation Complete"

'-------------------------------------------------------------------------------------------
'	Utilities used by E2EXML
'-------------------------------------------------------------------------------------------
' PassFail() will report Pass or Fail
Sub PassFail(strScope)
	If Err.Number <> 0 Then
		Fail rE2ETCDescription & ": " & strScope & " Error: x" & Hex(Err.Number) & " Description: " & Err.Description & " Source: " & Err.Source
		Err.Clear
	'Else
		'Pass rE2ETCDescription & ": " & strScope 
	End If
End Sub

'-------------------------------------------------------------------------------------------
' Fail() will always report Failure and Exit Script
Sub Fail(strScope)
	WScript.Echo "[FAIL] " & SetGetEnvVar("PROCESS", "ComputerName", "DEFAULTSERVER", False) & ":" & strScope
	WScript.Quit
End Sub

'-------------------------------------------------------------------------------------------
' Pass() will report Pass
Sub Pass(strScope)
	WScript.Echo "[PASS] " & SetGetEnvVar("PROCESS", "ComputerName", "DEFAULTSERVER", False) & ":" & strScope
End Sub

'-------------------------------------------------------------------------------------------
' FailOnError() will call Fail() on Error
Sub FailOnError(strScope)
	If Err.Number <> 0 Then
		Fail strScope & " Error: x" & Hex(Err.Number) & " Description: " & Err.Description & " Source: " & Err.Source
		Err.Clear
	End If
End Sub

'-------------------------------------------------------------------------------------------
' AppendErrors() Utility
' This function is currently just a dummy
Sub AppendErrors(strScope, objErrList)
	Dim i
	FailOnError strScope
	For i = 1 To objErrList.Count
		WScript.Echo objErrList.Item(i - 1)
	Next
End Sub

Function ReadWholeFile(strFileName)
	ReadWholeFile = ""
	On Error Resume Next
	Dim FileSys, File
	Set FileSys = CreateObjectHelper ("Scripting.FileSystemObject")

	Set File = FileSys.OpenTextFile(strFileName, 1)
	if Err.Number = 0 then
		ReadWholeFile = File.ReadAll()
       	File.Close
	end if
	Err.Clear
    set File = nothing
    set FileSys = nothing
	On Error Goto 0
End Function

'-------------------------------------------------------------------------------------------
' Information Output Utility
Sub Info(strMsg)
	WScript.Echo "[INFO] " & strMsg 
End Sub

'-------------------------------------------------------------------------------------------
' ProcessError() checks for error and if it is not expected quit script
Sub ProcessError(strScope, iExpErrNumber, strExpErrSrc, strExpErrDescr)
	If Err.Number <> iExpErrNumber Or (UCase(strExpErrSrc) <> "ANY" And UCase(Err.Source) <> UCase(strExpErrSrc)) Or (UCase(strExpErrDescr) <> "ANY" And UCase(Err.Description) <> UCase(strExpErrDescr)) Then
		Fail strScope & "_EXPECTED_: ERROR: " & iExpErrNumber & "(x" & Hex(iExpErrNumber) & ") SOURCE: """ & strExpErrSrc & """ DESCRIPTION: """ & strExpErrDescr & """ <> _ACTUAL_: "
	End If
End Sub

'-------------------------------------------------------------------------------------------
' Set or Get Environment Variable
Function SetGetEnvVar(strType, strName, strDefaultValue, bSet)
	On Error Resume Next
	Dim wshShell, wshSysEnv
	SetGetEnvVar = strDefaultValue
	If (TypeName(strName) <> "String") Or IsEmpty(strName) Or Len(strName) = 0 Or (TypeName(strType) <> "String") Or IsEmpty(strType) Or Len(strType) = 0 Then
		FailOnError "SetGetEnvVar().CheckParameters"
		Exit Function
	End If
	Set wshShell = WScript.CreateObject ("WScript.Shell")
	Set wshSysEnv = wshShell.Environment(strType)
	FailOnError "SetGetEnvVar().SetwshSysEnv"
	If bSet Then
		wshSysEnv(strName) = strDefaultValue
		FailOnError "SetGetEnvVar().set_wshSysEnv(" & strName & ")"
	Else
		SetGetEnvVar = wshSysEnv(strName)
	End If
	If SetGetEnvVar = "" Then
		SetGetEnvVar = strDefaultValue
	End If
End Function

'-------------------------------------------------------------------------------------------
' From AdminUtil.vbs
'-------------------------------------------------------------------------------------------
Dim g_objLocator
Dim g_objService
Dim l_bAdminUtilInitialized

' Wbem Scripting Constants
Const wbemChangeFlagCreateOrUpdate = 0
Const wbemChangeFlagUpdateOnly = 1
Const wbemChangeFlagCreateOnly = 2
Const wbemChangeFlagUpdateCompatible = 0
Const wbemChangeFlagUpdateSafeMode = 32
Const wbemChangeFlagUpdateForceMode = 64

Const GROUP_NAMESPACE = "MicrosoftBizTalkServer_Group"
Const MGMT_NAMESPACE = "MicrosoftBizTalkServer_MgmtDB"
Const SERVER_NAMESPACE = "MicrosoftBizTalkServer_SERVER"
Const RECVSVC_NAMESPACE = "MicrosoftBizTalkServer_ReceiveFunction"
Const QUEUE_NAMESPACE = "MicrosoftBizTalkServer_Queue"
Const WORKQ_NAMESPACE = "MicrosoftBizTalkServer_WorkQueue"
Const SCHEDULEDQ_NAMESPACE = "MicrosoftBizTalkServer_ScheduledQueue"
Const RETRYQ_NAMESPACE = "MicrosoftBizTalkServer_RetryQueue"
Const SUSPENDEDQ_NAMESPACE = "MicrosoftBizTalkServer_SuspendedQueue"

Const ADMIN_DOCUMENT_FORMAT_STANDARD = 0
Const ADMIN_DOCUMENT_FORMAT_CUSTOM = 1

Const ADMIN_PROTOCOL_TYPE_UNSPECIFIED = 0
Const ADMIN_PROTOCOL_TYPE_FILE = 1
Const ADMIN_PROTOCOL_TYPE_MSMQ = 2

Function InitAdminUtil()
	If (l_bAdminUtilInitialized = 1) Then  Exit Function

	Set g_objLocator = CreateObjectHelper ("WbemScripting.SWbemLocator")
	Set g_objService = g_objLocator.ConnectServer(".", "root\MicrosoftBiztalkServer")
	l_bAdminUtilInitialized = 1
End Function

Function CleanupAdminUtil()
	If (l_bAdminUtilInitialized = 0) Then  Exit Function

	Set g_objService = Nothing
	Set g_objLocator = Nothing
	
	l_bAdminUtilInitialized = 0	
End Function

Function GetServerByName(strServerName)
    Set GetServerByName = Nothing
    Set GetServerByName = g_objService.Get(SERVER_NAMESPACE & ".NAME=""" & strServerName & """")
End Function

Function GetGroupByName(strGroupName)
    Set GetGroupByName = Nothing
    Set GetGroupByName = g_objService.Get(GROUP_NAMESPACE & ".NAME=""" & strGroupName & """")

End Function

Function GetBTSGroupName(strServer)
	Dim objServer, bOnTheFly

	If (l_bAdminUtilInitialized = 0) Then
		InitAdminUtil
		bOnTheFly = True
	End If	

	Set objServer = GetServerByName(strServer)
	GetBTSGroupName = objServer.GroupName
	
	Set objServer = Nothing
	
	If (bOnTheFly) Then
		CleanupAdminUtil
	End If
End Function

Function StartServer()
	Dim SETUPobjShell

	Set objShell =  WScript.CreateObject ("Wscript.Shell")
	objShell.Run "Net Start BTSSVC", 0, TRUE
	Set objShell = Nothing

End Function

Function StopServer()
	Dim objShell
	
	Set objShell =  WScript.CreateObject ("Wscript.Shell")
	SETUPobjShell.Run "Net Stop BTSSVC", 0, TRUE
	Set objShell = Nothing

End Function

Function GetMgmtDB(strLocalServer)
    Dim objBTSMgmt
    Dim objSet_BTSMgmt
    Dim objBTSMgmtInstance
    
    Set GetMgmtDB = Nothing
    Set objBTSMgmt = g_objService.Get(MGMT_NAMESPACE)
    Set objSet_BTSMgmt = objBTSMgmt.Instances_
    If objSet_BTSMgmt.Count <> 1 Then
       Exit Function
    End If
    
    Set GetMgmtDB = objSet_BTSMgmt.Item(MGMT_NAMESPACE & ".LocalServer=""" & strLocalServer & """")
End Function

Function GetWebDAVURL(strServerName)
	 GetWebDAVURL = "http://" + strServerName + "/BizTalkServerRepository"
End Function

Function GETBTSDirectory()
	Dim prodID, installer

	prodID = "{E0993E49-C0A8-11D2-973D-00C04F79E4B3}"

	Set installer = CreateObjectHelper ("WindowsInstaller.Installer")
	GETBTSDirectory = installer.ProductInfo(prodID, "InstallLocation")
	Set installer = Nothing

End Function

Function CreateReceiveService(strRecvSvcName, strGroupName, fDocumentFormat, strProcessingServer, strFileMask, fProtocolType, strPollingLoc, _
										strDocumentName, strSourceID, strSourceQualifier, strDestinationID, strDestinationQualifier, _
										strChannelName, strEnvelopeName)
    Dim objBTSRecvSvc
    Dim objBTSRecvSvcInstance

    CreateReceiveService = True
    Set objBTSRecvSvc = g_objService.Get(RECVSVC_NAMESPACE)
    Set objBTSRecvSvcInstance = objBTSRecvSvc.SpawnInstance_
 
    objBTSRecvSvcInstance.Name = strRecvSvcName
    objBTSRecvSvcInstance.GroupName = strGroupName
    objBTSRecvSvcInstance.FilenameMask = strFileMask
    objBTSRecvSvcInstance.ProcessingServer = strProcessingServer
    objBTSRecvSvcInstance.ProtocolType = fProtocolType
    objBTSRecvSvcInstance.PollingLocation = strPollingLoc
    objBTSRecvSvcInstance.OpennessFlag = BIZTALK_OPENNESS_TYPE_NOTOPEN
	 If (strDocumentName <> "") Then  objBTSRecvSvcInstance.DocumentName = strDocumentName
	 If (strSourceID <> "") Then  objBTSRecvSvcInstance.SourceID = strSourceID
	 If (strSourceQualifier <> "") Then  objBTSRecvSvcInstance.SourceQualifier = strSourceQualifier
	 If (strDestinationID <> "") Then  objBTSRecvSvcInstance.DestinationID = strDestinationID
    If (strDestinationQualifier <> "") Then  objBTSRecvSvcInstance.DestinationQualifier = strDestinationQualifier
    If (strChannelName <> "") Then  objBTSRecvSvcInstance.ChannelName = strChannelName
    If (strEnvelopeName <> "") Then  objBTSRecvSvcInstance.EnvelopeName = strEnvelopeName    

    objBTSRecvSvcInstance.Put_ (wbemChangeFlagCreateOnly)
    If Err <> 0 Then
        CreateReceiveService = False
    End If
    
    Set objBTSRecvSvcInstance = Nothing
    Set objBTSRecvSvc = Nothing
    
End Function

Function DeleteReceiveSvc(strRecvSvcName)
	 On Error Resume Next
    Call g_objService.Delete(RECVSVC_NAMESPACE & ".NAME=""" & strRecvSvcName & """")
	 If (Err.Number <> 0) Then
	    DeleteReceiveSvc = False
	 Else
	 	 DeleteReceiveSvc = True
	 End If   

End Function

'-------------------------------------------------------------------------------------------
' From DBUtil.vbs
'-------------------------------------------------------------------------------------------
Function GetSQConnection()
	Dim connstr

	Set GetSQConnection = CreateObjectHelper ("ADODB.Connection")
	
	connstr = GetSQConnectionString()
	
	If (connstr = "") Then
		Set GetSQConnection = Nothing
		Exit Function
	End If
	
	GetSQConnection.Open connstr
End Function


Function GetSQConnectionString()
    Dim strServer, strLogon, strPassword, strDBName
    Dim connStr, bResult

	 bResult = GetSQParameters(strServer, strLogon, strPassword, strDBName)
    If (Not bResult) Then
       GetSQConnectionString = ""
       Exit Function
    End If

    connStr = "Provider=SQLOLEDB.1;Password=""" & strPassword & _
            """;User ID=""" & strLogon & _
            """;Initial Catalog=""" & strDBName & _
            """;Data Source=""" & strServer & _
            """;Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096"

    GetSQConnectionString = connStr
    Exit Function

End Function


Function GetSQParameters(strServer, strLogon, strPassword, strDBName)
    Dim objServer, objGroup

	 InitAdminUtil
    
    Set objServer = GetServerByName(SetGetEnvVar("PROCESS", "COMPUTERNAME", "", False))
    Set objGroup = GetGroupByName(objServer.GroupName)
    
    strServer = objGroup.QueueDbServer
    strDBName = objGroup.QueueDbName
    strLogon = objGroup.QueueDbLogon
    strPassword = objGroup.QueueDbPassword

	 Set objGroup = Nothing
	 Set objServer = Nothing

	 CleanupAdminUtil

	 GetSQParameters = True

End Function


Function GetBTMConnection()
	Dim connstr

	Set GetBTMConnection = CreateObjectHelper ("ADODB.Connection")
	
	connstr = GetBTMConnectionString()
	
	If (connstr = "") Then
		Set GetBTMConnection = Nothing
		Exit Function
	End If
	
	GetBTMConnection.Open connstr
End Function


Function GetBTMConnectionString()
    Dim strServer, strLogon, strPassword, strDBName
    Dim connStr, bResult

	 bResult = GetBTMParameters(strServer, strLogon, strPassword, strDBName)
    If (Not bResult) Then
       GetBTMConnectionString = ""
       Exit Function
    End If

    connStr = "Provider=SQLOLEDB.1;Password=""" & strPassword & _
            """;User ID=""" & strLogon & _
            """;Initial Catalog=""" & strDBName & _
            """;Data Source=""" & strServer & _
            """;Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096"

    GetBTMConnectionString = connStr
    Exit Function

End Function


Function GetBTMParameters(strServer, strLogon, strPassword, strDBName)
	 Dim objBTMParams

	 Set objBTMParams = CreateObjectHelper ("GetIMParams.CGetIMParams")

	 Call objBTMParams.GetIMParams(strLogon, strPassword, strDBName, strServer)

	 Set objBTMParams = Nothing

	 GetBTMParameters = True

End Function


Function GetDTAConnection()
	Dim connstr

	Set GetDTAConnection = CreateObjectHelper ("ADODB.Connection")
	
	connstr = GetDTAConnectionString()
	
	If (connstr = "") Then
		Set GetDTAConnection = Nothing
		Exit Function
	End If
	
	GetDTAConnection.Open connstr
End Function

Function GetDTAConnectionString()
    Dim strServer, strLogon, strPassword, strDBName
    Dim connStr, bResult

	 bResult = GetDTAParameters(strServer, strLogon, strPassword, strDBName)
    If (Not bResult) Then
       GetDTAConnectionString = ""
       Exit Function
    End If   
    
    connStr = "Provider=SQLOLEDB.1;Password=""" & strPassword & _
            """;User ID=""" & strLogon & _
            """;Initial Catalog=""" & strDBName & _
            """;Data Source=""" & strServer & _
            """;Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096"

    GetDTAConnectionString = connStr
    Exit Function
    
End Function

Function GetDTAParameters(strServer, strLogon, strPassword, strDBName)
    Dim objServer, objGroup

	 InitAdminUtil
    
    Set objServer = GetServerByName(SetGetEnvVar("PROCESS", "COMPUTERNAME", "", False))
    Set objGroup = GetGroupByName(objServer.GroupName)
    
    strServer = objGroup.DocTrackDbServer
    strDBName = objGroup.DocTrackDbName
    strLogon = objGroup.DocTrackDbLogon
    strPassword = objGroup.DocTrackDbPassword

	 Set objGroup = Nothing
	 Set objServer = Nothing

	 CleanupAdminUtil

	 GetDTAParameters = True

End Function

Public Function CleanupDTADB()
	Dim objConn

	Set objConn = GetDTAConnection()
	If (typename(objConn) = "Nothing") Then
		CleanupDTADB = False
		Exit Function
	End If

	objConn.Execute "delete from dta_document_data",connectstring
	objConn.Execute "delete from dta_group_details",connectstring
	objConn.Execute "delete from dta_indoc_details",connectstring
	objConn.Execute "delete from dta_interchange_data",connectstring
	objConn.Execute "delete from dta_interchange_details",connectstring		
	objConn.Execute "delete from dta_outdoc_details",connectstring
	objConn.Execute "delete from dta_routing_details",connectstring	

	Set objConn = Nothing
	CleanupDTADB = True

End Function

Public Function CleanupBTMDB()
	Dim objConn

	Set objConn = GetBTMConnection()
	If (typename(objConn) = "Nothing") Then
		CleanupBTMDB = False
		Exit Function
	End If

	' delete everything but the defaults
   objConn.Execute "DELETE from bts_outputconfig WHERE outagrid <> 1"
   objConn.Execute "DELETE from bts_portgroups"
   objConn.Execute "DELETE from bts_channel WHERE id <> 1"
   objConn.Execute "DELETE from bts_port WHERE id <> 1"
   objConn.Execute "DELETE from bts_portgroup"   
   objConn.Execute "DELETE from bts_controlnumber"      
   objConn.Execute "DELETE from bts_envelope"   
   objConn.Execute "DELETE from bts_document WHERE id <> 1 AND id <> 2"
   objConn.Execute "DELETE from bts_xmlshare WHERE id <> 1"
   objConn.Execute "DELETE from bts_alias WHERE id <> 120001"
   objConn.Execute "DELETE from bts_application"   
   objConn.Execute "DELETE from bts_organization WHERE id <> 110001"
   objConn.Execute "DELETE from bts_appint"
   objConn.Execute "DELETE from bts_certificate"

	Set objConn = Nothing
	CleanupBTMDB = True

End Function


Public Function CleanupSQDB()
	On Error Resume Next
	Dim objConn

	Set objConn = GetSQConnection()
	If (typename(objConn) = "Nothing") Then
		CleanupSQDB = False
		Exit Function
	End If

	objConn.Execute "DELETE from cs_SuspendedQ"
	objConn.Execute "DELETE from cs_ScheduledQ"
	objConn.Execute "DELETE from cs_RetryQ"
	objConn.Execute "DELETE from cs_WorkQ"

	Set objConn = Nothing
	CleanupSQDB = True

End Function 'CleanupSQDB


'-------------------------------------------------------------------------------------------
' GetApplicationID - will return an application ID or 0 - if none was found
Function GetApplicationID(strOrgName, strAppName)
	On Error Resume Next
	Dim DBCfg, Org, Apps

	GetApplicationID = 0

	Set DBCfg = CreateObjectHelper ("BizTalk.BizTalkConfig")
	Set Org = DBCfg.CreateOrganization
	Org.LoadByName strOrgName
	Set Apps = Org.Applications

    If Apps.EOF And Apps.BOF Then
        Exit Function
    End If

    Apps.MoveFirst
    While Not Apps.EOF
		If Apps.Fields("name") = strAppName Then
			GetApplicationID = Apps.Fields("id")
			Exit Function
		Else
			Apps.MoveNext
		End If
    Wend
	Set Apps = Nothing
	Set Org = Nothing
	Set DBCfg = Nothing
End Function

'-------------------------------------------------------------------------------------------
Sub RemoveManagementObject(ByRef brObj, strName)
    On Error Resume Next

    ' first load the object
    brObj.LoadByName strName
    If Err.Number = 0 Then
        brObj.Remove
'    ElseIf Err.Number <>  -1061154302 Or InStr(Err.Description,  "The object was not found") < 1 Then
    ElseIf Err.Number <>  -1061154302 Then
        FailOnError "RemoveManagementObject(" & TypeName(brObj) & ", """ & strName & """)"
        Exit Sub
    Else
        ' Object just does not exist, ignore the error
        Err.Clear
    End If
    PassFail "RemoveManagementObject(" & TypeName(brObj) & ", """ & strName & """)"
End Sub

'-------------------------------------------------------------------------------------------
Function GetCertificateReference(objConfig, bstrName, nStore, nUsage)
	Dim rs
	
	GetCertificateReference = ""
	
	Set rs = objConfig.Certificates(nStore, nUsage, bstrName)
	If (rs.EOF) Then
		Set rs = Nothing
		Exit Function
	End If

	GetCertificateReference = rs("reference")
	Set rs = Nothing
End Function

'------------------------------------------------------------------------------------------
' following routines are WebDAV routines implemented via ADO
'------------------------------------------------------------------------------------------
Function EnumerateWebDAVApps(bstrURL)	'As ADODB.Recordset
	On Error Resume Next
    Dim rs			' ADODB.Recordset
    Dim conn		' ADODB.Connection
    Dim strServer	' String
    
	Set rs = CreateObjectHelper ("ADODB.Recordset")
    Set conn = GetMSDAIPPDSOConnection
    strServer = GetServerNameFromURL(bstrURL)
    
    Call conn.Open(strServer)
    Call rs.Open(bstrURL, conn, 0, 1, 512)
	PassFail "EnumerateWebDAVApps(" & btsrURL & ")"
    Set EnumerateWebDAVApps = rs
End Function

'------------------------------------------------------------------------------------------
Sub MakeWebDAVApp(bstrURL)
	On Error Resume Next
    Dim rec		' New ADODB.Record
    Dim conn	' ADODB.Connection

    Set rec = CreateObjectHelper ("ADODB.Record")
    Set conn = GetMSDAIPPDSOConnection
    
    strServer = GetServerNameFromURL(bstrURL)
    conn.Mode = 3
    Call conn.Open(strServer)
    Call rec.Open(bstrURL, conn, 3, 8192, -1)
	' ignore the error
	if Err.Number = -2147217768 then
		Err.Clear
	else
		if Err.Number = 0 then
		    rec.Close
		end if
	end if 
    conn.Close
	PassFail "MakeWebDAVApp(" & bstrURL & ")"		
End Sub

'------------------------------------------------------------------------------------------
Sub AddFileToWebDAVURL(bstrFilePath, bstrURL)
	On Error Resume Next
    Dim rec		' ADODB.Record
    Dim stm		' ADODB.Stream
    Dim conn	' ADODB.Connection
	Dim strServerName

    strServerName = GetServerNameFromURL(bstrURL)
    
	Set rec = CreateObjectHelper ("ADODB.Record")
	Set stm = CreateObjectHelper ("ADODB.Stream")
    Set conn = GetMSDAIPPDSOConnection
    conn.Mode = 3
    Call conn.Open(strServerName)
    Call rec.Open(bstrURL, conn, 3, 67108864, 8388608)
    stm.Type = 1
    Call stm.Open("URL=" & bstrURL, 2, -1)
    Call stm.LoadFromFile(bstrFilePath)
    rec.Fields("IsReadOnly") = False
    rec.Close
    stm.Close
    conn.Close
	PassFail "AddFileToWebDAVURL(" & bstrFilePath & ", " & bstrURL & ")"
End Sub

'------------------------------------------------------------------------------------------
Function GetFileNameFromPath(bstrFilepathname)	' As String
    Dim pos		' Long
    Dim posold	' Long

    pos = InStr(1, bstrFilepathname, "\")
    While pos <> 0
        posold = pos
        pos = InStr(pos + 1, bstrFilepathname, "\")
    Wend
    GetFileNameFromPath = Right(bstrFilepathname, Len(bstrFilepathname) - posold)
End Function

'------------------------------------------------------------------------------------------
Function GetServerNameFromURL(bstrURL)		' As String
    Dim strTemp		' String

    pos = InStr(8, bstrURL, "/")
    strTemp = Left(bstrURL, pos - 1)
    GetServerNameFromURL = strTemp
End Function

'------------------------------------------------------------------------------------------
Function GetPathNameFromURL(bstrURL)		' As String
	Dim strTmp

	strTmp = Replace(bstrURL, "/", "\")  ' Convert forward slashes to back slashes
	strTmp = Mid(strTmp, 8)

	GetPathNameFromURL = strTmp

End Function

'------------------------------------------------------------------------------------------
Function GetMSDAIPPDSOConnection()	' As ADODB.Connection
    Dim conn	' ADODB.Connection

	Set conn = CreateObjectHelper ("ADODB.Connection")
    conn.Provider = "MSDAIPP.DSO"
    conn.Properties("Protocol Provider").Value = "{9FECD570-B9D4-11d1-9C78-0000F875AC61}"
    Set GetMSDAIPPDSOConnection = conn
End Function

'------------------------------------------------------------------------------------------
Sub DumpRecordSet(strName, RS)
    Dim i, j, k

	On Error Resume Next

    k = RS.Fields.Count - 1
    If RS.EOF And RS.BOF Then
		WSCript.Echo strName & " RecordSet is Empty"
        Exit Sub
    End If
    RS.MoveFirst
	j = 1
    While Not RS.EOF
		Info "START_FIELD_VALUES_FOR___" & strName & "(" & j & ")___"
        For i = 0 To k
            Info RS.Fields(i).Name & " = " & RS.Fields(RS.Fields(i).Name) & " (" & RS.Fields(i).Type & ")"
        Next
		Info "END_FIELD_VALUES_FOR_____" & strName & "(" & j & ")___"
        RS.MoveNext
		j = j + 1
    Wend
	PassFail "DumpRecordSet(" & strName & ", RS)"
End Sub ' DumpRecordSet(strName, RS)

'-------------------------------------------------------------------------------------------------------------------------------------------------------------
Function GetTrackingID(Submission)
	On Error Resume Next
	GetTrackingID = ""

	Dim DTARead, Interchanges

	Set DTARead = CreateObjectHelper ("BizTalk.DTA")

	Set Interchanges = DTARead.GetInterchanges(Submission)
	If TypeName(Interchanges) = "Recordset" Then
		If Interchanges.EOF And Interchanges.BOF Then
			Exit Function
		End If

		Interchanges.MoveFirst
		While Not Interchanges.EOF
			' find the outbound interchange
			If CInt(Interchanges.Fields("nDirection").Value) = 0 Then
				' return the tracking_id field from it
				GetTrackingID = CStr(Interchanges.Fields("uidInterchangeGUID").Value)
				Exit Function
			End If
			Interchanges.MoveNext
		Wend
	End If
	Set Interchanges = Nothing
	Set DTARead = Nothing
	Set DTA = Nothing
End Function	' GetTrackingId()

'-------------------------------------------------------------------------------------------
Sub AssurePath(strPath)
	Dim fso

	Set fso = CreateObjectHelper ("Scripting.FileSystemObject")
	If not fso.FolderExists(strPath) Then
		fso.CreateFolder strPath
	End If
	Set fso = Nothing
End Sub




'-------------------------------------------------------------------------------------------
'
'		AIC utilities
'
'-------------------------------------------------------------------------------------------
' Object Class Name Constants
Const IInterchange_Object	= "BizTalk.Interchange" ' Set the Default
Const MS_BTS_Service		= "Microsoft BizTalk Server"


'-----------------------------------------------------------------------------------------
Function CreateObjectHelper (ServerNameAndTypeName)
	On Error Resume Next
	Dim obj
	Set obj = CreateObject(ServerNameAndTypeName)
	Set CreateObjectHelper = obj

	if 0 <> Err.number then
		LogFail ("Creating Object " + ServerNameAndTypeName)
	End if	
End Function 'CreateObjectHelper 


'-----------------------------------------------------------------------------------------
Function IsServiceStarted (strService)
	IsServiceStarted = False
	for each Service in _
		GetObject("winmgmts:{impersonationLevel=impersonate}").InstancesOf ("win32_service")
	
		if (strService = Service.Description) then
			IsServiceStarted = ("Running" = Service.State)
			exit function 
		end if
	next
End Function 'IsServiceStarted


'-----------------------------------------------------------------------------------------
Function CheckValue (value1, value2, strMessage)
	CheckValue = false

	if value1 <> value2 then
		Fail strMessage
	else
		CheckValue = true
	end if
End Function 'CheckValue


'-------------------------------------------------------------------------------------------
Function AIC_Submit (Openness, strDocument, strDocName, _
	strSourceQualifier, strSourceID, strDestQualifier, strDestID, _
	strChannelName, strFilePath, strEnvelopeName, bPassThrough, guidSubmissionHandle, lngExpectedError)
	
	On Error Resume Next
	Pass "AIC_Submit - enter"
	Dim objIntchg

	if VarType(Openness) = vbError then
		Openness = MODELDB_OPENNESS_TYPE_NOTOPEN	
	end if
	
	If VarType(strDocument) = vbError then
		strDocument = Empty
	End If
	If VarType(strDocName) = vbError then
		strDocName = Empty
	End If

	If VarType(strSourceQualifier) = vbError then
		strSourceQualifier = Empty
	End If
	If VarType(strSourceID) = vbError then
		strSourceID = Empty
	End If

	If VarType(strDestQualifier) = vbError then
		strDestQualifier = Empty
	End If
	If VarType(strDestID) = vbError then
		strDestID = Empty
	End If

	If VarType(strChannelName) = vbError then
		strChannelName = Empty
	End If

	If VarType(strFilePath) = vbError then
		strFilePath = Empty
	End If

	If VarType(strEnvelopeName) = vbError then
		strEnvelopeName = Empty
	End If

	if VarType(bPassThrough) <> vbBoolean then
		bPassThrough = False
	end if
	
	Set objIntchg = CreateObjectHelper (IInterchange_Object)

	if VarType(guidSubmissionHandle) <> vbError then
		guidSubmissionHandle = objIntchg.Submit (clng(Openness), strDocument, _
			strDocName, strSourceQualifier, strSourceID, strDestQualifier, strDestID, _
			strChannelName, strFilePath, strEnvelopeName, CBool(bPassThrough))
	else
		' call it without getting the submit handle
		objIntchg.Submit clng(Openness), strDocument, _
			strDocName, strSourceQualifier, strSourceID, strDestQualifier, strDestID, _
			strChannelName, strFilePath, strEnvelopeName, CBool(bPassThrough)
	end if

	if VarType(lngExpectedError) <> vbEmpty then
		' check the returned value
		CheckValue err.Number, lngExpectedError, "IInterchange::Submit returned a bad value: expected value: " _
		+ CStr(lngExpectedError) + " actual value: " + CStr(err.Number) 
	end if

	' if there was an error, it resulted in the document being placed in the suspended Queue
    	if Err.number <> 0 then
    		WScript.Echo "[INFO] IInterchange::Submit failed. Error code: " + CStr(er.number) _
		+ "description: " + err.description
    	else
    		WScript.Echo "[INFO] IInterchange::Submit passed"
    	End if
	
	IsServiceStarted(MS_BTS_Service)

	Set objIntchg = nothing
	Pass "AIC_Submit - exit"
End Function 'AIC_Submit




'-------------------------------------------------------------------------------------------
Function AIC_SubmitSync (Openness, strDocument, strDocName, _
	strSourceQualifier, strSourceID, strDestQualifier, strDestID, _
	strChannelName, strFilePath, strEnvelopeName, bPassThrough, _
	guidSubmissionHandle, Response, lngExpectedError)

	Dim objIntchg
	
	On Error Resume Next
	Pass "SubmitSync - enter"

	if VarType(Openness) = vbError then
		Openness = MODELDB_OPENNESS_TYPE_NOTOPEN	
	end if
	
	If VarType(strDocument) = vbError then
		strDocument = Empty
	End If
	If VarType(strDocName) = vbError then
		strDocName = Empty
	End If

	If VarType(strSourceQualifier) = vbError then
		strSourceQualifier = Empty
	End If
	If VarType(strSourceID) = vbError then
		strSourceID = Empty
	End If

	If VarType(strDestQualifier) = vbError then
		strDestQualifier = Empty
	End If
	If VarType(strDestID) = vbError then
		strDestID = Empty
	End If

	If VarType(strChannelName) = vbError then
		strChannelName = Empty
	End If

	If VarType(strFilePath) = vbError then
		strFilePath = Empty
	End If

	If VarType(strEnvelopeName) = vbError then
		strEnvelopeName = Empty
	End If
		
	if VarType(bPassThrough) <> vbBoolean then
		bPassThrough = False
	end if
	
	Set objIntchg = CreateObjectHelper (IInterchange_Object)

	if VarType(Response) <> vbNull then
        	objIntchg.SubmitSync clng(Openness), strDocument, strDocName, strSourceQualifier, strSourceID, _
		strDestQualifier, strDestID, strChannelName, strFilePath, strEnvelopeName, CBool(bPassThrough), guidSubmissionHandle, Response
        else
		objIntchg.SubmitSync clng(Openness), strDocument, strDocName, strSourceQualifier, strSourceID, _
		strDestQualifier, strDestID, strChannelName, strFilePath, strEnvelopeName, CBool(bPassThrough), guidSubmissionHandle, Empty
	end if

	if VarType(lngExpectedError) <> vbEmpty then
		' check the returned value
		CheckValue err.Number, lngExpectedError, "IInterchange::SubmitSync returned a bad value: expected value: " _
		+ CStr(lngExpectedError) + " actual value: " + CStr(err.Number) 
	end if

    	if Err.number <> 0 then
    		WScript.Echo "[INFO] IInterchange::SubmitSync failed. Error code: " + CStr(er.number) _
		+ "description: " + err.description
    	else
    		WScript.Echo "[INFO] IInterchange::SubmitSync passed"
    	End if
    	
	Pass "AIC_SubmitSync - exit"
End Function 'AIC_SubmitSync

Function DocSpecRef( WebDAVApp, DocSpec)
	DocSpecRef = "http://" & SetGetEnvVar("PROCESS", "ComputerName", "localhost", False) & "/BizTalkServerRepository/DocSpecs/" & WebDAVApp & "/"  & DocSpec
End Function 'DocSpecRef( WebDAVApp, DocSpec)

Function MapRef( WebDAVApp, MapSpec)
	MapRef = "http://" & SetGetEnvVar("PROCESS", "ComputerName", "localhost", False) & "/BizTalkServerRepository/Maps/" & WebDAVApp & "/"  & MapSpec
End Function 'MapRef( WebDAVApp, MapSpec)


'-------------------------------------------------------------------------------------------
'
'		End of AIC utilities
'
'-------------------------------------------------------------------------------------------
'%>
