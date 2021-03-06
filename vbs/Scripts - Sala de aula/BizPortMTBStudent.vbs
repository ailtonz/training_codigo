'//////////////////////////////////////////////////////////////////////////////////
'// Created by BizPort ver. 0.4 Beta on 10/19/2000 4:44:09 PM
'//////////////////////////////////////////////////////////////////////////////////
'<%
On Error Resume Next

Call BizPortInitialize()

Call CleanBTM()

Set BT = CreateObject("BizTalk.BizTalkConfig")
' Create Orgs \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 

Set org = BT.CreateOrganization

org.clear
org.load 110001
org.name = "Microsoft"
org.comments = "Home Organization"
org.CreateAlias "Organization", True, "OrganizationName", "Microsoft"
org.CreateAlias "Reliable Messaging Acknowledgement SMTP From Address", False, "SMTP", "<acknowledgement email address>"
org.CreateAlias "MYD&BNumber", False, "01", "081466849"
org.CreateApplication "MOLP"
org.CreateApplication "PO LOB"
org.CreateApplication "POApprovalSked"
org.CreateApplication "SQLSubmit"
org.Save
Org110001 = org.Handle
Alias120001 = GetAliasID ("Organization", "OrganizationName", "Microsoft", org ) 
Call ErrCheck ("Alias120001")
Alias120002 = GetAliasID ("Reliable Messaging Acknowledgement SMTP From Address", "SMTP", "<acknowledgement email address>", org ) 
Call ErrCheck ("Alias120002")
Alias120021 = GetAliasID ("MYD&BNumber", "01", "081466849", org ) 
Call ErrCheck ("Alias120021")
App130005 = GetAppID ("MOLP", org)
Call ErrCheck ("App130005")
App130004 = GetAppID ("PO LOB", org)
Call ErrCheck ("App130004")
App130001 = GetAppID ("POApprovalSked", org)
Call ErrCheck ("App130001")
App130002 = GetAppID ("SQLSubmit", org)
Call ErrCheck ("App130002")

org.clear
org.name = "Buyer"
org.comments = ""
Org110002 = org.Create
Call ErrCheck ("Org110002")
Alias120003 = GetAliasID ("Organization", "OrganizationName", "Buyer", org ) 
Call ErrCheck ("Alias120003")

org.clear
org.name = "Approver"
org.comments = ""
Org110003 = org.Create
Call ErrCheck ("Org110003")
Alias120004 = GetAliasID ("Organization", "OrganizationName", "Approver", org ) 
Call ErrCheck ("Alias120004")

org.clear
org.name = "IInterchange Sample Source Org"
org.comments = ""
org.CreateAlias "Source Custom Value", True, "BizTalk", "Source Custom Value"
org.CreateApplication "IInterchange Sample Source Org Application"
Org110004 = org.Create
Call ErrCheck ("Org110004")
Alias120005 = GetAliasID ("Source Custom Value", "BizTalk", "Source Custom Value", org ) 
Call ErrCheck ("Alias120005")
Alias120006 = GetAliasID ("Organization", "OrganizationName", "IInterchange Sample Source Org", org ) 
Call ErrCheck ("Alias120006")
App130003 = GetAppID ("IInterchange Sample Source Org Application", org)
Call ErrCheck ("App130003")

org.clear
org.name = "NWBuyers"
org.comments = ""
org.CreateAlias "Dept Name", False, "10", "NWB"
Org110005 = org.Create
Call ErrCheck ("Org110005")
Alias120007 = GetAliasID ("Dept Name", "10", "NWB", org ) 
Call ErrCheck ("Alias120007")
Alias120008 = GetAliasID ("Organization", "OrganizationName", "NWBuyers", org ) 
Call ErrCheck ("Alias120008")

org.clear
org.name = "SWBuyers"
org.comments = ""
org.CreateAlias "Dept Name", False, "11", "SWB"
Org110006 = org.Create
Call ErrCheck ("Org110006")
Alias120009 = GetAliasID ("Dept Name", "11", "SWB", org ) 
Call ErrCheck ("Alias120009")
Alias120010 = GetAliasID ("Organization", "OrganizationName", "SWBuyers", org ) 
Call ErrCheck ("Alias120010")

