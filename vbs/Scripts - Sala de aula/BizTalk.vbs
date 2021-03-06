'//////////////////////////////////////////////////////////////////////////////////
'// Created by BizPort ver. 0.4 Beta on 10/4/2000 11:54:52 AM
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
org.name = "Home Organization"
org.comments = "Home Organization"
org.CreateAlias "Organization", True, "OrganizationName", "Home Organization"
org.CreateAlias "Reliable Messaging Acknowledgement SMTP From Address", False, "SMTP", "<acknowledgement email address>"
org.CreateApplication "POApprovalSked"
org.CreateApplication "SQLSubmit"
org.Save
Org110001 = org.Handle
Alias120001 = GetAliasID ("Organization", "OrganizationName", "Home Organization", org ) 
Call ErrCheck ("Alias120001")
Alias120032 = GetAliasID ("Reliable Messaging Acknowledgement SMTP From Address", "SMTP", "<acknowledgement email address>", org ) 
Call ErrCheck ("Alias120032")
App130001 = GetAppID ("POApprovalSked", org)
Call ErrCheck ("App130001")
App130002 = GetAppID ("SQLSubmit", org)
Call ErrCheck ("App130002")

org.clear
org.name = "Bits,Bytes,Chips on Seller"
org.comments = ""
Org110005 = org.Create
Call ErrCheck ("Org110005")
Alias120005 = GetAliasID ("Organization", "OrganizationName", "Bits,Bytes,Chips on Seller", org ) 
Call ErrCheck ("Alias120005")

org.clear
org.name = "ProElectron on Seller"
org.comments = ""
Org110006 = org.Create
Call ErrCheck ("Org110006")
Alias120006 = GetAliasID ("Organization", "OrganizationName", "ProElectron on Seller", org ) 
Call ErrCheck ("Alias120006")

org.clear
org.name = "ProElectron on Buyer"
org.comments = ""
Org110007 = org.Create
Call ErrCheck ("Org110007")
Alias120007 = GetAliasID ("Organization", "OrganizationName", "ProElectron on Buyer", org ) 
Call ErrCheck ("Alias120007")

org.clear
org.name = "Bits,Bytes,Chips on Buyer"
org.comments = ""
Org110008 = org.Create
Call ErrCheck ("Org110008")
Alias120008 = GetAliasID ("Organization", "OrganizationName", "Bits,Bytes,Chips on Buyer", org ) 
Call ErrCheck ("Alias120008")

org.clear
org.name = "Buyer"
org.comments = ""
Org110009 = org.Create
Call ErrCheck ("Org110009")
Alias120009 = GetAliasID ("Organization", "OrganizationName", "Buyer", org ) 
Call ErrCheck ("Alias120009")

org.clear
org.name = "Approver"
org.comments = ""
Org110010 = org.Create
Call ErrCheck ("Org110010")
Alias120010 = GetAliasID ("Organization", "OrganizationName", "Approver", org ) 
Call ErrCheck ("Alias120010")

org.clear
org.name = "IInterchange Sample Source Org"
org.comments = ""
org.CreateAlias "Source Custom Value", True, "BizTalk", "Source Custom Value"
org.CreateApplication "IInterchange Sample Source Org Application"
Org110011 = org.Create
Call ErrCheck ("Org110011")
Alias120011 = GetAliasID ("Source Custom Value", "BizTalk", "Source Custom Value", org ) 
Call ErrCheck ("Alias120011")
Alias120012 = GetAliasID ("Organization", "OrganizationName", "IInterchange Sample Source Org", org ) 
Call ErrCheck ("Alias120012")
App130003 = GetAppID ("IInterchange Sample Source Org Application", org)
Call ErrCheck ("App130003")

org.clear
org.name = "NWBuyers"
org.comments = ""
org.CreateAlias "Dept Name", False, "10", "WNB"
Org110018 = org.Create
Call ErrCheck ("Org110018")
Alias120023 = GetAliasID ("Dept Name", "10", "WNB", org ) 
Call ErrCheck ("Alias120023")
Alias120024 = GetAliasID ("Organization", "OrganizationName", "NWBuyers", org ) 
Call ErrCheck ("Alias120024")

