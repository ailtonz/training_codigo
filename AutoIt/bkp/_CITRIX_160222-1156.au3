;~ #include <File.au3>
;~ #include <IE.au3>

;~ Global Enum $eAutomatioName,$USER,$PWS,$eCaminho,$eForm,$eUser,$ePWS,$oIE,$oForm,$o_txt_user,$o_txt_pwd,$hFile,$s_Directory,$data
;~ Global $sApp[14]

;~ $sApp[$eAutomatioName]		=	"ROBO - LOGIN APP CITRIX"


;~ $sApp[$eCaminho]			=	"http://citrixaccenture.vivo.com.br/Citrix/XenApp/auth/login.aspx"
;~ $sApp[$eForm]				=	"CitrixForm"
;~ $sApp[$eUser]				=	"user"
;~ $sApp[$ePWS]				=	"password"
;~ $sApp[$USER]				=	"80397308"
;~ $sApp[$PWS]					=	"41L70N!$"
;~ $sApp[$oIE]					=	_IECreate($sApp[$eCaminho])

;~ $sApp[$data]				=	@YEAR&@MON&@MDAY&"_"&@HOUR&@MIN
;~ $sApp[$s_Directory]			= 	@ScriptDir
;~ $sApp[$hFile] 				= 	FileOpen($sApp[$s_Directory] & "\" & StringReplace(@ScriptName,".exe","") & "_" & $data & ".log", 1)


;~ ;Liga a opção de eventos de controle
;~ Opt("GUIOnEventMode",1)

;~ ;Quando pressionar a tecla 'END' sai da rotina
;~ HotKeySet("^{END}", "CaptureEND")


;~ _IELoadWait($sApp[$oIE])

;~ $sApp[$oForm]				=	_IEFormGetObjByName($sApp[$oIE], $sApp[$eForm])
;~ $sApp[$o_txt_user]			=	_IEFormElementGetObjByName($sApp[$oForm], $sApp[$eUser])
;~ $sApp[$o_txt_pwd]			=	_IEFormElementGetObjByName($sApp[$oForm], $sApp[$ePWS])
;~ _IEFormElementSetValue($sApp[$o_txt_user], $sApp[$USER])
;~ _IEFormElementSetValue($sApp[$o_txt_pwd], $sApp[$PWS])
;~ _IEFormSubmit($sApp[$oForm])


;~ Sleep(2000)


;~ global $hWnd = WinWait("[REGEXPTITLE:" & "VivoCorp" & ".+]")

;~ if $hWnd <> 0 Then


;~ $sApp[$eCaminho]			=	"http://vivocorp.vivo.com.br/vivocorp/start.swe?SWECmd=Start&SWEHo=vivocorp.vivo.com.br"
;~ $sApp[$eForm]				=	"SWEEntryForm"
;~ $sApp[$eUser]				=	"SWEUserName"
;~ $sApp[$ePWS]				=	"SWEPassword"

;~ $sApp[$USER]				=	"A5128875"
;~ $sApp[$PWS]					=	"Senha@2017"
;~ $sApp[$oIE]					=	_IECreate($sApp[$eCaminho])



;~ _IELoadWait($sApp[$oIE])

;~ $sApp[$oForm]				=	_IEFormGetObjByName($sApp[$oIE], $sApp[$eForm])
;~ $sApp[$o_txt_user]			=	_IEFormElementGetObjByName($sApp[$oForm], $sApp[$eUser])
;~ $sApp[$o_txt_pwd]			=	_IEFormElementGetObjByName($sApp[$oForm], $sApp[$ePWS])
;~ _IEFormElementSetValue($sApp[$o_txt_user], $sApp[$USER])
;~ _IEFormElementSetValue($sApp[$o_txt_pwd], $sApp[$PWS])
;~ _IEFormSubmit($sApp[$oForm])


;~ EndIf

;~ exit


;~ Func CaptureEND()
;~  Switch @HotKeyPressed ; The last hotkey pressed.
;~ 	 Case "^{END}" ; String is the {END} hotkey.
;~    Exit
;~  EndSwitch
;~ EndFunc