org.clear
org.name = "CBuyers"
org.comments = ""
org.CreateAlias "Dept Name", False, "12", "CB"
Org110007 = org.Create
Call ErrCheck ("Org110007")
Alias120011 = GetAliasID ("Dept Name", "12", "CB", org ) 
Call ErrCheck ("Alias120011")
Alias120012 = GetAliasID ("Organization", "OrganizationName", "CBuyers", org ) 
Call ErrCheck ("Alias120012")

org.clear
org.name = "SourceOrganization"
org.comments = ""
Org110016 = org.Create
Call ErrCheck ("Org110016")
Alias120019 = GetAliasID ("Organization", "OrganizationName", "SourceOrganization", org ) 
Call ErrCheck ("Alias120019")

org.clear
org.name = "DestinationOrganization"
org.comments = ""
Org110017 = org.Create
Call ErrCheck ("Org110017")
Alias120020 = GetAliasID ("Organization", "OrganizationName", "DestinationOrganization", org ) 
Call ErrCheck ("Alias120020")

org.clear
org.name = "Fabrikam"
org.comments = ""
org.CreateAlias "FabD&BNumber", False, "01", "0123456789"
Org110018 = org.Create
Call ErrCheck ("Org110018")
Alias120022 = GetAliasID ("FabD&BNumber", "01", "0123456789", org ) 
Call ErrCheck ("Alias120022")
Alias120023 = GetAliasID ("Organization", "OrganizationName", "Fabrikam", org ) 
Call ErrCheck ("Alias120023")

Set org = nothing

' Create Docs \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 

set doc = BT.CreateDocument


doc.clear
doc.name = "BasicPO"
doc.reference = "http://" & gServerName & "/BizTalkServerRepository/DocSpecs/POApproval/defBasicPO.xml"
Doc140002 = doc.create
Call ErrCheck ("Doc140002")

doc.clear
doc.name = "BasicPOrs"
doc.reference = "http://" & gServerName & "/BizTalkServerRepository/DocSpecs/POApproval/defBasicPOrs.xml"
Doc140005 = doc.create
Call ErrCheck ("Doc140005")

doc.clear
doc.name = "CBPO"
Set doc.PropertySet = CreateObject("Commerce.Dictionary")
doc.PropertySet.Document_Type = "CB"
doc.reference = "http://" & gServerName & "/BizTalkServerRepository/DocSpecs/POApproval/defCBPO.xml"
Doc140010 = doc.create
Call ErrCheck ("Doc140010")

doc.clear
doc.name = "DecisionFactors"
doc.reference = "http://" & gServerName & "/BizTalkServerRepository/DocSpecs/POApproval/defDecisionFactors.xml"
Doc140003 = doc.create
Call ErrCheck ("Doc140003")

doc.clear
doc.name = "DecisionFactorsCSV"
doc.reference = "http://" & gServerName & "/BizTalkServerRepository/DocSpecs/POApproval/defDecisionFactorsCSV.xml"
Doc140013 = doc.create
Call ErrCheck ("Doc140013")

doc.clear
doc.name = "DestPOSchema"
doc.reference = "http://spidermonkey/biztalkserverrepository/docspecs/poapproval/DestPOSchema.xml"
Doc140012 = doc.create
Call ErrCheck ("Doc140012")

doc.clear
doc.name = "Fabrikam850"
Set doc.PropertySet = CreateObject("Commerce.Dictionary")
doc.PropertySet.application_receiver_code = "MAXCIM"
doc.PropertySet.application_sender_code = "0123456789"
doc.PropertySet.functional_identifier = "PO"
doc.PropertySet.standards_version = "004010"
doc.reference = "http://" & gServerName & "/BizTalkServerRepository/DocSpecs/POApproval/schFabrikam850.xml"
Set doc.TrackFields = CreateObject("Commerce.Dictionary")
doc.TrackFields.s_value1 = "/X12_4010_850/BEG/@BEG03"
Doc140014 = doc.create
Call ErrCheck ("Doc140014")

