'//////////////////////////////////////////////////////////////////////////////////
'// Created by BizPort ver. 0.2 Beta on 9/21/2000 2:16:47 PM
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
org.CreateAlias "DUNNum", False, "01", "081466849"
org.CreateApplication "MOLP"
org.CreateApplication "PO LOB"
org.CreateApplication "PO Pipe LOB"
org.CreateApplication "POApprovalSked"
org.CreateApplication "SQLSubmit"
org.Save
Org110001 = org.Handle
Alias120001 = GetAliasID ("Organization", "Organization Name", "Microsoft", org ) 
Call ErrCheck ("Alias120001")
Alias120024 = GetAliasID ("DUNNum", "01", "081466849", org ) 
Call ErrCheck ("Alias120024")
App130008 = GetAppID ("MOLP", org)
Call ErrCheck ("App130008")
App130006 = GetAppID ("PO LOB", org)
Call ErrCheck ("App130006")
App130007 = GetAppID ("PO Pipe LOB", org)
Call ErrCheck ("App130007")
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

org.clear
org.name = "IInterchange Sample Source Org"
org.comments = ""
org.CreateAlias "Source Custom Value", True, "BizTalk", "Source Custom Value"
org.CreateAlias "Organization", False, "Organization Name", "IInterchange Sample Source Org"
org.CreateApplication "IInterchange Sample Source Org Application"
Org110006 = org.Create
Call ErrCheck ("Org110006")
Alias120008 = GetAliasID ("Source Custom Value", "BizTalk", "Source Custom Value", org ) 
Call ErrCheck ("Alias120008")
Alias120009 = GetAliasID ("Organization", "Organization Name", "IInterchange Sample Source Org", org ) 
Call ErrCheck ("Alias120009")
App130005 = GetAppID ("IInterchange Sample Source Org Application", org)
Call ErrCheck ("App130005")

org.clear
org.name = "NWBuyers"
org.comments = ""
org.CreateAlias "Organization", True, "Organization Name", "NWBuyers"
org.CreateAlias "Dept Name", False, "10", "NWB"
Org110007 = org.Create
Call ErrCheck ("Org110007")
Alias120010 = GetAliasID ("Organization", "Organization Name", "NWBuyers", org ) 
Call ErrCheck ("Alias120010")
Alias120011 = GetAliasID ("Dept Name", "10", "NWB", org ) 
Call ErrCheck ("Alias120011")

org.clear
org.name = "SWBuyers"
org.comments = ""
org.CreateAlias "Organization", True, "Organization Name", "SWBuyers"
org.CreateAlias "Dept Name", False, "11", "SWB"
Org110008 = org.Create
Call ErrCheck ("Org110008")
Alias120012 = GetAliasID ("Organization", "Organization Name", "SWBuyers", org ) 
Call ErrCheck ("Alias120012")
Alias120013 = GetAliasID ("Dept Name", "11", "SWB", org ) 
Call ErrCheck ("Alias120013")

org.clear
org.name = "CBuyers"
org.comments = ""
org.CreateAlias "Organization", True, "Organization Name", "CBuyers"
org.CreateAlias "Dept Name", False, "12", "CB"
Org110009 = org.Create
Call ErrCheck ("Org110009")
Alias120014 = GetAliasID ("Organization", "Organization Name", "CBuyers", org ) 
Call ErrCheck ("Alias120014")
Alias120015 = GetAliasID ("Dept Name", "12", "CB", org ) 
Call ErrCheck ("Alias120015")

org.clear
org.name = "SourceOrganization"
org.comments = ""
org.CreateAlias "Organization", True, "Organization Name", "SourceOrganization"
Org110016 = org.Create
Call ErrCheck ("Org110016")
Alias120022 = GetAliasID ("Organization", "Organization Name", "SourceOrganization", org ) 
Call ErrCheck ("Alias120022")

org.clear
org.name = "DestinationOrganization"
org.comments = ""
org.CreateAlias "Organization", True, "Organization Name", "DestinationOrganization"
Org110017 = org.Create
Call ErrCheck ("Org110017")
Alias120023 = GetAliasID ("Organization", "Organization Name", "DestinationOrganization", org ) 
Call ErrCheck ("Alias120023")

