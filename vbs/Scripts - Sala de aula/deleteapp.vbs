'#######################################################################
'# Delete_WMI_BTS.vbs
'# a-aluty, 02-Feb-2000
'# Deletes "MicrosoftBizTalkServer" namespace from WMI.
'#######################################################################

'Reference:
'  MSDN Library - October 1999
'  Platform SDK: Windows Management Instrumentation

Private Const csNamespace = "MicrosoftBizTalkServer"

Private g_bSilent 'As Boolean

g_bSilent = False

Private Function ExistsNamespace(sNamespace) 'As Boolean
    'In: sNamespace As String
    Dim oWBEMLoc    'As SWbemLocator
    Dim oWBEMServ   'As SWbemServices
    
    On Error Resume Next
    Err.Clear
    ExistsNamespace = True
    Set oWBEMLoc = CreateObject("WbemScripting.SWbemLocator")
    Set oWBEMServ = oWBEMLoc.ConnectServer(, "root\" & sNamespace)
    If (Err.Number <> 0) Then ExistsNamespace = False
End Function

Private Function DeleteNamespace(sNamespace) 'As Boolean
    'In: sNamespace As String
    Dim oWBEMLoc    'As SWbemLocator
    Dim oWBEMServ   'As SWbemServices
    Dim oWBEMObjSet 'As SWbemObjectSet
    Dim oWBEMObj    'As SWbemObject
    
    On Error Resume Next
    Err.Clear
    DeleteNamespace = False
    Set oWBEMLoc = CreateObject("WbemScripting.SWbemLocator")
    Set oWBEMServ = oWBEMLoc.ConnectServer(, "root")
    Set oWBEMObjSet = oWBEMServ.InstancesOf("__NAMESPACE")
    
    If (Err.Number = 0) Then
        For Each oWBEMObj In oWBEMObjSet
            If (oWBEMObj.Name = sNamespace) Then
                oWBEMObj.Delete_
                If (Err.Number = 0) Then DeleteNamespace = True
                Exit Function
            End If
        Next
    End If
End Function

Public Function Silent() 'As Long
    'Entry point for setup custom action
    Dim bResult 'As Boolean
    
    g_bSilent = True
    bResult = DeleteNamespace(csNamespace)
    If bResult Then
        Silent = 1 'Action completed successfully.
    Else
        Silent = 0 'Action not executed.
    End If
End Function

Public Function Interactive() 'As Long
    Dim sMessage  'As String
    Dim lResponse 'As Long
    Dim bResult   'As Boolean
    
    bResult = ExistsNamespace(csNamespace)
    If bResult Then
        sMessage = "Delete namespace '" & csNamespace & "' from WMI?"
        lResponse = MsgBox(sMessage, vbQuestion + vbOKCancel + vbDefaultButton2)
        
        If (lResponse = vbOK) Then
            bResult = DeleteNamespace(csNamespace)
            If bResult Then
                sMessage = "Deleted namespace '" & csNamespace & "' from WMI."
                MsgBox sMessage, vbInformation + vbOKOnly
                Interactive = 1 'Action completed successfully.
            Else
                sMessage = "Could not delete namespace '" & csNamespace & "' from WMI." & vbNewLine & _
                    "Error 0x" & Hex(Err.Number) & ": " & Err.Description
                MsgBox sMessage, vbExclamation + vbOKOnly
                Interactive = 0 'Action not executed.
            End If
        End If
    Else
        sMessage = "Namespace '" & csNamespace & "' not found." & vbNewLine & _
            "Error 0x" & Hex(Err.Number) & ": " & Err.Description
        MsgBox sMessage, vbInformation + vbOKOnly
        Interactive = 0 'Action not executed.
    End If
End Function

'Uncomment one of the following lines to run silently or interactively.
Silent
'Interactive