doc.clear
doc.name = "Fabrikam855"
Set doc.PropertySet = CreateObject("Commerce.Dictionary")
doc.PropertySet.application_receiver_code = "0123456789"
doc.PropertySet.application_sender_code = "MAXCIM"
doc.PropertySet.functional_identifier = "PR"
doc.PropertySet.standards_version = "004010"
doc.reference = "http://" & gServerName & "/BizTalkServerRepository/DocSpecs/POApproval/schFabrikam855.xml"
Doc140019 = doc.create
Call ErrCheck ("Doc140019")

doc.clear
doc.name = "IInterchange Sample Destination Document Definition"
doc.reference = "http://" & gServerName & "/BizTalkServerRepository/DocSpecs/Microsoft/CommonPO.xml"
Doc140007 = doc.create
Call ErrCheck ("Doc140007")

doc.clear
doc.name = "IInterchange Sample Source Document Definition"
doc.reference = "http://" & gServerName & "/BizTalkServerRepository/DocSpecs/Microsoft/CommonPO.xml"
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
Doc140006 = doc.create
Call ErrCheck ("Doc140006")

doc.clear
doc.name = "Microsoft997"
Set doc.PropertySet = CreateObject("Commerce.Dictionary")
doc.PropertySet.application_receiver_code = "0123456789"
doc.PropertySet.application_sender_code = "MAXCIM"
doc.PropertySet.functional_identifier = "FA"
doc.PropertySet.standards_version = "004010"
doc.reference = "http://" & gServerName & "/BizTalkServerRepository/DocSpecs/POApproval/schMicrosoft997.xml"
Doc140017 = doc.create
Call ErrCheck ("Doc140017")

doc.clear
doc.name = "MicrosoftPOAck"
doc.reference = "http://" & gServerName & "/BizTalkServerRepository/DocSpecs/POApproval/schMicrosoftPOAck.xml"
Doc140018 = doc.create
Call ErrCheck ("Doc140018")

doc.clear
doc.name = "MicrosoftPO-MOLP"
doc.reference = "http://" & gServerName & "/BizTalkServerRepository/DocSpecs/POApproval/schMicrosoftPO.xml"
Doc140015 = doc.create
Call ErrCheck ("Doc140015")

doc.clear
doc.name = "MyCanonicalReceipt"
doc.reference = "http://" & gServerName & "/BizTalkServerRepository/DocSpecs/Microsoft/CanonicalReceipt.xml"
Doc140016 = doc.create
Call ErrCheck ("Doc140016")

doc.clear
doc.name = "NWBPO"
Set doc.PropertySet = CreateObject("Commerce.Dictionary")
doc.PropertySet.Document_Type = "NWB"
doc.reference = "http://" & gServerName & "/BizTalkServerRepository/DocSpecs/POApproval/defNWBPO.xml"
Doc140008 = doc.create
Call ErrCheck ("Doc140008")

doc.clear
doc.name = "Response"
doc.reference = "http://" & gServerName & "/BizTalkServerRepository/DocSpecs/POApproval/defResponse.xml"
Doc140004 = doc.create
Call ErrCheck ("Doc140004")

doc.clear
doc.name = "SourcePOSchema"
doc.reference = "http://spidermonkey/biztalkserverrepository/docspecs/poapproval/SourcePOSchema.xml"
Doc140011 = doc.create
Call ErrCheck ("Doc140011")

doc.clear
doc.name = "SWBPO"
Set doc.PropertySet = CreateObject("Commerce.Dictionary")
doc.PropertySet.Document_Type = "SWB"
doc.reference = "http://" & gServerName & "/BizTalkServerRepository/DocSpecs/POApproval/defSWBPO.xml"
Doc140009 = doc.create
Call ErrCheck ("Doc140009")

Set doc = nothing

' Create Envs \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 

Set env = BT.CreateEnvelope

env.clear
env.Name = "BasicPOEnv"
env.Format = "CUSTOM"
env.Reference = "http://" & gServerName & "/BizTalkServerRepository/DocSpecs/POApproval/defBasicPO.xml"
Env150001 = env.create
Call ErrCheck ("Env150001")

