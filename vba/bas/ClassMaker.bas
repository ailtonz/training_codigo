Attribute VB_Name = "ClassMaker"
'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
'-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''-=-=-=-
Public Sub ClassMaker()                                                                                 '=-=-=-=
    Const STR_CAMINHO As String = "D:\Workstation\ClassMaker\Arquivos"                                  '-=-=-=-
                                                                                                        '=-=-=-=
    AdicionaReferencia "{00025E01-0000-0000-C000-000000000046}" 'DAO                                    '-=-=-=-
    AdicionaReferencia "{00000201-0000-0010-8000-00AA006D2EA4}" 'ADO 2.1                                '=-=-=-=
    AdicionaReferencia "{4AFFC9A0-5F99-101B-AF4E-00AA003F0F07}" 'ACCESS                                 '=-=-=-=
    ImportaClasse ActiveWorkbook, STR_CAMINHO & "\Banco.cls", "Banco"                                   '-=-=-=-
    ImportaClasse ActiveWorkbook, STR_CAMINHO & "\Atributo.cls", "Atributo"                             '=-=-=-=
    ImportaClasse ActiveWorkbook, STR_CAMINHO & "\Classe.cls", "Classe"                                 '-=-=-=-
    ImportaClasse ActiveWorkbook, STR_CAMINHO & "\Util.bas", "Util"                                     '=-=-=-=
    ImportaClasse ActiveWorkbook, STR_CAMINHO & "\frmClassMaker.frm", "frmClassMaker"                   '-=-=-=-
    ActiveWorkbook.VBProject.VBComponents.Remove ActiveWorkbook.VBProject.VBComponents("ClassMaker")    '=-=-=-=
End Sub                                                                                                 '-=-=-=-
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''=-=-=-=
'-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
'=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
'-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
'{00000201-0000-0010-8000-00AA006D2EA4}
Public Function ImportaClasse(ByVal wb As Workbook, ByVal CompFileName As String, pNomeClasse As String)
    If Dir(CompFileName) <> "" Then
        On Error Resume Next
        wb.VBProject.VBComponents.Remove wb.VBProject.VBComponents(pNomeClasse)
        DoEvents
        wb.VBProject.VBComponents.Import CompFileName
        On Error GoTo 0
    End If
    Set wb = Nothing
End Function
Private Function AdicionaReferencia(pGUID As String)
    Dim theRef As Variant, i As Long
    On Error Resume Next
     
    For i = ThisWorkbook.VBProject.References.Count To 1 Step -1
        Set theRef = ThisWorkbook.VBProject.References.Item(i)
        If theRef.IsBroken = True Then
            ThisWorkbook.VBProject.References.Remove theRef
        End If
    Next i
    err.Clear
     
    'Add the reference
    ThisWorkbook.VBProject.References.AddFromGuid GUID:=pGUID, Major:=1, Minor:=0
     
    Select Case err.Number
    Case Is = 32813 'Reference already in use.  No action necessary
    Case Is = vbNullString 'Reference added without issue
    Case Else 'An unknown error was encountered, so alert the user
        MsgBox "A problem was encountered trying to" & vbNewLine _
        & "add or remove a reference in this file" & vbNewLine & "Please check the " _
        & "references in your VBA project!", vbCritical + vbOKOnly, "Error!"
    End Select
    On Error GoTo 0
End Function
Private Sub ListReferencePaths()
     'Macro purpose:  To determine full path and Globally Unique Identifier (GUID)
     'to each referenced library.  Select the reference in the Tools\References
     'window, then run this code to get the information on the reference's library
     
    On Error Resume Next
    Dim i As Long
    With ThisWorkbook.Sheets(1)
        .Cells.Clear
        .Range("A1") = "Reference name"
        .Range("B1") = "Full path to reference"
        .Range("C1") = "Reference GUID"
    End With
    For i = 1 To ThisWorkbook.VBProject.References.Count
        With ThisWorkbook.VBProject.References(i)
            ThisWorkbook.Sheets(1).Range("A65536").End(xlUp).Offset(1, 0) = .Name
            ThisWorkbook.Sheets(1).Range("A65536").End(xlUp).Offset(0, 1) = .FullPath
            ThisWorkbook.Sheets(1).Range("A65536").End(xlUp).Offset(0, 2) = .GUID
        End With
    Next i
    On Error GoTo 0
End Sub
