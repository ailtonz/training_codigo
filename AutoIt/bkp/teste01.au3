; Open a browser to the form example, get an object reference
; to the element with the name "ExampleForm".  In this case the
; result is identical to using $oForm = _IEFormGetObjByName($oIE, "ExampleForm")

#include <IE.au3>
#include <MsgBoxConstants.au3>


global $hWnd = WinWait("[REGEXPTITLE:" & "VivoCorp" & ".+]")

Local $oIE = _IE_Example($hWnd)
Local $oForm = _IEGetObjByName($oIE, "VivoCorp")

	;Maximiza a janela do VivoCorp
	WinSetState($oIE,"",@SW_MAXIMIZE)


MsgBox($MB_SYSTEMMODAL, "ExampleForm", _IEPropertyGet($oForm, "innertext") & @CRLF)