env.clear
env.Name = "DecisionFactors"
env.Format = "FLATFILE"
env.Reference = "http://" & gServerName & "/BizTalkServerRepository/DocSpecs/POApproval/defDecisionFactorsCSV.xml"
Env150004 = env.create
Call ErrCheck ("Env150004")

env.clear
env.Name = "EDItoFabrikam"
env.Format = "X12"
env.Reference = ""
Env150005 = env.create
Call ErrCheck ("Env150005")

env.clear
env.Name = "IInterchange Sample Envelope"
env.Format = "Custom XML"
env.Reference = ""
Env150002 = env.create
Call ErrCheck ("Env150002")

env.clear
env.Name = "POEnv"
env.Format = "FLATFILE"
env.Reference = "http://" & gServerName & "/BizTalkServerRepository/DocSpecs/POApproval/defPOEnv.xml"
Env150003 = env.create
Call ErrCheck ("Env150003")

Set env = nothing

' Create Ports \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 

set port = BT.CreatePort


port.clear
port.name = "Approval"
port.Comments = ""
port.ControlNumberValue = ""
port.DestinationEndpoint.Alias = Alias120001
port.DestinationEndpoint.Application = App0
port.DestinationEndpoint.Openness = 16
port.DestinationEndpoint.Organization = Org110001
port.EncodingType = 1
port.PrimaryTransport.Address = "D:\Data\POApproval\poapproval.skx"
port.PrimaryTransport.Parameter = "StartApproval"
port.PrimaryTransport.Type = 8192
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
port.DestinationEndpoint.Alias = Alias120004
port.DestinationEndpoint.Application = App0
port.DestinationEndpoint.Openness = 1
port.DestinationEndpoint.Organization = Org110003
port.EncodingType = 1
port.PrimaryTransport.Address = "mailto:markkott@microsoft.com"
port.PrimaryTransport.Parameter = "mailto:authagent@home.com"
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
port.Envelope = Env150002
port.PrimaryTransport.Address = ""
port.PrimaryTransport.Parameter = ""
port.PrimaryTransport.Type = 2048
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160005 = port.create
Call ErrCheck ("Port160005")

port.clear
port.name = "DemoPort"
port.Comments = ""
port.ControlNumberValue = ""
port.DestinationEndpoint.Alias = Alias120020
port.DestinationEndpoint.Application = App0
port.DestinationEndpoint.Openness = 1
port.DestinationEndpoint.Organization = Org110017
port.EncodingType = 1
port.PrimaryTransport.Address = "file://d:\SDKDemo\DropLocation\OutDoc%tracking_id%.xml"
port.PrimaryTransport.Parameter = ""
port.PrimaryTransport.Type = 256
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160006 = port.create
Call ErrCheck ("Port160006")

port.clear
port.name = "Approval LOB BTS AIC"
port.Comments = ""
port.ControlNumberValue = ""
port.DestinationEndpoint.Alias = Alias120001
port.DestinationEndpoint.Application = App130004
port.DestinationEndpoint.Openness = 1
port.DestinationEndpoint.Organization = Org110001
port.EncodingType = 1
port.Envelope = Env150004
port.PrimaryTransport.Address = "{0732827A-A70F-4171-9051-4CFB3EDDF3C1}"
port.PrimaryTransport.Parameter = ""
port.PrimaryTransport.Type = 32
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160007 = port.create
Call ErrCheck ("Port160007")

port.clear
port.name = "Approval LOB AIC Pipe"
port.Comments = ""
port.ControlNumberValue = ""
port.DestinationEndpoint.Alias = Alias120001
port.DestinationEndpoint.Application = App130004
port.DestinationEndpoint.Openness = 1
port.DestinationEndpoint.Organization = Org110001
port.EncodingType = 1
port.Envelope = Env150004
port.PrimaryTransport.Address = "{D43CAF05-DA08-43A2-B737-DAA770274994}"
port.PrimaryTransport.Parameter = ""
port.PrimaryTransport.Type = 32
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160009 = port.create
Call ErrCheck ("Port160009")