org.clear
org.name = "Fabrikam"
org.comments = ""
org.CreateAlias "Organization", True, "Organization Name", "Fabrikam"
org.CreateAlias "DUNNum", False, "01", "0123456789"
Org110018 = org.Create
Call ErrCheck ("Org110018")
Alias120025 = GetAliasID ("Organization", "Organization Name", "Fabrikam", org ) 
Call ErrCheck ("Alias120025")
Alias120026 = GetAliasID ("DUNNum", "01", "0123456789", org ) 
Call ErrCheck ("Alias120026")

Set org = nothing

' Create Docs \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 

set doc = BT.CreateDocument


doc.clear
doc.name = "BasicPO"
doc.reference = "http://" & gWebDavServer & "/biztalkserverrepository/docspecs/poapproval/defbasicpo.xml"
Doc140002 = doc.create
Call ErrCheck ("Doc140002")

doc.clear
doc.name = "BasicPORs"
doc.reference = "http://" & gWebDavServer & "/biztalkserverrepository/docspecs/poapproval/defbasicpors.xml"
Doc140005 = doc.create
Call ErrCheck ("Doc140005")

doc.clear
doc.name = "CBPO"
Set doc.PropertySet = CreateObject("Commerce.Dictionary")
doc.PropertySet.Document_Type = "CB"
doc.reference = "http://" & gWebDavServer & "/biztalkserverrepository/docspecs/poapproval/defcbpo.xml"
Doc140014 = doc.create
Call ErrCheck ("Doc140014")

doc.clear
doc.name = "DecisionFactors"
doc.reference = "http://" & gWebDavServer & "/biztalkserverrepository/docspecs/poapproval/defdecisionfactors.xml"
Doc140003 = doc.create
Call ErrCheck ("Doc140003")

doc.clear
doc.name = "DecisionFactors2"
doc.reference = "http://" & gWebDavServer & "/biztalkserverrepository/docspecs/poapproval/defdecisionfactors2.xml"
Doc140022 = doc.create
Call ErrCheck ("Doc140022")

doc.clear
doc.name = "DecisionFactorsCSV"
doc.reference = "http://" & gWebDavServer & "/biztalkserverrepository/docspecs/poapproval/defdecisionfactorscsv.xml"
Doc140021 = doc.create
Call ErrCheck ("Doc140021")

doc.clear
doc.name = "DestPOSchema"
doc.reference = "c:\sdkdemo\docschemas\Destposchema.xml"
Doc140020 = doc.create
Call ErrCheck ("Doc140020")

doc.clear
doc.name = "Fabrikam850"
Set doc.PropertySet = CreateObject("Commerce.Dictionary")
doc.PropertySet.application_receiver_code = "MAXCIM"
doc.PropertySet.application_sender_code = "0123456789"
doc.PropertySet.functional_identifier = "PO"
doc.PropertySet.standards_version = "004010"
doc.PropertySet.application_receiver_code = "MAXCIM"
doc.PropertySet.application_sender_code = "0123456789"
doc.PropertySet.functional_identifier = "PO"
doc.PropertySet.standards_version = "004010"
doc.PropertySet.application_receiver_code = "MAXCIM"
doc.PropertySet.application_sender_code = "0123456789"
doc.PropertySet.functional_identifier = "PO"
doc.PropertySet.standards_version = "004010"
doc.PropertySet.application_receiver_code = "MAXCIM"
doc.PropertySet.application_sender_code = "0123456789"
doc.PropertySet.functional_identifier = "PO"
doc.PropertySet.standards_version = "004010"
doc.reference = "http://" & gWebDavServer & "/biztalkserverrepository/docspecs/poapproval/schfabrikam850.xml"
Set doc.TrackFields = CreateObject("Commerce.Dictionary")
doc.TrackFields.s_value1 = "/X12_4010_850/BEG/@BEG03"
Doc140024 = doc.create
Call ErrCheck ("Doc140024")

