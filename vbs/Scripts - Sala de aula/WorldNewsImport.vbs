Dim wApp, wDoc, wRange, sName, sDate, sTime
Set wApp = CreateObject("Word.Application")
Set wDoc = wApp.Documents.Add
Set wRange = wDoc.Range
sName = "VBScript Student"
sDate = Date()
sTime = Time()
sContent = "Document created by " & sName & " at " & sTime & " on " & sDate & "!"
wRange.Style = -3
wRange.Font.Color = 255
wRange.Text = sContent
wDoc.SaveAs "C:\Automating Word.doc"
wApp.Quit
Set sRange = Nothing
Set wDoc = Nothing
Set wApp = Nothing
WScript.Echo "Your Document has been saved as C:\Automating Word.doc"