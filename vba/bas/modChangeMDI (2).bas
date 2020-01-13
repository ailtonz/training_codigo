Attribute VB_Name = "modChangeMDI"
Option Compare Database
Option Explicit

' ****CODE START****
' Place this code in a standard module.
' make sure you do not name the module
' to conflict with any of the functions below.


'Author:        Stephen Lebans
'               Stephen@lebans.com
'               www.lebans.com
'               May 03, 2003
'
'Copyright:     Lebans Holdings 1999 Ltd.
'
'Functions:     See function declarations inline
'
'Dependencies:
'                You must import the following modules into your own application in
'                order for all of the functions contained in this project to work properly.
'
'               modChangeMDI
'               modColorPicker
'               cDIBSection
'               clsCommonDialog

'
'Credits:       Nobody<grin>
'
'
'Why?:          Somebody asked for it!
'
'What's Missing: User selectable props for scaling, position of Bitmap.
'
'BUGS:          Let me know!
'
' NOTES:        *****************************************************
'               YOU MUST DELETE ANY BRUSHES YOU CREATE!
'
'           :-)
Private Type RECT
    Left As Long
    TOP As Long
    right As Long
    Bottom As Long
End Type

Private Type SIZEL
    cx As Long
    cy As Long
End Type


Private Type RGBQUAD
  rgbBlue As Byte
  rgbGreen As Byte
  rgbRed As Byte
  rgblReserved As Byte
End Type

Private Type BITMAPINFOHEADER '40 bytes
  biSize As Long ' 40
  biWidth As Long ' 32
  biHeight As Long ' 64
  biPlanes As Integer '1
  biBitCount As Integer '1
  biCompression As Long 'ERGBCompression
  biSizeImage As Long
  biXPelsPerMeter As Long
  biYPelsPerMeter As Long
  biClrUsed As Long
  biClrImportant As Long
End Type


Private Type BITMAPINFO
  bmiHeader As BITMAPINFOHEADER
  bmiColors(1) As RGBQUAD
End Type


Private Type BITMAP
  bmType As Long
  bmWidth As Long
  bmHeight As Long
  bmWidthBytes As Long
  bmPlanes As Integer
  bmBitsPixel As Integer
  bmBits As Long
End Type



' Logical Brush (or Pattern)
Private Type LOGBRUSH
        lbStyle As Long
        lbColor As Long
        lbHatch As Long
End Type

Private Type WNDCLASS
    style As Long
    lpfnwndproc As Long
    cbClsextra As Long
    cbWndExtra2 As Long
    hInstance As Long
    hIcon As Long
    hCursor As Long
    hbrBackground As Long
    lpszMenuName As String
    lpszClassName As String
End Type




Type WNDCLASSEX
    cbSize As Long
    style As Long
    lpfnwndproc As Long
    cbClsextra As Long
    cbWndExtra As Long
    hInstance As Long
    hIcon As Long
    hCursor As Long
    hbrBackground As Long
    lpszMenuName As String
    lpszClassName As String
    hIconSm As Long
End Type

Private Declare Function GetSysColor Lib "user32" (ByVal nIndex As Long) As Long

Private Declare Function SetTextColor Lib "gdi32" (ByVal hDC As Long, ByVal crColor As Long) As Long

Private Declare Function GetDC Lib "user32" (ByVal hwnd As Long) As Long

Private Declare Function DeleteDC Lib "gdi32" (ByVal hDC As Long) As Long

Private Declare Function apiGetDeviceCaps Lib "gdi32" _
Alias "GetDeviceCaps" (ByVal hDC As Long, ByVal nIndex As Long) As Long

Private Declare Function CreateSolidBrush Lib "gdi32" _
 _
(ByVal crColor As Long) As Long

Private Declare Function DeleteObject Lib "gdi32" _
(ByVal hObject As Long) As Long

Private Declare Function SelectObject Lib "gdi32" _
(ByVal hDC As Long, ByVal hObject As Long) As Long


Private Declare Function GetStockObject Lib "gdi32" _
(ByVal nIndex As Long) As Long
                    