doc.clear
doc.name = "Fabrikam855"
Set doc.PropertySet = CreateObject("Commerce.Dictionary")
doc.PropertySet.application_receiver_code = "0123456789"
doc.PropertySet.application_sender_code = "MAXCIM"
doc.PropertySet.functional_identifier = "PR"
doc.PropertySet.standards_version = "004010"
doc.PropertySet.application_receiver_code = "0123456789"
doc.PropertySet.application_sender_code = "MAXCIM"
doc.PropertySet.functional_identifier = "PR"
doc.PropertySet.standards_version = "004010"
doc.PropertySet.application_receiver_code = "0123456789"
doc.PropertySet.application_sender_code = "MAXCIM"
doc.PropertySet.functional_identifier = "PR"
doc.PropertySet.standards_version = "004010"
doc.PropertySet.application_receiver_code = "0123456789"
doc.PropertySet.application_sender_code = "MAXCIM"
doc.PropertySet.functional_identifier = "PR"
doc.PropertySet.standards_version = "004010"
doc.reference = "http://" & gWebDavServer & "/biztalkserverrepository/docspecs/poapproval/schfabrikam855.xml"
Doc140029 = doc.create
Call ErrCheck ("Doc140029")

doc.clear
doc.name = "IInterchange Sample Destination Document Definition"
doc.reference = "http://" & gWebDavServer & "/BizTalkServerRepository/DocSpecs/Microsoft/CommonPO.xml"
Doc140011 = doc.create
Call ErrCheck ("Doc140011")