port.clear
port.name = "EDIPortToFabrikam"
port.Comments = ""
port.ControlNumberValue = "6777783"
Set port.Delimiters = CreateObject("Commerce.Dictionary")
port.Delimiters.subfield_delim = "~"
port.Delimiters.field_delim = "*"
port.Delimiters.record_delim = ">"
port.DestinationEndpoint.Alias = Alias120022
port.DestinationEndpoint.Application = App0
port.DestinationEndpoint.Openness = 1
port.DestinationEndpoint.Organization = Org110018
port.EncodingType = 1
port.Envelope = Env150005
port.PrimaryTransport.Address = "file://d:\data\out\EDItofabrikam_%tracking_id%.edi"
port.PrimaryTransport.Parameter = ""
port.PrimaryTransport.Type = 256
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160010 = port.create
Call ErrCheck ("Port160010")

port.clear
port.name = "PorttoMOLP"
port.Comments = ""
port.ControlNumberValue = ""
port.DestinationEndpoint.Alias = Alias120001
port.DestinationEndpoint.Application = App130005
port.DestinationEndpoint.Openness = 1
port.DestinationEndpoint.Organization = Org110001
port.EncodingType = 1
port.PrimaryTransport.Address = "file://d:\data\out\xmlpotomolp%tracking_id%.xml"
port.PrimaryTransport.Parameter = ""
port.PrimaryTransport.Type = 256
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160011 = port.create
Call ErrCheck ("Port160011")

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
chan.Expression = ""
chan.InputDocument = Doc140002
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gServerName & "/BizTalkServerRepository/Maps/POApproval/mapBasicPO_DecisionFactors.xml"
chan.OutputDocument = Doc140003
chan.port = Port160002
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120003
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110002
Chan180002 = chan.Create
Call ErrCheck ("Chan180002")

chan.clear
chan.Name = "Response"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
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
chan.SourceEndpoint.Alias = Alias120004
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110003
Chan180003 = chan.Create
Call ErrCheck ("Chan180003")

chan.clear
chan.Name = "MailChannel"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
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
chan.SetConfigComponent 2, Port160004, "{90E7BA41-549C-47EA-BC15-55FE6F5BBA9E}"
Chan180004 = chan.Create
Call ErrCheck ("Chan180004")

chan.clear
chan.Name = "ApprovalRS"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140005
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gServerName & "/BizTalkServerRepository/Maps/POApproval/mapBasicPOrs_DecisionFactors.xml"
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
chan.Expression = ""
chan.InputDocument = Doc140002
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gServerName & "/BizTalkServerRepository/Maps/POApproval/mapBasicPO_DecisionFactors.xml"
chan.OutputDocument = Doc140003
chan.port = Port160002
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120003
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110002
Chan180006 = chan.Create
Call ErrCheck ("Chan180006")

chan.clear
chan.Name = "ResponseSigned"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
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
chan.SourceEndpoint.Alias = Alias120004
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110003
Chan180007 = chan.Create
Call ErrCheck ("Chan180007")

chan.clear
chan.Name = "IInterchange Sample Channel"
chan.Comments = "This is IInterchange Sample Channel"
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140006
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = True
chan.LoggingInfo.LogXMLInputDocument = True
chan.LoggingInfo.LogXMLOutputDocument = True
chan.OutputDocument = Doc140007
chan.port = Port160005
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120005
chan.SourceEndpoint.Application = App130003
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110004
chan.SetConfigComponent 5, Port160005, "{DFE51866-F67D-11D2-8A13-00C04F79DBAA}"
Chan180008 = chan.Create
Call ErrCheck ("Chan180008")

chan.clear
chan.Name = "NWChannel"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140008
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gServerName & "/BizTalkServerRepository/Maps/POApproval/mapNWBPO_DecisionFactors.xml"
chan.OutputDocument = Doc140003
chan.port = Port160002
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120008
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110005
Chan180009 = chan.Create
Call ErrCheck ("Chan180009")

chan.clear
chan.Name = "SWChannel"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140009
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gServerName & "/BizTalkServerRepository/Maps/POApproval/mapSWBPO_DecisionFactors.xml"
chan.OutputDocument = Doc140003
chan.port = Port160002
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120010
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110006
Chan180010 = chan.Create
Call ErrCheck ("Chan180010")