org.clear
org.name = "SWBuyers"
org.comments = ""
org.CreateAlias "Dept Name", False, "11", "SWB"
Org110019 = org.Create
Call ErrCheck ("Org110019")
Alias120025 = GetAliasID ("Dept Name", "11", "SWB", org ) 
Call ErrCheck ("Alias120025")
Alias120026 = GetAliasID ("Organization", "OrganizationName", "SWBuyers", org ) 
Call ErrCheck ("Alias120026")

org.clear
org.name = "CBuyers"
org.comments = ""
org.CreateAlias "Dept Name", False, "12", "CB"
Org110020 = org.Create
Call ErrCheck ("Org110020")
Alias120027 = GetAliasID ("Dept Name", "12", "CB", org ) 
Call ErrCheck ("Alias120027")
Alias120028 = GetAliasID ("Organization", "OrganizationName", "CBuyers", org ) 
Call ErrCheck ("Alias120028")

org.clear
org.name = "SourceOrganization"
org.comments = ""
Org110021 = org.Create
Call ErrCheck ("Org110021")
Alias120029 = GetAliasID ("Organization", "OrganizationName", "SourceOrganization", org ) 
Call ErrCheck ("Alias120029")

org.clear
org.name = "DestinationOrganization"
org.comments = ""
Org110022 = org.Create
Call ErrCheck ("Org110022")
Alias120030 = GetAliasID ("Organization", "OrganizationName", "DestinationOrganization", org ) 
Call ErrCheck ("Alias120030")

Set org = nothing

' Create Docs \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 

set doc = BT.CreateDocument


doc.clear
doc.name = "BasicPO"
doc.reference = "http://" & gServerName & "/biztalkserverrepository/docspecs/poapproval/defbasicpo.xml"
Doc140014 = doc.create
Call ErrCheck ("Doc140014")

doc.clear
doc.name = "BasicPOrs"
doc.reference = "http://" & gServerName & "/biztalkserverrepository/docspecs/poapproval/defbasicpors.xml"
Doc140017 = doc.create
Call ErrCheck ("Doc140017")

doc.clear
doc.name = "CB"
Set doc.PropertySet = CreateObject("Commerce.Dictionary")
doc.PropertySet.Value = "CB"
doc.reference = "http://" & gServerName & "/biztalkserverrepository/docspecs/poapproval/defcbpo.xml"
Doc140028 = doc.create
Call ErrCheck ("Doc140028")

doc.clear
doc.name = "Common Invoice"
doc.reference = "http://" & gServerName & "/BizTalkServerRepository/DocSpecs/Microsoft/CommonInvoice.xml"
Doc140008 = doc.create
Call ErrCheck ("Doc140008")

doc.clear
doc.name = "CSVCustomerInput"
doc.reference = "http://" & gServerName & "/biztalkserverrepository/docspecs/microsoft/csvcustomerinput.xml"
Doc140011 = doc.create
Call ErrCheck ("Doc140011")

doc.clear
doc.name = "CSVCustomerOutput"
doc.reference = "http://" & gServerName & "/biztalkserverrepository/docspecs/microsoft/csvcustomeroutput.xml"
Doc140012 = doc.create
Call ErrCheck ("Doc140012")

doc.clear
doc.name = "CSVCustomerOutputCSV"
doc.reference = "http://" & gServerName & "/biztalkserverrepository/docspecs/microsoft/csvcustomeroutputcsv.xml"
Doc140013 = doc.create
Call ErrCheck ("Doc140013")

doc.clear
doc.name = "DecisionFactors"
doc.reference = "http://" & gServerName & "/biztalkserverrepository/docspecs/poapproval/defdecisionfactors.xml"
Doc140015 = doc.create
Call ErrCheck ("Doc140015")

doc.clear
doc.name = "DecisionFactors2"
doc.reference = "http://" & gServerName & "/biztalkserverrepository/docspecs/poapproval/defdecisionfactors2.xml"
Doc140018 = doc.create
Call ErrCheck ("Doc140018")

doc.clear
doc.name = "IInterchange Sample Destination Document Definition"
doc.reference = "http://" & gServerName & "/BizTalkServerRepository/DocSpecs/Microsoft/CommonPO.xml"
Doc140021 = doc.create
Call ErrCheck ("Doc140021")

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
Doc140020 = doc.create
Call ErrCheck ("Doc140020")