Private Declare Function CreateHatchBrush Lib "gdi32" (ByVal nIndex As Long, ByVal crColor As Long) As Long
Private Declare Function CreatePatternBrush Lib "gdi32" (ByVal hBitmap As Long) As Long
Private Declare Function CreateDIBPatternBrush Lib "gdi32" (ByVal hPackedDIB As Long, ByVal wUsage As Long) As Long
Private Declare Function CreateDIBPatternBrushPt Lib "gdi32" (lpPackedDIB As Any, ByVal iUsage As Long) As Long

Private Declare Function SetClassLong Lib "user32" Alias "SetClassLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long

Private Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hwnd1 As Long, ByVal hwnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long

Private Declare Function GetWindowRect Lib "user32" (ByVal hwnd As Long, lpRect As RECT) As Long

Private Declare Function InvalidateRect Lib "user32" (ByVal hwnd As Long, lpRect As RECT, ByVal bErase As Long) As Long

Private Declare Function SetBkColor Lib "gdi32" (ByVal hDC As Long, ByVal crColor As Long) As Long
Private Declare Function SetBkMode Lib "gdi32" (ByVal hDC As Long, ByVal nBkMode As Long) As Long



Private Declare Function apiGetClassName Lib "user32" _
    Alias "GetClassNameA" _
    (ByVal hwnd As Long, _
    ByVal lpClassName As String, _
    ByVal nMaxCount As Long) _
    As Long

Private Declare Function apiGetParent Lib "user32" _
    Alias "GetParent" _
    (ByVal hwnd As Long) _
    As Long

Private Declare Function apiGetWindow Lib "user32" _
    Alias "GetWindow" _
    (ByVal hwnd As Long, _
    ByVal wCmd As Long) _
    As Long

Private Declare Function GetWindowDC Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function ReleaseDC Lib "user32" (ByVal hwnd As Long, ByVal hDC As Long) As Long


Private Declare Function apiSendMessage Lib "user32" _
  Alias "SendMessageA" _
  (ByVal hwnd As Long, _
  ByVal wMsg As Long, _
  ByVal wparam As Long, _
  lparam As Any) As Long


