'//////////////////////////////////////////////////////////////////////////////////
'// Created by BizPort ver. 0.2 Beta on 9/10/2000 3:11:23 PM
'//////////////////////////////////////////////////////////////////////////////////

'<%
'/////////////  UTILITIES //////////////////////////
'/////////////  see below for Config. Object creation //////////////////
Dim gWebDavServer

gWebDavServer = SetGetEnvVar("PROCESS", "COMPUTERNAME", "", False)

Function GetServerNameFromURL(bstrURL)     ' As String
    Dim strTemp        ' String

    pos = InStr(8, bstrURL, "/")
    strTemp = Left(bstrURL, pos - 1)
    GetServerNameFromURL = strTemp
End Function


Function GetAliasID(sName, sQual, sValue, org)
    Set aliasrs = org.Aliases
    Do While Not aliasrs.EOF
        If (aliasrs("name") = sName) And (aliasrs("qualifier") = sQual) _
                   And (aliasrs("value") = sValue) Then
            GetAliasID = aliasrs("id")
            Exit Do
        End If
        aliasrs.MoveNext
    Loop
End Function


Function GetAppID(sName, org)
    Set Apprs = org.Applications
    Do While Not Apprs.EOF
        If Apprs("name") = sName Then
            GetAppID = Apprs("id")
            Exit Do
        End If
        Apprs.MoveNext
    Loop
End Function


Function DBDeleteTables()
   On Error Resume Next
    Dim adors, objIMParms

    Set objIMParms = CreateObject("GetIMParams.CGetIMParams")
    If Err.Number <> 0 Then 
       Wscript.echo "GetIMParams.dll must be registered for delete routing to work properly."
       DBDeleteTables = False
    else
       objIMParms.GetIMParams mvarDBUser, mvarDBPassword, mvarDBName, mvarDBServer
       ConnStr = "Provider=SQLOLEDB.1;Persist Security Info=True;Data Source=" & mvarDBServer & ";" & _ 
                           "Initial Catalog=" & mvarDBName & ";" & _ 
                           "User ID=" & mvarDBUser & ";" & _ 
                           "Password=" & mvarDBPassword & ";"

       Set objIMParms = Nothing
       Set adors = CreateObject("ADODB.Recordset")
       adors.Open "delete from bts_outputconfig WHERE outagrid <> 1", ConnStr
       adors.Open "delete from bts_portgroups", ConnStr
       adors.Open "delete from bts_channel WHERE id <> 1", ConnStr
       adors.Open "delete from bts_port WHERE id <> 1", ConnStr
       adors.Open "delete from bts_portgroup", ConnStr
       adors.Open "delete from bts_controlnumber", ConnStr
       adors.Open "delete from bts_envelope", ConnStr
       adors.Open "delete from bts_document WHERE id <> 1 AND id <> 2", ConnStr
       adors.Open "delete from bts_xmlshare WHERE id <> 1", ConnStr
       adors.Open "delete from bts_alias WHERE id <> 120001", ConnStr
       adors.Open "delete from bts_application", ConnStr
       adors.Open "delete from bts_organization WHERE id <> 110001", ConnStr
       adors.Open "delete from bts_appint", ConnStr
       adors.Open "delete from bts_certificate", ConnStr
       Set adors = Nothing
       DBDeleteTables = true
   End If

End Function


