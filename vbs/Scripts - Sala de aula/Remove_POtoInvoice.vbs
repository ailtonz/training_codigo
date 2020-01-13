'#######################################################################
'# Remove_POReqTotal.vbs
'# Copyright (C) 2000 Microsoft Corporation
'#######################################################################

Dim cat  'COMAdminCatalog
Dim apps 'COMAdminCatalogCollection
Dim app  'COMAdminCatalogObject

Const strAppName = "BizTalk Server Tutorial POReqTotal Component"
Const guidLegacyProduct = "{75D98DE0-E0F9-4430-954E-9420FDF03DE5}"
Const guidProduct = "{89E9C462-ABDC-47E6-883F-8BB2F32C3D4C}"   'Package App ID

Dim objInstaller 'WindowsInstaller.Installer
Dim pathDLL      'String
Dim pathTLB      'String
Dim pathPSDLL    'String

'-----------------------------------------------------------------------

Set FileSys = CreateObject("Scripting.FileSystemObject")
pathDLL = FileSys.GetParentFolderName(FileSys.GetParentFolderName(Wscript.ScriptFullName)) & "\Components\POtoInvoice\Solution\POToINVAIC.dll"

'Open a session with the catalog; Instantiate a COMAdminCatalog object
'Create a new COM+ application; get the "Applications" collection from the catalog
Set cat = CreateObject("COMAdmin.COMAdminCatalog")
Set apps = cat.GetCollection("Applications")

'Delete Previous Package from Beta If It Exists
DeleteApp apps, guidLegacyProduct

'Remove Current Package For Reinstall If It Exists
DeleteApp apps, guidProduct

Wscript.echo "Removal Complete"

'-----------------------------------------------------------------------

Private Sub DeleteApp(apps, strAppGuid)
    Dim index 'Integer
    Dim app   'COMAdminCatalogObject
    
    apps.Populate
    For index = 0 To apps.Count - 1
        Set app = apps.Item(index)
        If app.Value("ID") = strAppGuid Then
            apps.Remove (index)
            apps.SaveChanges
            Exit For
        End If
    Next
End Sub

'#######################################################################
