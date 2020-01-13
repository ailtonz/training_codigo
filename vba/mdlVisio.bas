Attribute VB_Name = "mdlVisio"
Option Explicit


Private visPage As Visio.Page
Private visDoc As Visio.Document
Private strCurrPath As String
Private fileOut As String


Public Sub createTextList()

    Dim arrString() As String
    Dim strFile As String
    ' output file name
    strFile = PathGetDesktopAddress & "testfile.txt"
    ' read the text field from each of the shapes and return an array
    arrString = cyclePageShapes(Application.ActivePage)
    ' write the text fields out to a file
    writeTextFile strFile, arrString


End Sub

' go get an array of text strings
Private Function cyclePageShapes(ByVal currPage As Visio.Page) _
    As String()

    On Error GoTo ErrHandler

    Dim visShape As Visio.Shape
    Dim arrString() As String
    ReDim arrString(currPage.Shapes.Count)
    Dim intX As Integer
    intX = 1
    
    For Each visShape In currPage.Shapes
        arrString(intX) = visShape.Text
        intX = intX + 1
    Next visShape
        
    cyclePageShapes = arrString
    Exit Function

ErrHandler:

    Debug.Print Err.Description
    cyclePageShapes = arrString
    
End Function


'****************************************************
' File methods
'****************************************************


Private Function folderExists(ByVal strFolderName As String) _
        As Boolean

    Dim blnReturn As Boolean:       blnReturn = False
    Dim FSO As Variant:             Set FSO = CreateObject("Scripting.FileSystemObject")
    
    blnReturn = FSO.folderExists(strFolderName)
    ' release the filesystemobject
    Set FSO = Nothing

    folderExists = blnReturn

End Function


Private Function fileExists(ByVal strFileName As String) _
        As Boolean

    Dim blnReturn As Boolean:   blnReturn = False
    Dim FSO As Variant:         Set FSO = CreateObject("Scripting.FileSystemObject")
    
    blnReturn = FSO.fileExists(strFileName)
    ' release the filesystemobject
    Set FSO = Nothing

    fileExists = blnReturn

End Function

'
' pass in the file name and an array of strings
'
Private Sub writeTextFile( _
    ByVal strFileName As String, _
    ByRef arrString() As String)
     
    Dim FSO As Variant:             Set FSO = CreateObject("Scripting.FileSystemObject")
    Dim FSOtextfile As Variant:     Set FSOtextfile = FSO.OpenTextFile(strFileName, 2, True)
    Dim intCt As Integer
    Dim strText As String
    
        
    For intCt = 1 To UBound(arrString)
        strText = arrString(intCt)
        FSOtextfile.WriteLine (strText)
    Next intCt
    
    FSOtextfile.Close
        
End Sub

'****************************************************
'
'****************************************************

Private Sub Document_DocumentOpened(ByVal Doc As IVDocument)
    Set visDoc = Doc
    strCurrPath = Doc.Path
    Set visPage = Application.ActivePage
End Sub



Function PathGetDesktopAddress() As String
    PathGetDesktopAddress = CreateObject("WScript.Shell").SpecialFolders("Desktop") & "\"
End Function