doc.clear
doc.name = "NWBPO"
Set doc.PropertySet = CreateObject("Commerce.Dictionary")
doc.PropertySet.Value = "NWB"
doc.reference = "http://" & gServerName & "/biztalkserverrepository/docspecs/poapproval/defnwbpo.xml"
Doc140026 = doc.create
Call ErrCheck ("Doc140026")

doc.clear
doc.name = "Payment"
doc.reference = "http://" & gServerName & "/BizTalkServerRepository/DocSpecs/Microsoft/PaymentSpec.xml"
Doc140009 = doc.create
Call ErrCheck ("Doc140009")

doc.clear
doc.name = "Purchase Order"
doc.reference = "http://" & gServerName & "/BizTalkServerRepository/DocSpecs/Microsoft/CommonPO.xml"
Doc140007 = doc.create
Call ErrCheck ("Doc140007")

doc.clear
doc.name = "Purchase Order Request"
doc.reference = "http://" & gServerName & "/BizTalkServerRepository/DocSpecs/Microsoft/POReq.xml"
Doc140006 = doc.create
Call ErrCheck ("Doc140006")

doc.clear
doc.name = "Response"
doc.reference = "http://" & gServerName & "/biztalkserverrepository/docspecs/poapproval/defresponse.xml"
Doc140016 = doc.create
Call ErrCheck ("Doc140016")

doc.clear
doc.name = "Response2"
doc.reference = "http://" & gServerName & "/biztalkserverrepository/docspecs/poapproval/defresponse2.xml"
Doc140019 = doc.create
Call ErrCheck ("Doc140019")

doc.clear
doc.name = "SWB"
Set doc.PropertySet = CreateObject("Commerce.Dictionary")
doc.PropertySet.Value = "SWB"
doc.reference = "http://" & gServerName & "/biztalkserverrepository/docspecs/poapproval/defswbpo.xml"
Doc140027 = doc.create
Call ErrCheck ("Doc140027")

Set doc = nothing

' Create Envs \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 

Set env = BT.CreateEnvelope

env.clear
env.Name = "BasicPOEnv"
env.Format = "FLATFILE"
env.Reference = "http://" & gServerName & "/biztalkserverrepository/docspecs/poapproval/defbasicpo.xml"
Env150003 = env.create
Call ErrCheck ("Env150003")

env.clear
env.Name = "CSVCustomerInputEnvelope"
env.Format = "FLATFILE"
env.Reference = "http://" & gServerName & "/biztalkserverrepository/docspecs/microsoft/csvcustomerinput.xml"
Env150001 = env.create
Call ErrCheck ("Env150001")

env.clear
env.Name = "CSVCustomerOutputCSV"
env.Format = "FLATFILE"
env.Reference = "http://" & gServerName & "/biztalkserverrepository/docspecs/microsoft/csvcustomeroutputcsv.xml"
Env150002 = env.create
Call ErrCheck ("Env150002")

env.clear
env.Name = "IInterchange Sample Envelope"
env.Format = "Custom XML"
env.Reference = ""
Env150004 = env.create
Call ErrCheck ("Env150004")

env.clear
env.Name = "POEnv"
env.Format = "FLATFILE"
env.Reference = ""
Env150006 = env.create
Call ErrCheck ("Env150006")

env.clear
env.Name = "POEnvLab6"
env.Format = "FLATFILE"
env.Reference = "http://" & gServerName & "/biztalkserverrepository/docspecs/poapproval/defpoenv.xml"
Env150007 = env.create
Call ErrCheck ("Env150007")

Set env = nothing

' Create Ports \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 

set port = BT.CreatePort


port.clear
port.name = "Port To Bits,Bytes,Chips via HTTP"
port.Comments = ""
port.ControlNumberValue = ""
port.DestinationEndpoint.Alias = Alias120008
port.DestinationEndpoint.Application = App0
port.DestinationEndpoint.Openness = 1
port.DestinationEndpoint.Organization = Org110008
port.EncodingType = 1
port.PrimaryTransport.Address = "http://OSMIUM1/ASPSubmitPO/SubmitProElectronPO.asp"
port.PrimaryTransport.Parameter = ""
port.PrimaryTransport.Type = 4
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160007 = port.create
Call ErrCheck ("Port160007")

