#include <FF.au3>
;~ #include <FF_AutoLogin.au3>

;~ If _FFConnect () Then

local $open = _FFWindowOpen("www.gmail.com")
_FFloadwait($open)
WinActivate($open)

;~ _FF_AutoLogin("user","password")
;~ EndIf