doc.clear
doc.name = "IInterchange Sample Source Document Definition"
doc.reference = "http://" & gWebDavServer & "/BizTalkServerRepository/DocSpecs/Microsoft/CommonPO.xml"
Set doc.TrackFields = CreateObject("Commerce.Dictionary")
doc.TrackFields.d_value1 = "/CommonPO/Item/DateReference/@Date"
doc.TrackFields.d_value2 = "/CommonPO/POHeader/@CreationDate"
doc.TrackFields.s_value2 = "/CommonPO/CarrierDetail/@Routing"
doc.TrackFields.i_value1 = "/CommonPO/TermsOfSale/@NetDays"
doc.TrackFields.s_value1 = "/CommonPO/TermsOfSale/@PaymentMethod"
doc.TrackFields.r_value1 = "/CommonPO/SpecialCharge/@Amount"
doc.TrackFields.i_value2 = "/CommonPO/TermsOfSale/@DiscountDaysDue"
doc.TrackFields.r_value2 = "/CommonPO/Currency/@ExchangeRate"
Set doc.TrackFields.x_custom_search = CreateObject("Commerce.SimpleList")
doc.TrackFields.x_custom_search.add "/CommonPO/Total/@LineItemTotal"
doc.TrackFields.x_custom_search.add "/CommonPO/Total/@QuantityTotal"
doc.TrackFields.x_custom_search.add "/CommonPO/Total/@POTotal"
doc.TrackFields.x_custom_search.add "/CommonPO/POHeader/@Purpose"
doc.TrackFields.x_custom_search.add "/CommonPO/POHeader/@Type"
doc.TrackFields.x_custom_search.add "/CommonPO/POHeader/@Number"
doc.TrackFields.x_custom_search.add "/CommonPO/POHeader/@CreationDate"
doc.TrackFields.x_custom_search.add "/CommonPO/Currency/@EntityID"
doc.TrackFields.x_custom_search.add "/CommonPO/Currency/@CurrencyCode"
doc.TrackFields.x_custom_search.add "/CommonPO/Currency/@ExchangeRate"
doc.TrackFields.x_custom_search.add "/CommonPO/TaxReference/@TaxIDNumber"
doc.TrackFields.x_custom_search.add "/CommonPO/TaxReference/@LocationQualifier"
doc.TrackFields.x_custom_search.add "/CommonPO/TaxReference/@Location"
doc.TrackFields.x_custom_search.add "/CommonPO/TaxReference/@TaxExemptCode"
doc.TrackFields.x_custom_search.add "/CommonPO/FOB/@ShipPaymentMethod"
doc.TrackFields.x_custom_search.add "/CommonPO/FOB/@TransferPoint"
doc.TrackFields.x_custom_search.add "/CommonPO/FOB/@Description"
doc.TrackFields.x_custom_search.add "/CommonPO/SpecialCharge/@Type"
doc.TrackFields.x_custom_search.add "/CommonPO/SpecialCharge/@HandlingMethod"
doc.TrackFields.x_custom_search.add "/CommonPO/SpecialCharge/@Amount"
doc.TrackFields.x_custom_search.add "/CommonPO/SpecialCharge/@Description"
doc.TrackFields.x_custom_search.add "/CommonPO/TermsOfSale/@DiscountPercent"
doc.TrackFields.x_custom_search.add "/CommonPO/TermsOfSale/@DiscountDaysDue"
doc.TrackFields.x_custom_search.add "/CommonPO/TermsOfSale/@NetDays"
doc.TrackFields.x_custom_search.add "/CommonPO/TermsOfSale/@Description"
doc.TrackFields.x_custom_search.add "/CommonPO/TermsOfSale/@PaymentMethod"
doc.TrackFields.x_custom_search.add "/CommonPO/DateReference/@Description"
doc.TrackFields.x_custom_search.add "/CommonPO/DateReference/@Date"
doc.TrackFields.x_custom_search.add "/CommonPO/CarrierDetail/@Name"
doc.TrackFields.x_custom_search.add "/CommonPO/CarrierDetail/@TransportType"
doc.TrackFields.x_custom_search.add "/CommonPO/CarrierDetail/@Routing"
doc.TrackFields.x_custom_search.add "/CommonPO/CarrierDetail/@TransitTimeQualifier"
doc.TrackFields.x_custom_search.add "/CommonPO/CarrierDetail/@TransitTime"
doc.TrackFields.x_custom_search.add "/CommonPO/BillTo/Address/@Name"
doc.TrackFields.x_custom_search.add "/CommonPO/BillTo/Address/@Address1"
doc.TrackFields.x_custom_search.add "/CommonPO/BillTo/Address/@Address2"
doc.TrackFields.x_custom_search.add "/CommonPO/BillTo/Address/@City"
doc.TrackFields.x_custom_search.add "/CommonPO/BillTo/Address/@State"
doc.TrackFields.x_custom_search.add "/CommonPO/BillTo/Address/@PostalCode"
doc.TrackFields.x_custom_search.add "/CommonPO/BillTo/Address/@Country"
doc.TrackFields.x_custom_search.add "/CommonPO/BillTo/ContactInfo/@ContactType"
doc.TrackFields.x_custom_search.add "/CommonPO/BillTo/ContactInfo/@ContactName"
doc.TrackFields.x_custom_search.add "/CommonPO/BillTo/ContactInfo/@NumberType"
doc.TrackFields.x_custom_search.add "/CommonPO/BillTo/ContactInfo/@ContactNumber"
doc.TrackFields.x_custom_search.add "/CommonPO/ShipTo/Address/@Name"
doc.TrackFields.x_custom_search.add "/CommonPO/ShipTo/Address/@Address1"
doc.TrackFields.x_custom_search.add "/CommonPO/ShipTo/Address/@Address2"
doc.TrackFields.x_custom_search.add "/CommonPO/ShipTo/Address/@City"
doc.TrackFields.x_custom_search.add "/CommonPO/ShipTo/Address/@State"
doc.TrackFields.x_custom_search.add "/CommonPO/ShipTo/Address/@PostalCode"
doc.TrackFields.x_custom_search.add "/CommonPO/ShipTo/Address/@Country"
doc.TrackFields.x_custom_search.add "/CommonPO/ShipTo/ContactInfo/@ContactType"
doc.TrackFields.x_custom_search.add "/CommonPO/ShipTo/ContactInfo/@ContactName"
doc.TrackFields.x_custom_search.add "/CommonPO/ShipTo/ContactInfo/@NumberType"
doc.TrackFields.x_custom_search.add "/CommonPO/ShipTo/ContactInfo/@ContactNumber"
doc.TrackFields.x_custom_search.add "/CommonPO/Item/ItemHeader/@LineNumber"
doc.TrackFields.x_custom_search.add "/CommonPO/Item/ItemHeader/@Quantity"
doc.TrackFields.x_custom_search.add "/CommonPO/Item/ItemHeader/@Price"
doc.TrackFields.x_custom_search.add "/CommonPO/Item/ItemHeader/@UnitOfMeasure"
doc.TrackFields.x_custom_search.add "/CommonPO/Item/ItemHeader/@ExtendedPrice"
doc.TrackFields.x_custom_search.add "/CommonPO/Item/ItemHeader/@BuyerPart"
doc.TrackFields.x_custom_search.add "/CommonPO/Item/ItemHeader/@VendorPart"
doc.TrackFields.x_custom_search.add "/CommonPO/Item/ItemHeader/@UPC"
doc.TrackFields.x_custom_search.add "/CommonPO/Item/ItemDescription/@Type"
doc.TrackFields.x_custom_search.add "/CommonPO/Item/ItemDescription/@Description"
doc.TrackFields.x_custom_search.add "/CommonPO/Item/DateReference/@Description"
doc.TrackFields.x_custom_search.add "/CommonPO/Item/DateReference/@Date"
doc.TrackFields.x_custom_search.add "/CommonPO/Total/@LineItemTotal"
doc.TrackFields.x_custom_search.add "/CommonPO/Total/@QuantityTotal"
doc.TrackFields.x_custom_search.add "/CommonPO/Total/@POTotal"
Doc140010 = doc.create
Call ErrCheck ("Doc140010")