port.clear
port.name = "Port To ProElectron via Local FILE"
port.Comments = ""
port.ControlNumberValue = ""
port.DestinationEndpoint.Alias = Alias120007
port.DestinationEndpoint.Application = App0
port.DestinationEndpoint.Openness = 1
port.DestinationEndpoint.Organization = Org110007
port.EncodingType = 1
port.PrimaryTransport.Address = "file://C:\TutorialFiles\Seller\Payment%Tracking_id%.xml"
port.PrimaryTransport.Parameter = ""
port.PrimaryTransport.Type = 256
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160008 = port.create
Call ErrCheck ("Port160008")

port.clear
port.name = "Port to  Bits,Bytes,Chips via AIC"
port.Comments = ""
port.ControlNumberValue = ""
port.DestinationEndpoint.Alias = Alias120005
port.DestinationEndpoint.Application = App0
port.DestinationEndpoint.Openness = 1
port.DestinationEndpoint.Organization = Org110005
port.EncodingType = 1
port.PrimaryTransport.Address = "{68E12ADB-CCAB-4E84-94B6-0C02654F9534}"
port.PrimaryTransport.Parameter = ""
port.PrimaryTransport.Type = 32
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160010 = port.create
Call ErrCheck ("Port160010")

port.clear
port.name = "Port to ProElectron via HTTP"
port.Comments = ""
port.ControlNumberValue = ""
port.DestinationEndpoint.Alias = Alias120006
port.DestinationEndpoint.Application = App0
port.DestinationEndpoint.Openness = 1
port.DestinationEndpoint.Organization = Org110006
port.EncodingType = 1
port.PrimaryTransport.Address = "http://OSMIUM1/dropinvoicetoqueue/dropinvoicetomsmq.asp"
port.PrimaryTransport.Parameter = ""
port.PrimaryTransport.Type = 4
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160011 = port.create
Call ErrCheck ("Port160011")

port.clear
port.name = "Port to Bits,Bytes,Chips on CSV File"
port.Comments = ""
port.ControlNumberValue = ""
port.DestinationEndpoint.Alias = Alias120005
port.DestinationEndpoint.Application = App0
port.DestinationEndpoint.Openness = 1
port.DestinationEndpoint.Organization = Org110005
port.EncodingType = 1
port.PrimaryTransport.Address = "file://c:\csvtobizdemo\out\out.xml"
port.PrimaryTransport.Parameter = ""
port.PrimaryTransport.Type = 256
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160013 = port.create
Call ErrCheck ("Port160013")

port.clear
port.name = "Port to Bits,Bytes,Chips on CSV Final"
port.Comments = ""
port.ControlNumberValue = ""
port.DestinationEndpoint.Alias = Alias120005
port.DestinationEndpoint.Application = App0
port.DestinationEndpoint.Openness = 1
port.DestinationEndpoint.Organization = Org110005
port.EncodingType = 1
port.Envelope = Env150002
port.PrimaryTransport.Address = "{EA7B9F86-CF0B-4339-A3F7-4E95DAA749F4}"
port.PrimaryTransport.Parameter = ""
port.PrimaryTransport.Type = 32
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160015 = port.create
Call ErrCheck ("Port160015")

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
Port160016 = port.create
Call ErrCheck ("Port160016")

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
Port160017 = port.create
Call ErrCheck ("Port160017")

port.clear
port.name = "MailPort"
port.Comments = ""
port.ControlNumberValue = ""
port.DestinationEndpoint.Alias = Alias120010
port.DestinationEndpoint.Application = App0
port.DestinationEndpoint.Openness = 1
port.DestinationEndpoint.Organization = Org110010
port.EncodingType = 2
port.PrimaryTransport.Address = "mailto:scottwoo@microsoft.com"
port.PrimaryTransport.Parameter = "mailto:scottwoo@microsoft.com"
port.PrimaryTransport.Type = 8
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160018 = port.create
Call ErrCheck ("Port160018")

port.clear
port.name = "ApproverSurrogate"
port.Comments = ""
port.ControlNumberValue = ""
port.DestinationEndpoint.Alias = Alias120009
port.DestinationEndpoint.Application = App0
port.DestinationEndpoint.Openness = 1
port.DestinationEndpoint.Organization = Org110009
port.EncodingType = 1
port.PrimaryTransport.Address = "http://OSMIUM1/receiveresponse.asp"
port.PrimaryTransport.Parameter = ""
port.PrimaryTransport.Type = 4
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160019 = port.create
Call ErrCheck ("Port160019")