Sub CleanBTM()
   Dim config, obj, RS, HomeOrgID

   Set config = CreateObject("BizTalk.BizTalkConfig")

   Set obj = config.CreateChannel
   Set RS = config.Channels
   While Not RS.EOF
           obj.Load RS(0)
           obj.Remove
           RS.MoveNext
   Wend
       
   Set obj = config.CreatePortGroup
   Set RS = config.PortGroups
   While Not RS.EOF
           obj.Load RS(0)
           obj.Remove
           RS.MoveNext
   Wend

   Set obj = config.CreatePort
   Set RS = config.Ports
   While Not RS.EOF
           obj.Load RS(0)
           obj.Remove
           RS.MoveNext
   Wend

   Set obj = config.CreateEnvelope
   Set RS = config.Envelopes
   While Not RS.EOF
           obj.Load RS(0)
           obj.Remove
           RS.MoveNext
   Wend

   Set obj = config.CreateDocument
   Set RS = config.Documents
   While Not RS.EOF
           obj.Load RS(0)
           obj.Remove
           RS.MoveNext
   Wend

   Set obj = config.CreateOrganization
   Set RS = config.Organizations
   While Not RS.EOF
           obj.Load rs(0)
           If obj.IsDefault Then 
               HomeOrgID = obj.Handle
           Else
               obj.Remove
           End If
           RS.MoveNext
   Wend

   '// clear Home Org Aliases, except default and one with org name
   obj.load HomeOrgID
   Set RS = obj.Aliases
   
   '// reset default alias
   obj.SaveAlias obj.GetDefaultAlias, "sName" & Now(), False, "sQual" & Now(), "sValue" & Now()
   RS.MoveFirst
   While Not RS.EOF
       If RS("qualifier") = "Organization Name"  Then '// reset def. Alias
           obj.SaveAlias RS(0), "Organization", True, "Organization Name", obj.Name
           obj.Save
       Else
           obj.RemoveAlias RS(0)
       End If
       RS.MoveNext
   Wend
   
   
       '// clear Home Org Apps.
   Set RS = obj.Applications
   While Not RS.EOF
       obj.RemoveApplication RS("id")
       RS.MoveNext
   Wend
   
   
   obj.save

   Set obj = Nothing
   Set RS = Nothing
   Set config = Nothing
End Sub

Function SetGetEnvVar(strType, strName, strDefaultValue, bSet)
    Dim wshShell, wshSysEnv
    SetGetEnvVar = strDefaultValue
    If (TypeName(strName) <> "String") Or IsEmpty(strName) Or Len(strName) = 0 Or (TypeName(strType) <> "String") Or IsEmpty(strType) Or Len(strType) = 0 Then
            Exit Function
    End If
    Set wshShell = CreateObject("WScript.Shell")
    Set wshSysEnv = wshShell.Environment(strType)
    If bSet Then
        wshSysEnv(strName) = strDefaultValue
        
    Else
       SetGetEnvVar = wshSysEnv(strName)
    End If
    If SetGetEnvVar = "" Then
        SetGetEnvVar = strDefaultValue
    End If
End Function

Sub ErrCheck(ObjectName)
   If Err.number <> 0 Then
       Wscript.Echo "---------------------------------------------" & vbCRLF & _
           "Err Creating Object: " & ObjectName & vbCRLF & _
           "Code:  " & Hex(Err.number) & " (" & Err.number & ") " & vbCRLF   & _
           "Error: " & Err.Description & vbCRLF
   End If
   Err.Clear
End Sub

'//////  Utilities End ///////////////

'%>

'<%
On Error Resume Next

Set BT = CreateObject("BizTalk.BizTalkConfig")
'Call CleanBTM()

' Create Orgs \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 

Set org = BT.CreateOrganization

org.clear
org.load 110001
org.name = "Microsoft"
org.comments = "Home Organization"
org.SaveAlias 120001, "Organization", True, "Organization Name", "Microsoft"
org.CreateApplication "POApprovalSked"
org.CreateApplication "SQLSubmit"
org.Save
Org110001 = org.Handle
Alias120001 = GetAliasID ("Organization", "Organization Name", "Microsoft", org ) 
Call ErrCheck ("Alias120001")
App130001 = GetAppID ("POApprovalSked", org)
Call ErrCheck ("App130001")
App130002 = GetAppID ("SQLSubmit", org)
Call ErrCheck ("App130002")

org.clear
org.name = "Buyer"
org.comments = ""
org.CreateAlias "Organization", True, "Organization Name", "Buyer"
Org110002 = org.Create
Call ErrCheck ("Org110002")
Alias120002 = GetAliasID ("Organization", "Organization Name", "Buyer", org ) 
Call ErrCheck ("Alias120002")

org.clear
org.name = "Approver"
org.comments = ""
org.CreateAlias "Organization", True, "Organization Name", "Approver"
Org110003 = org.Create
Call ErrCheck ("Org110003")
Alias120003 = GetAliasID ("Organization", "Organization Name", "Approver", org ) 
Call ErrCheck ("Alias120003")

Set org = nothing

' Create Docs \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 

set doc = BT.CreateDocument


doc.clear
doc.name = "BasicPO"
doc.reference = "http://" & gWebDavServer & "/biztalkserverrepository/docspecs/poapproval/defbasicpo.xml"
Doc140002 = doc.create
Call ErrCheck ("Doc140002")

