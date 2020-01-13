Option Explicit
Dim oExcelApp, oWorkbook, oWorksheet 
Dim iCounter, bEmpty, strUser
Dim sPath
sPath = WScript.ScriptFullName
sPath = Left(sPath,Len(sPath)-Len(WScript.ScriptName))

' create Excel
Set oExcelApp = CreateObject("Excel.Application")

' get the Users.xls file and set a reference to the workbook
Set oWorkbook = oExcelApp.Workbooks.Open(sPath & "Users.xls")

' get a reference to the 1st worksheet and activate it
Set oWorksheet = oWorkbook.Worksheets(1)
oWorksheet.Activate
' make Excel visible
oExcelApp.Visible = True

iCounter = 2		' start on the 2nd row
' loop through the rows bringing back the value of the 1st column
Do Until bEmpty = True    
    strUser = oWorksheet.Cells(iCounter, 1)	' row, column
    
    If strUser = "" Then
        bEmpty = True
    Else
    	' add a user passing down the values from the cells
    	AddUser oWorksheet.Cells(iCounter, 1), oWorksheet.Cells(iCounter, 2), _ 
    		oWorksheet.Cells(iCounter, 3), oWorksheet.Cells(iCounter, 4), _ 
    		oWorksheet.Cells(iCounter, 5), oWorksheet.Cells(iCounter, 6), _ 
    		oWorksheet.Cells(iCounter, 7)
	    
	    iCounter = iCounter + 1
    End If
Loop

' close Excel
oExcelApp.Quit
WScript.Quit 

Sub AddUser(byVal sCN, byVal sUserName, byVal sFirstName, byVal sLastName, _ 
	byVal sPhone, byVal sPassword, byVal sEMail)
	
	Dim oUSR, oOU
	' bind to the target OU
	Set oOU = GetObject("LDAP://OU=StudentXOU,DC=NWTraders,DC=msft")
	Set oUSR = oOU.Create("user", "CN=" & sCN) 
	
	' set the properties of the new user
	oUSR.Put "samAccountName", cstr(sUserName)
	oUSR.Put "givenname", cstr(sFirstName)
	oUSR.Put "sn", cstr(sLastName)
	oUSR.Put "telephonenumber", cstr(sPhone)
	oUSR.Put "mail", cstr(sEMail)
	oUSR.SetInfo
	
	msgbox sUserName & " created successfully"
	
	oUSR.SetPassword cstr(sPassword)
	oUSR.AccountDisabled = False
	oUSR.SetInfo
End Sub