port.clear
port.name = "Response2"
port.Comments = ""
port.ControlNumberValue = ""
port.DestinationEndpoint.Alias = Alias0
port.DestinationEndpoint.Application = App0
port.DestinationEndpoint.Openness = 4
port.DestinationEndpoint.Organization = Org0
port.EncodingType = 1
port.PrimaryTransport.Address = ""
port.PrimaryTransport.Parameter = ""
port.PrimaryTransport.Type = 2048
port.SecondaryTransport.Address = ""
port.SecondaryTransport.Parameter = ""
port.SecondaryTransport.Type = 1
Port160020 = port.create
Call ErrCheck ("Port160020")

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
Port160021 = port.create
Call ErrCheck ("Port160021")

set port = nothing

' Create Distribution Lists \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 

Set dl = BT.CreatePortGroup


Set dl = Nothing

' Create Channels \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 

set chan = BT.CreateChannel

chan.clear
chan.Name = "Channel for POReq to PO"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140006
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = False
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gServerName & "/BizTalkServerRepository/Maps/Microsoft/POReqtoPO.xml"
chan.OutputDocument = Doc140007
chan.port = Port160007
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120007
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110007
Chan180007 = chan.Create
Call ErrCheck ("Chan180007")

chan.clear
chan.Name = "InvoiceToPayment"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140008
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = False
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gServerName & "/BizTalkServerRepository/Maps/Microsoft/InvoicetoPayment.xml"
chan.OutputDocument = Doc140009
chan.port = Port160008
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120008
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110008
Chan180008 = chan.Create
Call ErrCheck ("Chan180008")

chan.clear
chan.Name = "Channel from ProElectron for PO"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140007
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.OutputDocument = Doc140007
chan.port = Port160010
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120006
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110006
Chan180009 = chan.Create
Call ErrCheck ("Chan180009")

chan.clear
chan.Name = "Channel from Bits,Bytes,Chips for CommonInvoice"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140008
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.OutputDocument = Doc140008
chan.port = Port160011
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120005
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110005
Chan180010 = chan.Create
Call ErrCheck ("Chan180010")

chan.clear
chan.Name = "CSV Channel to Bit,Bytes,Chips"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140011
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gServerName & "/biztalkserverrepository/maps/microsoft/csvcustomerinputtooutput.xml"
chan.OutputDocument = Doc140012
chan.port = Port160013
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120007
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110007
chan.SetConfigComponent 3, Port160013, "{26B1C049-730C-40F5-8580-4385F05D6787}"
chan.SetConfigComponent 5, Port160013, "{CFEB5CF8-074C-11D3-BA34-00C04F79DBAA}"
Chan180011 = chan.Create
Call ErrCheck ("Chan180011")

chan.clear
chan.Name = "Channel to Bits,Bytes,Chips on CSV Final"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140012
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gServerName & "/biztalkserverrepository/maps/microsoft/csvcustomeroutputcsvfinal.xml"
chan.OutputDocument = Doc140013
chan.port = Port160015
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120005
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110005
chan.SetConfigComponent 5, Port160015, "{CFEB5CF8-074C-11D3-BA34-00C04F79DBAA}"
Chan180012 = chan.Create
Call ErrCheck ("Chan180012")

chan.clear
chan.Name = "Approval"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140014
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gServerName & "/biztalkserverrepository/maps/poapproval/mapbasicpo_decisionfactors.xml"
chan.OutputDocument = Doc140015
chan.port = Port160016
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120009
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110009
Chan180013 = chan.Create
Call ErrCheck ("Chan180013")

chan.clear
chan.Name = "Response"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140016
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.OutputDocument = Doc140016
chan.port = Port160017
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120010
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110010
Chan180014 = chan.Create
Call ErrCheck ("Chan180014")

