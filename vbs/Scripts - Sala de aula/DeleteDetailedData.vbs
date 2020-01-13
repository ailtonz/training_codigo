Set catalog = CreateObject("COMAdmin.COMAdminCatalog")
Set apps= catalog.GetCollection("Applications")
apps.populate
numApps = apps.Count
For i = numApps - 1 To 0 Step -1
	if apps.Item(i).Value("Name") = "ScriptApp" then
		apps.Remove(i)
	end if 
Next
apps.SaveChanges