'Get Applications collection
Set catalog = CreateObject("COMAdmin.COMAdminCatalog")
Set Applications = Catalog.GetCollection("Applications") 

'Add a new COM+ application named DemoApp
Set NewApp = Applications.Add
NewApp.Value("Name") = "DemoApp"

'Application is not added until SaveChanges called
Applications.SaveChanges

'Use Populate to retrieve all the applications
Applications.Populate

'Find DemoApp and print out activation type
For Each AppObject in Applications
  If AppObject.Name = "DemoApp" Then 
    If AppObject.Value("Activation") = 0 Then
      WScript.Echo "Activation type is Library."
    Else
      WScript.Echo "Activation type is Server."
    End If
    Exit For
  End If
Next 

'Get the Roles collection for DemoApp
Set RolesInApp = Applications.GetCollection("Roles", NewApp.Value("ID"))

'Create a new role called Manager
Set NewRole = rolesInApp.Add
NewRole.Value("Name") = "Managers"

'Role is not added until SaveChanges called
RolesInApp.SaveChanges

'Install HelloWorld component
Catalog.InstallComponent "DemoApp","HelloWorld.dll","",""