doc.clear
doc.name = "BasicPOrs"
doc.reference = "http://" & gWebDavServer & "/biztalkserverrepository/docspecs/poapproval/defbasicpors.xml"
Doc140005 = doc.create
Call ErrCheck ("Doc140005")

doc.clear
doc.name = "DecisionFactors"
doc.reference = "http://" & gWebDavServer & "/biztalkserverrepository/docspecs/poapproval/defdecisionfactors.xml"
Doc140003 = doc.create
Call ErrCheck ("Doc140003")

doc.clear
doc.name = "Response"
doc.reference = "http://" & gWebDavServer & "/biztalkserverrepository/docspecs/poapproval/defresponse.xml"
Doc140004 = doc.create
Call ErrCheck ("Doc140004")

Set doc = nothing

' Create Envs \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 

Set env = BT.CreateEnvelope

env.clear
env.Name = "BasicPOEnv"
env.Format = "FLATFILE"
env.Reference = "http://" & gWebDavServer & "/biztalkserverrepository/docspecs/poapproval/defbasicpo.xml"
Env150001 = env.create
Call ErrCheck ("Env150001")

Set env = nothing

' Create Ports \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 

set port = BT.CreatePort


port.clear
port.name = "Approval"
port.Comments = ""
port.ControlNumberValue = ""
port.DestinationEndpoint.Alias = Alias120001
port.DestinationEndpoint.Application = App130001
port.DestinationEndpoint.Openness = 1
port.DestinationEndpoint.Organization = Org110001
port.EncodingType = 1
port.PrimaryTransport.Address = "direct=os:.\private$\approval"
port.PrimaryTransport.Parameter = ""
port.PrimaryTransport.Type = 128
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160002 = port.create
Call ErrCheck ("Port160002")

port.clear
port.name = "MailPort"
port.Comments = ""
port.ControlNumberValue = ""
port.DestinationEndpoint.Alias = Alias120003
port.DestinationEndpoint.Application = App0
port.DestinationEndpoint.Openness = 1
port.DestinationEndpoint.Organization = Org110003
port.EncodingType = 1
port.PrimaryTransport.Address = "mailto:zachj@microsoft.com"
port.PrimaryTransport.Parameter = "mailto:zachj@microsoft.com"
port.PrimaryTransport.Type = 8
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160004 = port.create
Call ErrCheck ("Port160004")

port.clear
port.name = "Response"
port.Comments = ""
port.ControlNumberValue = ""
port.DestinationEndpoint.Alias = Alias120001
port.DestinationEndpoint.Application = App130001
port.DestinationEndpoint.Openness = 1
port.DestinationEndpoint.Organization = Org110001
port.EncodingType = 1
port.PrimaryTransport.Address = "direct=os:.\private$\response"
port.PrimaryTransport.Parameter = ""
port.PrimaryTransport.Type = 128
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160005 = port.create
Call ErrCheck ("Port160005")

set port = nothing

' Create Distribution Lists \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 

Set dl = BT.CreatePortGroup


Set dl = Nothing

' Create Channels \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 

set chan = BT.CreateChannel

chan.clear
chan.Name = "Approval"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.InputDocument = Doc140002
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gWebDavServer & "/biztalkserverrepository/maps/poapproval/mapbasicpo_decisionfactors.xml"
chan.OutputDocument = Doc140003
chan.port = Port160002
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120002
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110002
Chan180002 = chan.Create
Call ErrCheck ("Chan180002")

chan.clear
chan.Name = "MailChannel"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.InputDocument = Doc140003
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.OutputDocument = Doc140003
chan.port = Port160004
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120001
chan.SourceEndpoint.Openness = 8
chan.SourceEndpoint.Organization = Org110001
Chan180004 = chan.Create
Call ErrCheck ("Chan180004")

chan.clear
chan.Name = "ApprovalRS"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.InputDocument = Doc140005
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gWebDavServer & "/biztalkserverrepository/maps/poapproval/mapbasicpors_decisionfactors.xml"
chan.OutputDocument = Doc140003
chan.port = Port160002
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120001
chan.SourceEndpoint.Application = App130002
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110001
Chan180005 = chan.Create
Call ErrCheck ("Chan180005")

chan.clear
chan.Name = "Response"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.InputDocument = Doc140004
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.OutputDocument = Doc140004
chan.port = Port160005
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120003
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110003
Chan180006 = chan.Create
Call ErrCheck ("Chan180006")

set chan = nothing

Set BT = nothing
Wscript.Echo "Complete"


'%>