Private Declare Function RedrawWindow Lib "user32" _
(ByVal hwnd As Long, lprcUpdate As RECT, ByVal hrgnUpdate As Long, ByVal fuRedraw As Long) As Long


Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" _
(ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long

Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" _
(ByVal hwnd As Long, ByVal nIndex As Long) As Long


Private Declare Function LoadIcon Lib "user32" Alias "LoadIconA" _
(ByVal hInstance As Long, ByVal lpIconName As String) As Long

Private Declare Function LoadCursor Lib "user32" Alias "LoadCursorA" _
(ByVal hInstance As Long, ByVal lpCursorName As String) As Long

Private Declare Function GetClassInfo Lib "user32" Alias "GetClassInfoA" _
(ByVal hInstance As Long, ByVal lpClassName As String, lpWndClass As WNDCLASS) As Long


Private Declare Function GetClassInfoEx Lib "user32" Alias "GetClassInfoExA" _
(ByVal hInstance As Long, ByVal lpClassName As String, lpWndClass As WNDCLASSEX) As Long

' Class field offsets for GetClassLong() and GetClassWord()
Private Const GCL_MENUNAME = (-8)
Private Const GCL_HBRBACKGROUND = (-10)
Private Const GCL_HCURSOR = (-12)
Private Const GCL_HICON = (-14)
Private Const GCL_HMODULE = (-16)
Private Const GCL_CBWNDEXTRA = (-18)
Private Const GCL_CBCLSEXTRA = (-20)
Private Const GCL_WNDPROC = (-24)
Private Const GCL_STYLE = (-26)
Private Const GCW_ATOM = (-32)

' Window field offsets for GetWindowLong() and GetWindowWord()
Private Const GWL_WNDPROC = (-4)
Private Const GWL_HINSTANCE = (-6)
Private Const GWL_HWNDPARENT = (-8)
Private Const GWL_STYLE = (-16)
Private Const GWL_EXSTYLE = (-20)
Private Const GWL_USERDATA = (-21)
Private Const GWL_ID = (-12)


' Stock Logical Objects
Private Const WHITE_BRUSH = 0
Private Const LTGRAY_BRUSH = 1
Private Const GRAY_BRUSH = 2
Private Const DKGRAY_BRUSH = 3
Private Const BLACK_BRUSH = 4
Private Const NULL_BRUSH = 5
Private Const HOLLOW_BRUSH = NULL_BRUSH


Private Const CLR_INVALID = &HFFFF

' Brush Styles
Private Const BS_SOLID = 0
Private Const BS_NULL = 1
Private Const BS_HOLLOW = BS_NULL
Private Const BS_HATCHED = 2
Private Const BS_PATTERN = 3
Private Const BS_INDEXED = 4
Private Const BS_DIBPATTERN = 5
Private Const BS_DIBPATTERNPT = 6
Private Const BS_PATTERN8X8 = 7
Private Const BS_DIBPATTERN8X8 = 8

'  Hatch Styles
Private Const HS_HORIZONTAL = 0              '  -----
Private Const HS_VERTICAL = 1                '  |||||
Private Const HS_FDIAGONAL = 2               '  \\\\\
Private Const HS_BDIAGONAL = 3               '  /////
Private Const HS_CROSS = 4                   '  +++++
Private Const HS_DIAGCROSS = 5               '  xxxxx
Private Const HS_FDIAGONAL1 = 6
Private Const HS_BDIAGONAL1 = 7
Private Const HS_SOLID = 8
Private Const HS_DENSE1 = 9
Private Const HS_DENSE2 = 10
Private Const HS_DENSE3 = 11
Private Const HS_DENSE4 = 12
Private Const HS_DENSE5 = 13
Private Const HS_DENSE6 = 14
Private Const HS_DENSE7 = 15
Private Const HS_DENSE8 = 16
Private Const HS_NOSHADE = 17
Private Const HS_HALFTONE = 18
Private Const HS_SOLIDCLR = 19
Private Const HS_DITHEREDCLR = 20
Private Const HS_SOLIDTEXTCLR = 21
Private Const HS_DITHEREDTEXTCLR = 22
Private Const HS_SOLIDBKCLR = 23
Private Const HS_DITHEREDBKCLR = 24
Private Const HS_API_MAX = 25

' Color Types
Private Const CTLCOLOR_MSGBOX = 0
Private Const CTLCOLOR_EDIT = 1
Private Const CTLCOLOR_LISTBOX = 2
Private Const CTLCOLOR_BTN = 3
Private Const CTLCOLOR_DLG = 4
Private Const CTLCOLOR_SCROLLBAR = 5
Private Const CTLCOLOR_STATIC = 6
Private Const CTLCOLOR_MAX = 8   '  three bits max

Private Const COLOR_SCROLLBAR = 0
Private Const COLOR_BACKGROUND = 1
Private Const COLOR_ACTIVECAPTION = 2
Private Const COLOR_INACTIVECAPTION = 3
Private Const COLOR_MENU = 4
Private Const COLOR_WINDOW = 5
Private Const COLOR_WINDOWFRAME = 6
Private Const COLOR_MENUTEXT = 7
Private Const COLOR_WINDOWTEXT = 8
Private Const COLOR_CAPTIONTEXT = 9
Private Const COLOR_ACTIVEBORDER = 10
Private Const COLOR_INACTIVEBORDER = 11
Private Const COLOR_APPWORKSPACE = 12
Private Const COLOR_HIGHLIGHT = 13
Private Const COLOR_HIGHLIGHTTEXT = 14
Private Const COLOR_BTNFACE = 15
Private Const COLOR_BTNSHADOW = 16
Private Const COLOR_GRAYTEXT = 17
Private Const COLOR_BTNTEXT = 18
Private Const COLOR_INACTIVECAPTIONTEXT = 19
Private Const COLOR_BTNHIGHLIGHT = 20



Private Const WM_SYSCOLORCHANGE = &H15


' GetWindow() Constants
Private Const GW_HWNDNEXT = 2
Private Const GW_CHILD = 5

Private Const TITLE = ""
Private Const API_TRUE As Long = 1&
' Handle to original WINDOWCLASS Brush for MDI window
Private prevHBrush As Long
' Handle to our new Brush for the MDI window
Private hBrush As Long

' Handle to MDI window
Private hWndMDI As Long


' Handle to original WINDOWCLASS Brush for MDI window
Private prevHBrushStatus As Long
' Handle to our new Brush for the MDI window
Private hBrushStatus As Long

Public Function SetMDIBackGroundImage(Optional fName As String = "") As Boolean
' junk var
Dim lngRet As Long
Dim hBrushImage As Long
Dim hBrushImagePrev As Long
Dim Caminho As String


' Window Rect
Dim rc As RECT
' An instance of our DIBSection calss
Dim ds As New cDIBSection

Caminho = Application.CurrentProject.Path & "\Fundo.bmp"

If Len(fName & vbNullString) = 0 Then
    ' Call File Dialog
    If VerificaExistenciaDeArquivo(Caminho) Then
        fName = Caminho 'ds.FileDialog(True)
    Else
        Exit Function
    End If
End If
' Load the Bitmap file selected and create a DIBSection
' based on this Bitmap.
ds.Load fName

' Create a brush from the Bitmap we loaded
hBrushImage = CreatePatternBrush(ds.hDib)

' find MDIClient first
hWndMDI = FindWindowEx(Application.hWndAccessApp, 0&, "MDIClient", TITLE)
' Get current dimensions
lngRet = GetWindowRect(hWndMDI, rc)

With rc
.Bottom = .Bottom - .TOP
.TOP = 0
.right = .right - .Left
.Left = 0
End With
hBrushImagePrev = SetClassLong(hWndMDI, GCL_HBRBACKGROUND, hBrushImage)
' Force a redraw
Call InvalidateRect(hWndMDI, rc, API_TRUE)
SetMDIBackGroundImage = True

' Cleanup
' Delete old brush
lngRet = DeleteObject(hBrushImagePrev)
Set ds = Nothing
End Function


Public Function RestoreMDIBackGroundImage(Optional crColor As Long = -1) As Boolean
' junk var
Dim lngRet As Long
Dim hBrushImage As Long
Dim hBrushImagePrev As Long

' Window Rect
Dim rc As RECT
' An instance of our DIBSection calss

If crColor <> -1 Then
    hBrushImage = CreateSolidBrush(crColor)
Else
    ' Create a brush from the Bitmap we loaded
    hBrushImage = CreateSolidBrush(GetSysColor(COLOR_APPWORKSPACE))
End If

' find MDIClient first
hWndMDI = FindWindowEx(Application.hWndAccessApp, 0&, "MDIClient", TITLE)
' Get current dimensions
lngRet = GetWindowRect(hWndMDI, rc)

With rc
.Bottom = .Bottom - .TOP
.TOP = 0
.right = .right - .Left
.Left = 0
End With
hBrushImagePrev = SetClassLong(hWndMDI, GCL_HBRBACKGROUND, hBrushImage)
' Force a redraw
Call InvalidateRect(hWndMDI, rc, API_TRUE)
RestoreMDIBackGroundImage = True

' Cleanup
' Delete old brush
lngRet = DeleteObject(hBrushImagePrev)
End Function








Public Function SetStatusBackGround(ByVal BGColor As Long, Optional TextColor As Long = -1) As Boolean
' I tried to set a nwe Brush for the default BackGround brush for this
' window class but Access did not respect this change. I noticed that this window class
' is spec'd to have its own Device Context for each instance of the class so I
' decided to modify the DC's props directly.

' junk var
Dim lngRet As Long

' Window Rect
Dim rc As RECT
' This window's Device Context
Dim hDC As Long

' Handle to Status window
Dim hWndStatus As Long

' The Status Bar's window handle
hWndStatus = FindWindowEx(Application.hWndAccessApp, 0&, "OStatbar", vbNullString)

' Get current dimensions of the Status Bar window
lngRet = GetWindowRect(hWndStatus, rc)

With rc
    .Bottom = .Bottom - .TOP
    .TOP = 0
    .right = .right - .Left
    .Left = 0
End With

' Let's set the DC's properties directly
hDC = GetDC(hWndStatus)
' Set the Background Color of this DC
lngRet = SetBkColor(hDC, BGColor)
' Were we passed a new forecolor for the Text?
If TextColor <> -1 Then
    lngRet = SetTextColor(hDC, TextColor)
End If

' Always release the DC ASAP
lngRet = ReleaseDC(hWndStatus, hDC)

' Force a redraw
Call InvalidateRect(hWndStatus, rc, API_TRUE)
SetStatusBackGround = True
End Function


Public Function RestoreStatusBackground() As Boolean
' Restore to default colors

' junk var
Dim lngRet As Long

Dim ButtonFaceColor  As Long
' Window Rect
Dim rc As RECT
' This window's Device Context
Dim hDC As Long
' Handle to Status window
Dim hWndStatus As Long

' Current system color
ButtonFaceColor = GetSysColor(COLOR_BTNFACE)

' The Status Bar's window handle
hWndStatus = FindWindowEx(Application.hWndAccessApp, 0&, "OStatbar", vbNullString)

' Get current dimensions of the Status Bar window
lngRet = GetWindowRect(hWndStatus, rc)

With rc
    .Bottom = .Bottom - .TOP
    .TOP = 0
    .right = .right - .Left
    .Left = 0
End With

' Let's set the DC's properties directly
hDC = GetDC(hWndStatus)
' Set the Background Color of this DC
lngRet = SetBkColor(hDC, ButtonFaceColor)
' Set Text ForeColor to BLACK
lngRet = SetTextColor(hDC, 0)

' Always release the DC ASAP
lngRet = ReleaseDC(hWndStatus, hDC)

' Force a redraw
Call InvalidateRect(hWndStatus, rc, API_TRUE)
RestoreStatusBackground = True
' Force a redraw
Call InvalidateRect(hWndStatus, rc, API_TRUE)

RestoreStatusBackground = True
End Function





Private Function FindDetailWindow(ByVal frmhWnd As Long) As Long
' The Detail Window is always the second of three
' windows of class OFormSub.
' 1) Form Header
' 2) Detail
' 3) Footer


Dim hWnd_VSB As Long
Dim hwnd As Long
Dim CTR As Long

CTR = 0
hwnd = frmhWnd
    
    ' Let's get first Child Window of the FORM
    hWnd_VSB = apiGetWindow(hwnd, GW_CHILD)
                
    ' Let's walk through every sibling window of the Form
    Do
        ' Thanks to Terry Kreft for explaining
        ' why the apiGetParent acll is not required.
        ' Terry is in a Class by himself! :-)
        'If apiGetParent(hWnd_VSB) <> hWnd Then Exit Do
            
        If fGetClassName(hWnd_VSB) = "OFormSub" Then
            CTR = CTR + 1
            If CTR = 2 Then
                FindDetailWindow = hWnd_VSB
                Exit Function
            End If
            
        End If
    
    ' Let's get the NEXT SIBLING Window
    hWnd_VSB = apiGetWindow(hWnd_VSB, GW_HWNDNEXT)
    
    ' Let's Start the process from the Top again
    ' Really just an error check
    Loop While hWnd_VSB <> 0
    
    ' SORRY - NO Vertical ScrollBar control
    ' is currently visible for this Form
    FindDetailWindow = 0
End Function


' From Dev Ashish's Site
' The Access Web
' http://www.mvps.org/access/

'******* Code Start *********
Private Function fGetClassName(hwnd As Long)
Dim strBuffer As String
Dim lngLen As Long
Const MAX_LEN = 255
    strBuffer = Space$(MAX_LEN)
    lngLen = apiGetClassName(hwnd, strBuffer, MAX_LEN)
    If lngLen > 0 Then fGetClassName = Left$(strBuffer, lngLen)
End Function
'******* Code End *********



