Attribute VB_Name = "modColorPicker"
' Original Code by Terry Kreft
' Modified by Stephen Lebans
' Contact Stephen@lebans.com

Option Compare Database
Option Explicit
'***********  Code Start  ***********
Private Type COLORSTRUC
  lStructSize As Long
  hwnd As Long
  hInstance As Long
  rgbResult As Long
  lpCustColors As String
  Flags As Long
  lCustData As Long
  lpfnHook As Long
  lpTemplateName As String
End Type

Private Const CC_SOLIDCOLOR = &H80

Private Declare Function ChooseColor Lib "comdlg32.dll" Alias "ChooseColorA" _
  (pChoosecolor As COLORSTRUC) As Long

Public Function aDialogColor(ByVal hwnd As Long) As Long
  Dim x As Long, CS As COLORSTRUC, CustColor(16) As Long

  CS.lStructSize = Len(CS)
  If hwnd <> 0 Then
  CS.hwnd = hwnd
  Else
  CS.hwnd = Application.hWndAccessApp
  End If
  CS.Flags = CC_SOLIDCOLOR
  CS.lpCustColors = String$(16 * 4, 0)
  x = ChooseColor(CS)
  If x = 0 Then
    ' ERROR - use Default White
    'prop = RGB(255, 255, 255) ' White
    aDialogColor = -1 'False
    Exit Function
  Else
    ' Normal processing
     aDialogColor = CS.rgbResult
  End If
  
End Function
'***********  Code End   ***********