chan.clear
chan.Name = "MailChannel"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140015
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.OutputDocument = Doc140015
chan.port = Port160018
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120001
chan.SourceEndpoint.Openness = 8
chan.SourceEndpoint.Organization = Org110001
chan.SetConfigComponent 2, Port160018, "{90E7BA41-549C-47EA-BC15-55FE6F5BBA9E}"
chan.SetConfigComponent 3, Port160018, "{26B1C049-730C-40F5-8580-4385F05D6787}"
Chan180015 = chan.Create
Call ErrCheck ("Chan180015")

chan.clear
chan.Name = "ApprovalRS"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140017
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gServerName & "/biztalkserverrepository/maps/poapproval/mapbasicpors_decisionfactors.xml"
chan.OutputDocument = Doc140015
chan.port = Port160016
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120001
chan.SourceEndpoint.Application = App130002
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110001
Chan180016 = chan.Create
Call ErrCheck ("Chan180016")

chan.clear
chan.Name = "ApproverSurrogate"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140018
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gServerName & "/biztalkserverrepository/maps/poapproval/mapdecisionfactors2_response2.xml"
chan.OutputDocument = Doc140019
chan.port = Port160019
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120009
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110009
Chan180017 = chan.Create
Call ErrCheck ("Chan180017")

chan.clear
chan.Name = "Response2"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140019
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gServerName & "/biztalkserverrepository/maps/poapproval/mapresponse2_response.xml"
chan.OutputDocument = Doc140016
chan.port = Port160020
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120009
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110009
Chan180018 = chan.Create
Call ErrCheck ("Chan180018")

chan.clear
chan.Name = "IInterchange Sample Channel"
chan.Comments = "This is IInterchange Sample Channel"
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140020
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = True
chan.LoggingInfo.LogXMLInputDocument = True
chan.LoggingInfo.LogXMLOutputDocument = True
chan.OutputDocument = Doc140021
chan.port = Port160021
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120011
chan.SourceEndpoint.Application = App130003
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110011
chan.SetConfigComponent 5, Port160021, "{DFE51866-F67D-11D2-8A13-00C04F79DBAA}"
Chan180019 = chan.Create
Call ErrCheck ("Chan180019")

chan.clear
chan.Name = "NWChannel"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140026
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gServerName & "/biztalkserverrepository/maps/poapproval/mapnwbpo_decisionfactors.xml"
chan.OutputDocument = Doc140015
chan.port = Port160016
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120024
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110018
Chan180020 = chan.Create
Call ErrCheck ("Chan180020")

chan.clear
chan.Name = "SWChannel"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140027
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gServerName & "/biztalkserverrepository/maps/poapproval/mapswbpo_decisionfactors.xml"
chan.OutputDocument = Doc140015
chan.port = Port160016
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120026
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110019
Chan180021 = chan.Create
Call ErrCheck ("Chan180021")

chan.clear
chan.Name = "CChannel"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140028
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gServerName & "/biztalkserverrepository/maps/poapproval/mapcbpo_decisionfactors.xml"
chan.OutputDocument = Doc140015
chan.port = Port160016
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120028
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110020
Chan180022 = chan.Create
Call ErrCheck ("Chan180022")

chan.clear
chan.Name = "ApprovalSecure"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140014
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.MapReference = "http://" & gServerName & "/biztalkserverrepository/maps/poapproval/mapbasicpo_decisionfactors.xml"
chan.OutputDocument = Doc140015
chan.port = Port160016
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120009
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110009
Chan180023 = chan.Create
Call ErrCheck ("Chan180023")

chan.clear
chan.Name = "ResponseSigned"
chan.Comments = ""
chan.ExpectReceiptTimeout = 0
chan.Expression = ""
chan.InputDocument = Doc140016
chan.IsReceiptChannel = False
chan.LoggingInfo.LogNativeInputDocument = True
chan.LoggingInfo.LogNativeOutputDocument = False
chan.LoggingInfo.LogXMLInputDocument = False
chan.LoggingInfo.LogXMLOutputDocument = False
chan.OutputDocument = Doc140016
chan.port = Port160017
chan.ReceiptChannel = Chan0
chan.RetryCount = 3
chan.RetryInterval = 5
chan.SourceEndpoint.Alias = Alias120010
chan.SourceEndpoint.Openness = 1
chan.SourceEndpoint.Organization = Org110010
Chan180024 = chan.Create
Call ErrCheck ("Chan180024")

set chan = nothing

Set BT = nothing

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

