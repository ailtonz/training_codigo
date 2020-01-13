'#######################################################################
'# Remove_BTS_outproc.vbs
'# Copyright (C) 2000 Microsoft Corporation
'# a-aluty, 31-Jan-2000
'# Removes "BizTalk Server Out-of-Process Package." COM+ Application.
'#######################################################################

Dim cat  'COMAdminCatalog
Dim apps 'COMAdminCatalogCollection

'-----------------------------------------------------------------------
'Sets the application properties as read/write
'
Private Sub UnlockApp(apps, app)

    '### Advanced Properties
    app.Value("Deleteable") = True
    app.Value("Changeable") = True

    apps.SaveChanges
End Sub



'-----------------------------------------------------------------------
'Deletes specified COMAdminCatalogObject from COMAdminCatalog
'
Private Sub DeleteApp(apps, strAppID)
    Dim index 'Integer
    Dim app   'COMAdminCatalogObject
    
    apps.Populate
    For index = 0 To apps.Count - 1
        Set app = apps.Item(index)
        If app.Value("ID") = strAppID Then
            UnlockApp apps, app
            apps.Remove (index)
            apps.SaveChanges
            Exit For
        End If
    Next
End Sub

'-----------------------------------------------------------------------

Const strAppID = "{0C9B9BBE-E0F2-4485-9BE8-C40BAC8D0677}"

Set cat = CreateObject("COMAdmin.COMAdminCatalog")
Set apps = cat.GetCollection("Applications")
DeleteApp apps, strAppID

'-----------------------------------------------------------------------