doc.clear
doc.name = "Microsoft997"
Set doc.PropertySet = CreateObject("Commerce.Dictionary")
doc.PropertySet.application_receiver_code = "0123456789"
doc.PropertySet.application_sender_code = "MAXCIM"
doc.PropertySet.functional_identifier = "FA"
doc.PropertySet.standards_version = "004010"
doc.PropertySet.application_receiver_code = "0123456789"
doc.PropertySet.application_sender_code = "MAXCIM"
doc.PropertySet.functional_identifier = "FA"
doc.PropertySet.standards_version = "004010"
doc.PropertySet.application_receiver_code = "0123456789"
doc.PropertySet.application_sender_code = "MAXCIM"
doc.PropertySet.functional_identifier = "FA"
doc.PropertySet.standards_version = "004010"
doc.PropertySet.application_receiver_code = "0123456789"
doc.PropertySet.application_sender_code = "MAXCIM"
doc.PropertySet.functional_identifier = "FA"
doc.PropertySet.standards_version = "004010"
doc.reference = "http://" & gWebDavServer & "/biztalkserverrepository/docspecs/poapproval/schmicrosoft997.xml"
Doc140027 = doc.create
Call ErrCheck ("Doc140027")

doc.clear
doc.name = "MicrosoftPOAck"
doc.reference = "http://" & gWebDavServer & "/biztalkserverrepository/docspecs/poapproval/schmicrosoftpoack.xml"
Doc140028 = doc.create
Call ErrCheck ("Doc140028")

doc.clear
doc.name = "MicrosoftPO-MOLP"
doc.reference = "http://" & gWebDavServer & "/biztalkserverrepository/docspecs/poapproval/schmicrosoftpo.xml"
Doc140025 = doc.create
Call ErrCheck ("Doc140025")

doc.clear
doc.name = "MyCanonicalReceipt"
doc.reference = "http://" & gWebDavServer & "/biztalkserverrepository/docspecs/microsoft/canonicalreceipt.xml"
Doc140026 = doc.create
Call ErrCheck ("Doc140026")

doc.clear
doc.name = "NWBPO"
Set doc.PropertySet = CreateObject("Commerce.Dictionary")
doc.PropertySet.Document_Type = "NWB"
doc.reference = "http://" & gWebDavServer & "/biztalkserverrepository/docspecs/poapproval/defnwbpo.xml"
Doc140012 = doc.create
Call ErrCheck ("Doc140012")

doc.clear
doc.name = "Response"
doc.reference = "http://" & gWebDavServer & "/biztalkserverrepository/docspecs/poapproval/defresponse.xml"
Doc140004 = doc.create
Call ErrCheck ("Doc140004")

doc.clear
doc.name = "Response2"
doc.reference = "http://" & gWebDavServer & "/biztalkserverrepository/docspecs/poapproval/defresponse2.xml"
Doc140023 = doc.create
Call ErrCheck ("Doc140023")

doc.clear
doc.name = "SourcePOSchema"
doc.reference = "c:\sdkdemo\docschemas\sourceposchema.xml"
Doc140019 = doc.create
Call ErrCheck ("Doc140019")

doc.clear
doc.name = "SWBPO"
Set doc.PropertySet = CreateObject("Commerce.Dictionary")
doc.PropertySet.Document_Type = "SWB"
doc.reference = "http://" & gWebDavServer & "/biztalkserverrepository/docspecs/poapproval/defswbpo.xml"
Doc140013 = doc.create
Call ErrCheck ("Doc140013")

Set doc = nothing

