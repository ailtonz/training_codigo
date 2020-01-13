Set catalog = CreateObject("COMAdmin.COMAdminCatalog")
Set apps= catalog.GetCollection("Applications")
apps.populate
Set newApp = apps.Add
newApp.Value("Name") = "ScriptApp"
apps.SaveChanges