chan.clear
chan.Name = "CChannel"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140010
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gServerName & "/BizTalkServerRepository/Maps/POApproval/mapCBPO_DecisionFactors.xml"
chan.OutputDocument = Doc140003
chan.port = Port160002
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120012
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110007
Chan180011 = chan.Create
Call ErrCheck ("Chan180011")

chan.clear
chan.Name = "DemoChannel"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140011
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = False
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://spidermonkey/biztalkserverrepository/maps/poapproval/POMap.xml"
chan.OutputDocument = Doc140012
chan.port = Port160006
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120019
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110016
Chan180012 = chan.Create
Call ErrCheck ("Chan180012")

chan.clear
chan.Name = "Approval LOB AIC"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140003
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gServerName & "/BizTalkServerRepository/Maps/POApproval/mapPO_DecisionFactorsCSV.xml"
chan.OutputDocument = Doc140013
chan.port = Port160007
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120001
chan.SourceEndpoint.Application = App130001
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110001
chan.SetConfigComponent 5, Port160007, "{CFEB5CF8-074C-11D3-BA34-00C04F79DBAA}"
Chan180013 = chan.Create
Call ErrCheck ("Chan180013")

chan.clear
chan.Name = "Approval LOB Pipe AIC"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140003
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gServerName & "/BizTalkServerRepository/Maps/POApproval/mapPO_DecisionFactorsCSV.xml"
chan.OutputDocument = Doc140013
chan.port = Port160009
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120001
chan.SourceEndpoint.Application = App130001
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110001
chan.SetConfigComponent 5, Port160009, "{CFEB5CF8-074C-11D3-BA34-00C04F79DBAA}"
Chan180015 = chan.Create
Call ErrCheck ("Chan180015")

chan.clear
chan.Name = "Channel997toFabrikam"
chan.Comments = ""
chan.ControlNumberValue = 3
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140016
chan.IsReceiptChannel = True
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gServerName & "/BizTalkServerRepository/Maps/Microsoft/CanonicalReceiptTo4010-997.xml"
chan.OutputDocument = Doc140017
chan.port = Port160010
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120021
chan.SourceEndpoint.Application = App130005
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110001
chan.SetConfigComponent 5, Port160010, "{55AC51BC-0798-11D3-BA35-00C04F79DBAA}"
Chan180016 = chan.Create
Call ErrCheck ("Chan180016")

chan.clear
chan.Name = "Channel850toMOLP"
chan.Comments = ""
chan.ControlNumberValue = 1
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140014
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gServerName & "/BizTalkServerRepository/Maps/POApproval/mapFabrikam850toMicrosoftPO.xml"
chan.OutputDocument = Doc140015
chan.port = Port160011
chan.ReceiptChannel = Chan180016
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120023
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110018
Chan180017 = chan.Create
Call ErrCheck ("Chan180017")

chan.clear
chan.Name = "Channel855toFabrikam"
chan.Comments = ""
chan.ControlNumberValue = 11
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140018
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gServerName & "/BizTalkServerRepository/Maps/POApproval/mapMicrosoftPOAcktoFabrikam855.xml"
chan.OutputDocument = Doc140019
chan.port = Port160010
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120021
chan.SourceEndpoint.Application = App130005
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110001
chan.SetConfigComponent 5, Port160010, "{55AC51BC-0798-11D3-BA35-00C04F79DBAA}"
Chan180018 = chan.Create
Call ErrCheck ("Chan180018")

set chan = nothing

Set BT = nothing

strUserName = InputBox("Enter Username for Receive Service(s).", , gUserName)
strPassword = InputBox("Enter Password for " & strUserName )
strProcessingServer = InputBox("Enter Processing Servername.", , gServerName )
strBTSGroupName = InputBox("Enter BizTalk Server Groupname.", , gBTSGroupName )

'// original server: SPIDERMONKEY
'// original username: 
'// original BTSGroupname: BizTalk Server Group
CreateReceiveFunction "Approval", strBTSGroupName, strProcessingServer, 1, "", strUsername, strPassword, False, "d:\data\POApproval\PODrop", "*.csv", 1, False, "POEnv", "", "", "", "", "Microsoft", "OrganizationName"

