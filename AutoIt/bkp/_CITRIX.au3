#include <IE.au3>

Global Enum $eAutomatioName,$USER,$PWS,$eCaminho,$eForm,$eUser,$ePWS,$oIE,$oForm,$o_txt_user,$o_txt_pwd
Global $sApp[11]

$sApp[$eAutomatioName]		=	"ROBO - LOGIN APP CITRIX"
$sApp[$USER]				=	"80397308"
$sApp[$PWS]					=	"41L70N$$"

$sApp[$eCaminho]			=	"http://citrixaccenture.vivo.com.br/Citrix/XenApp/auth/login.aspx"
$sApp[$eForm]				=	"CitrixForm"
$sApp[$eUser]				=	"user"
$sApp[$ePWS]				=	"password"

$sApp[$oIE]					=	_IECreate($sApp[$eCaminho])

_IELoadWait($sApp[$oIE])

$sApp[$oForm]				=	_IEFormGetObjByName($sApp[$oIE], $sApp[$eForm])
$sApp[$o_txt_user]			=	_IEFormElementGetObjByName($sApp[$oForm], $sApp[$eUser])
$sApp[$o_txt_pwd]			=	_IEFormElementGetObjByName($sApp[$oForm], $sApp[$ePWS])
_IEFormElementSetValue($sApp[$o_txt_user], $sApp[$USER])
_IEFormElementSetValue($sApp[$o_txt_pwd], $sApp[$PWS])
_IEFormSubmit($sApp[$oForm])
exit