' Create Envs \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 

Set env = BT.CreateEnvelope

env.clear
env.Name = "BasicPOEnv"
env.Format = "FLATFILE"
env.Reference = "http://" & gWebDavServer & "/biztalkserverrepository/docspecs/poapproval/defbasicpo.xml"
Env150001 = env.create
Call ErrCheck ("Env150001")

env.clear
env.Name = "DecisionFactors"
env.Format = "FLATFILE"
env.Reference = "http://" & gWebDavServer & "/biztalkserverrepository/docspecs/poapproval/defdecisionfactorscsv.xml"
Env150006 = env.create
Call ErrCheck ("Env150006")

env.clear
env.Name = "EDIToFabrikam"
env.Format = "X12"
env.Reference = ""
Env150007 = env.create
Call ErrCheck ("Env150007")

env.clear
env.Name = "IInterchange Sample Envelope"
env.Format = "Custom XML"
env.Reference = ""
Env150004 = env.create
Call ErrCheck ("Env150004")

env.clear
env.Name = "POEnv"
env.Format = "FLATFILE"
env.Reference = "http://" & gWebDavServer & "/biztalkserverrepository/docspecs/poapproval/defpoenv.xml"
Env150005 = env.create
Call ErrCheck ("Env150005")

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
Port160003 = port.create
Call ErrCheck ("Port160003")

port.clear
port.name = "MailPort"
port.Comments = ""
port.ControlNumberValue = ""
port.DestinationEndpoint.Alias = Alias120003
port.DestinationEndpoint.Application = App0
port.DestinationEndpoint.Openness = 1
port.DestinationEndpoint.Organization = Org110003
port.EncodingType = 1
port.PrimaryTransport.Address = "mailto:authagent@home.com"
port.PrimaryTransport.Parameter = "mailto:lfenster@microsoft.com"
port.PrimaryTransport.Type = 8
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160004 = port.create
Call ErrCheck ("Port160004")

port.clear
port.name = "IInterchange Sample OutBound Port"
port.Comments = "This is IInterchange Sample OutBound Port"
port.ControlNumberValue = ""
port.DestinationEndpoint.Alias = Alias0
port.DestinationEndpoint.Application = App0
port.DestinationEndpoint.Openness = 4
port.DestinationEndpoint.Organization = Org0
port.EncodingType = 1
port.Envelope = Env150004
port.PrimaryTransport.Address = ""
port.PrimaryTransport.Parameter = ""
port.PrimaryTransport.Type = 2048
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160007 = port.create
Call ErrCheck ("Port160007")

port.clear
port.name = "DemoPort"
port.Comments = ""
port.ControlNumberValue = ""
port.DestinationEndpoint.Alias = Alias120023
port.DestinationEndpoint.Application = App0
port.DestinationEndpoint.Openness = 1
port.DestinationEndpoint.Organization = Org110017
port.EncodingType = 1
port.PrimaryTransport.Address = "file://C:\SDKDemo\DropLocation\Outputfile%tracking_id%.xml"
port.PrimaryTransport.Parameter = ""
port.PrimaryTransport.Type = 256
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160009 = port.create
Call ErrCheck ("Port160009")

port.clear
port.name = "Approval LOB BTS AIC"
port.Comments = ""
port.ControlNumberValue = ""
port.DestinationEndpoint.Alias = Alias120001
port.DestinationEndpoint.Application = App130006
port.DestinationEndpoint.Openness = 1
port.DestinationEndpoint.Organization = Org110001
port.EncodingType = 1
port.Envelope = Env150006
port.PrimaryTransport.Address = "{4D0857E5-12AB-4B0A-882E-9EECEECD8DE1}"
port.PrimaryTransport.Parameter = "pobtsaic clsporeceive"
port.PrimaryTransport.Type = 32
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160010 = port.create
Call ErrCheck ("Port160010")

port.clear
port.name = "ApproverSurrogate"
port.Comments = ""
port.ControlNumberValue = ""
port.DestinationEndpoint.Alias = Alias120003
port.DestinationEndpoint.Application = App0
port.DestinationEndpoint.Openness = 1
port.DestinationEndpoint.Organization = Org110003
port.EncodingType = 1
port.PrimaryTransport.Address = "http://BTS218/receiveresponse.asp"
port.PrimaryTransport.Parameter = ""
port.PrimaryTransport.Type = 4
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160011 = port.create
Call ErrCheck ("Port160011")