'// original server: SPIDERMONKEY
'// original username: 
'// original BTSGroupname: BizTalk Server Group
CreateReceiveFunction "ApprovalSecure", strBTSGroupName, strProcessingServer, 1, "", strUsername, strPassword, False, "d:\Data\POApproval\PODrop", "myPO.txt", 1, False, "", "ApprovalSecure", "", "", "", "", ""

'// original server: SPIDERMONKEY
'// original username: 
'// original BTSGroupname: BizTalk Server Group
CreateReceiveFunction "ApprovalSt", strBTSGroupName, strProcessingServer, 1, "", strUsername, strPassword, True, "d:\Data\POApproval\PODrop", "myPO.csv", 1, False, "BasicPOEnv", "Approval", "", "", "", "", ""

'// original server: spidermonkey
'// original username: 
'// original BTSGroupname: BizTalk Server Group
CreateReceiveFunction "DemoFileReceiveFunction", strBTSGroupName, strProcessingServer, 1, "", strUsername, strPassword, False, "D:\SDKDemo\ReceiveLocation", "*.xml", 1, False, "", "DemoChannel", "", "", "", "", ""

'// original server: SPIDERMONKEY
'// original username: 
'// original BTSGroupname: BizTalk Server Group
CreateReceiveFunction "EDIFiles", strBTSGroupName, strProcessingServer, 1, "", strUsername, strPassword, False, "d:\data\in", "*.edi", 1, False, "", "", "", "", "", "", ""

'// original server: SPIDERMONKEY
'// original username: 
'// original BTSGroupname: BizTalk Server Group
CreateReceiveFunction "Response", strBTSGroupName, strProcessingServer, 1, "", strUsername, strPassword, False, "d:\data\POApproval\PODrop", "myResponse?.xml", 1, False, "", "Response", "", "", "", "", ""

'// original server: SPIDERMONKEY
'// original username: 
'// original BTSGroupname: BizTalk Server Group
CreateReceiveFunction "ResponseSecure", strBTSGroupName, strProcessingServer, 1, "", strUsername, strPassword, False, "D:\data\POApproval\PODrop", "myResponse?.txt", 1, False, "", "ResponseSigned", "", "", "", "", ""

'// original server: SPIDERMONKEY
'// original username: 
'// original BTSGroupname: BizTalk Server Group
CreateReceiveFunction "XMLAcks", strBTSGroupName, strProcessingServer, 1, "", strUsername, strPassword, False, "d:\data\in", "*.xml", 1, False, "", "Channel855toFabrikam", "", "", "", "", ""

Wscript.Echo "Complete"

'%>

'<%
'/////////////  UTILITIES //////////////////////////

Const wbemChangeFlagCreateOnly = 2
Const wbemChangeFlagUpdateOnly = 1
Const GROUP_NAMESPACE = "MicrosoftBizTalkServer_Group"
Const MGMT_NAMESPACE = "MicrosoftBizTalkServer_MgmtDB"
Const SERVER_NAMESPACE = "MicrosoftBizTalkServer_SERVER"
Const RECVSVC_NAMESPACE = "MicrosoftBizTalkServer_ReceiveFunction"
Const QUEUE_NAMESPACE = "MicrosoftBizTalkServer_Queue"
Const WORKQ_NAMESPACE = "MicrosoftBizTalkServer_WorkQueue"
Const SCHEDULEDQ_NAMESPACE = "MicrosoftBizTalkServer_ScheduledQueue"
Const RETRYQ_NAMESPACE = "MicrosoftBizTalkServer_RetryQueue"
Const SUSPENDEDQ_NAMESPACE = "MicrosoftBizTalkServer_SuspendedQueue"


Dim gServerName, gDomain, gUserName, gBTSGroupName

Sub BizPortInitialize()

   gServerName   = SetGetEnvVar("PROCESS", "COMPUTERNAME", "", False)
   gDomain       = SetGetEnvVar("PROCESS", "USERDOMAIN", "", False)
   gUserName     = SetGetEnvVar("PROCESS", "USERNAME", "", False)
   gUserName     = gDomain & "\" & gUserName
   gBTSGroupName = GetBTSGroupName(gServerName)

End Sub


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

Sub CreateReceiveFunction (strName, strGroupName, strProcessingServer, intProtocolType, _
   strComment, strUsername, strPassword, booDisableReceiveFunction, strPollingLocation, _
   strFilenameMask, intOpennessFlag, booIsPassThrough, strEnvelopeName, _
   strChannelName, strDocumentName, strSourceID, strSourceQualifier, _
   strDestinationID, strDestinationQualifier)
                                     
    Dim objBTSRecvSvc, objBTSRecvSvcInstance
    Dim objService, objLocator
   
    DeleteReceiveFunction(strName)
    
    Set objLocator = CreateObject("WbemScripting.SWbemLocator")
        Set objService = objLocator.ConnectServer(, "root/MicrosoftBizTalkServer")
        objService.Security_.AuthenticationLevel = 6 ' wbemAuthenticationLevelPktPrivacy
        objService.Security_.ImpersonationLevel = 3 'wbemImpersonationLevelImpersonate

    Set objBTSRecvSvc = objService.Get(RECVSVC_NAMESPACE)
    Set objBTSRecvSvcInstance = objBTSRecvSvc.SpawnInstance_
 
    objBTSRecvSvcInstance.Name = strName
    objBTSRecvSvcInstance.GroupName = strGroupName
    objBTSRecvSvcInstance.FilenameMask = strFilenameMask
    objBTSRecvSvcInstance.ProcessingServer = strProcessingServer
    objBTSRecvSvcInstance.ProtocolType = intProtocolType
    objBTSRecvSvcInstance.PollingLocation = strPollingLocation
    objBTSRecvSvcInstance.DisableReceiveFunction = booDisableReceiveFunction
    If strPassword <> "" Then
                objBTSRecvSvcInstance.Password = strPassword
        End If
        If strUserName <> "" Then
                objBTSRecvSvcInstance.Username = strUserName
        End If
        If strDocumentName <> "" Then
            objBTSRecvSvcInstance.DocumentName = strDocumentName
    End If
    If strSourceID <> "" Then
                objBTSRecvSvcInstance.SourceID = strSourceID
        End If
    If strSourceQualifier <> "" Then
                objBTSRecvSvcInstance.SourceQualifier = strSourceQualifier
    End If
    If strDestinationID <> "" Then
                objBTSRecvSvcInstance.DestinationID = strDestinationID
    End If
    If strDestinationQualifier <> "" Then
                objBTSRecvSvcInstance.DestinationQualifier = strDestinationQualifier
    End If
    If strChannelName <> "" Then
                objBTSRecvSvcInstance.ChannelName = strChannelName
    End If
   
    If intOpennessFlag <> 0 Then
                objBTSRecvSvcInstance.OpennessFlag = intOpennessFlag
    End If
    objBTSRecvSvcInstance.Put_ (wbemChangeFlagCreateOnly)
    
End Sub

Sub DeleteReceiveFunction(strRecvSvcName)
    On Error Resume Next
    Dim objService, objLocator

    Set objLocator = CreateObject("WbemScripting.SWbemLocator")
        Set objService = objLocator.ConnectServer(, "root/MicrosoftBizTalkServer")
        objService.Security_.AuthenticationLevel = 6 ' wbemAuthenticationLevelPktPrivacy
        objService.Security_.ImpersonationLevel = 3 'wbemImpersonationLevelImpersonate

    Call objService.Delete(RECVSVC_NAMESPACE & ".NAME=""" & strRecvSvcName & """")
    
End Sub

Function GetBTSGroupName(strServerName)
   Dim objLocator, objService, objServer

   Set objLocator = CreateObject("WbemScripting.SWbemLocator")
   Set objService = objLocator.ConnectServer(".", "root\MicrosoftBiztalkServer")

   Set objServer = objService.Get(SERVER_NAMESPACE & ".NAME=""" & strServerName & """")
   GetBTSGroupName = objServer.GroupName

   Set objServer = Nothing
   Set objLocator = Nothing
   Set objService = Nothing
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