port.clear
port.name = "Approval LOB Pipe AIC"
port.Comments = ""
port.ControlNumberValue = ""
port.DestinationEndpoint.Alias = Alias120001
port.DestinationEndpoint.Application = App130007
port.DestinationEndpoint.Openness = 1
port.DestinationEndpoint.Organization = Org110001
port.EncodingType = 1
port.Envelope = Env150006
port.PrimaryTransport.Address = "{684CA25B-AF5A-4DE2-A12E-48076F4F16F7}"
port.PrimaryTransport.Parameter = "popipeaic popipereceive"
port.PrimaryTransport.Type = 32
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160013 = port.create
Call ErrCheck ("Port160013")

port.clear
port.name = "EDIPortToFabrikam"
port.Comments = ""
port.ControlNumberValue = "10003"
Set port.Delimiters = CreateObject("Commerce.Dictionary")
port.Delimiters.field_delim = "~"
port.Delimiters.subfield_delim = ">"
port.Delimiters.record_delim = ""
port.DestinationEndpoint.Alias = Alias120026
port.DestinationEndpoint.Application = App0
port.DestinationEndpoint.Openness = 1
port.DestinationEndpoint.Organization = Org110018
port.EncodingType = 1
port.Envelope = Env150007
port.PrimaryTransport.Address = "file://c:\data\labs\lab10\demo1\editofabrikam_%tracking_id%.edi"
port.PrimaryTransport.Parameter = ""
port.PrimaryTransport.Type = 256
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160014 = port.create
Call ErrCheck ("Port160014")

port.clear
port.name = "PortToMOLP"
port.Comments = ""
port.ControlNumberValue = ""
port.DestinationEndpoint.Alias = Alias120001
port.DestinationEndpoint.Application = App130008
port.DestinationEndpoint.Openness = 1
port.DestinationEndpoint.Organization = Org110001
port.EncodingType = 1
port.PrimaryTransport.Address = "file://c:\data\labs\lab10\demo1\xmlpotomolp%tracking_id%.xml"
port.PrimaryTransport.Parameter = ""
port.PrimaryTransport.Type = 256
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160015 = port.create
Call ErrCheck ("Port160015")

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
chan.port = Port160003
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120003
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110003
Chan180003 = chan.Create
Call ErrCheck ("Chan180003")

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
chan.SignatureCertificateInfo.Name = "Home"
chan.SignatureCertificateInfo.Reference = "authagent@Home.com, US, WA, Redmond, Home.com, Purchasing, Home"
chan.SignatureCertificateInfo.Store = 1
chan.SignatureCertificateInfo.Usage = 4
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
chan.Name = "ApprovalSecure"
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
Chan180006 = chan.Create
Call ErrCheck ("Chan180006")

chan.clear
chan.Name = "ResponseSigned"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.InputDocument = Doc140004
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.OutputDocument = Doc140004
chan.port = Port160003
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120003
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110003
Chan180007 = chan.Create
Call ErrCheck ("Chan180007")

chan.clear
chan.Name = "IInterchange Sample Channel"
chan.Comments = "This is IInterchange Sample Channel"
chan.ExpectReceiptTimeout = 0
chan.InputDocument = Doc140010
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = True
chan.LoggingInfo.LogXMLInputDocument = True
chan.LoggingInfo.LogXMLOutputDocument = True
chan.OutputDocument = Doc140011
chan.port = Port160007
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120008
chan.SourceEndpoint.Application = App130005
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110006
chan.SetConfigComponent 5, Port160007, "{DFE51866-F67D-11D2-8A13-00C04F79DBAA}"
Chan180010 = chan.Create
Call ErrCheck ("Chan180010")

chan.clear
chan.Name = "NWChannel"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.InputDocument = Doc140012
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gWebDavServer & "/biztalkserverrepository/maps/poapproval/mapnwbpo_decisionfactors.xml"
chan.OutputDocument = Doc140003
chan.port = Port160002
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120010
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110007
Chan180011 = chan.Create
Call ErrCheck ("Chan180011")

chan.clear
chan.Name = "SWChannel"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.InputDocument = Doc140013
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gWebDavServer & "/biztalkserverrepository/maps/poapproval/mapswbpo_decisionfactors.xml"
chan.OutputDocument = Doc140003
chan.port = Port160002
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120012
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110008
Chan180012 = chan.Create
Call ErrCheck ("Chan180012")

chan.clear
chan.Name = "CChannel"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.InputDocument = Doc140014
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gWebDavServer & "/biztalkserverrepository/maps/poapproval/mapcbpo_decisionfactors.xml"
chan.OutputDocument = Doc140003
chan.port = Port160002
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120014
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110009
Chan180013 = chan.Create
Call ErrCheck ("Chan180013")

chan.clear
chan.Name = "DemoChannel"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.InputDocument = Doc140019
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = False
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "C:\SDKDemo\Maps\POMap.xml"
chan.OutputDocument = Doc140020
chan.port = Port160009
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120022
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110016
Chan180015 = chan.Create
Call ErrCheck ("Chan180015")

chan.clear
chan.Name = "POApproval LOB AIC"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.InputDocument = Doc140003
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gWebDavServer & "/biztalkserverrepository/maps/poapproval/mappo_decisionfactorscsv.xml"
chan.OutputDocument = Doc140021
chan.port = Port160010
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120001
chan.SourceEndpoint.Application = App130001
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110001
chan.SetConfigComponent 5, Port160010, "{CFEB5CF8-074C-11D3-BA34-00C04F79DBAA}"
Chan180016 = chan.Create
Call ErrCheck ("Chan180016")

chan.clear
chan.Name = "ApproverSurrogate"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.InputDocument = Doc140022
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gWebDavServer & "/biztalkserverrepository/maps/poapproval/mapdecisionfactors2_response2.xml"
chan.OutputDocument = Doc140023
chan.port = Port160011
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120002
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110002
Chan180017 = chan.Create
Call ErrCheck ("Chan180017")

chan.clear
chan.Name = "Approval LOB Pipe AIC"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.InputDocument = Doc140003
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://bts218/biztalkserverrepository/maps/poapproval/mappo_decisionfactorscsv.xml"
chan.OutputDocument = Doc140021
chan.port = Port160013
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120001
chan.SourceEndpoint.Application = App130001
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110001
chan.SetConfigComponent 5, Port160013, "{CFEB5CF8-074C-11D3-BA34-00C04F79DBAA}"
Chan180018 = chan.Create
Call ErrCheck ("Chan180018")

chan.clear
chan.Name = "Channel850ToMOLP"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.InputDocument = Doc140024
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gWebDavServer & "/biztalkserverrepository/maps/poapproval/mapfabrikam850tomicrosoftpo.xml"
chan.OutputDocument = Doc140025
chan.port = Port160015
chan.ReceiptChannel = Chan180021
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120025
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110018
Chan180020 = chan.Create
Call ErrCheck ("Chan180020")

chan.clear
chan.Name = "Channel997ToFabrikam"
chan.Comments = ""
chan.ControlNumberValue = 9970002
chan.ExpectReceiptTimeout = 0
chan.InputDocument = Doc140026
chan.IsReceiptChannel = True
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gWebDavServer & "/biztalkserverrepository/maps/microsoft/canonicalreceiptto4010-997.xml"
chan.OutputDocument = Doc140027
chan.port = Port160014
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120024
chan.SourceEndpoint.Application = App130008
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110001
chan.SetConfigComponent 5, Port160014, "{55AC51BC-0798-11D3-BA35-00C04F79DBAA}"
Chan180021 = chan.Create
Call ErrCheck ("Chan180021")

chan.clear
chan.Name = "Channel855ToFabrikam"
chan.Comments = ""
chan.ControlNumberValue = 10001
chan.ExpectReceiptTimeout = 0
chan.InputDocument = Doc140028
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gWebDavServer & "/biztalkserverrepository/maps/poapproval/mapmicrosoftpoacktofabrikam855.xml"
chan.OutputDocument = Doc140029
chan.port = Port160014
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120024
chan.SourceEndpoint.Application = App130008
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110001
chan.SetConfigComponent 5, Port160014, "{55AC51BC-0798-11D3-BA35-00C04F79DBAA}"
Chan180022 = chan.Create
Call ErrCheck ("Chan180022")

set chan = nothing

Set BT = nothing
Wscript.Echo "Complete"


'%>
