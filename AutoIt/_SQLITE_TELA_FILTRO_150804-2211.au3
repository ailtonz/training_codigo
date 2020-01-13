#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <SQLite.au3>
#include <SQLite.dll.au3>
#include <file.au3>
#include <array.au3>
#include "funcoes_UTIL_150730-1507.au3"

#Region PreSets
HotKeySet("^{end}", "CaptureEsc")
Opt("GUIOnEventMode",1)
#EndRegion

Global $aRetArray

Global Enum $eAutomatioName,$eDirectory,$eSleepTime,$eCNTA,$eUSER,$ePWS,$eTitle,$eBanco,$eTable,$eTmp,$eGrupo
Global $sApp[11]

$sApp[$eTitle]				=	"MANUTENÇÃO DE PACOTES DE DADOS"
$sApp[$eAutomatioName]		=	"ROBO" & " - "& $sApp[$eTitle]
$sApp[$eDirectory]			=	@ScriptDir
$sApp[$eSleepTime]			=	1000
$sApp[$eTmp]				=	""
$sApp[$eGrupo]				=	500


$sApp[$eBanco]				=	$sApp[$eDirectory] & "\" & "base.db"
$sApp[$eTable]				=	"Cliente"

$sApp[$eCNTA]				=	""
$sApp[$eUSER]				=	"80187511"
$sApp[$ePWS]				=	"Val@2015"



#Region ### START Koda GUI section ### Form=C:\Users\a.dasilva\Desktop\@Auto_IT\_install\koda_1.7.3.0\Forms\form5.kxf

$frmRobo = GUICreate($sApp[$eAutomatioName], 893, 642, 314, 123)
GUISetOnEvent($GUI_EVENT_CLOSE, "ConfirmaEncerramento")
$grpBase = GUICtrlCreateGroup("BASE CLIENTE", 8, 8, 873, 113)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

Local $txtArquivo = GUICtrlCreateInput("", 104, 32, 761, 21)
$btnArquivo = GUICtrlCreateButton("CARREGAR PLANILHA", 104, 64, 606, 41)
GUICtrlSetOnEvent($btnArquivo, "carregarPlanilha")

$btnCarregarDados = GUICtrlCreateButton("CARREGAR DADOS", 728, 64, 131, 41)
GUICtrlSetOnEvent($btnCarregarDados, "carregarDados")

$lblArquivo = GUICtrlCreateLabel("ARQUIVO :", 16, 32, 68, 17, $SS_RIGHT)

GUICtrlCreateGroup("", -99, -99, 1, 1)
$grpFiltro = GUICtrlCreateGroup("FILTRO", 8, 128, 873, 505, -1, $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

Local $SVC_NAME, $iSVC_NAME, $cSVC_NAME, $aSVC_NAME
$cboSVC_NAME = GUICtrlCreateCombo("", 192, 152, 521, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
;~ $SVC_NAME = _SQLite_GetTable($db, "SELECT distinct SVC_NAME FROM cliente WHERE SVC_NAME NOT IN ('SVC_NAME') ORDER BY SVC_NAME;", $aSVC_NAME, $iSVC_NAME, $cSVC_NAME)
;~ GUICtrlSetData(-1, _ArrayToString($aSVC_NAME,"|",3))

Local $CHARGE_TIPO, $iCHARGE_TIPO, $cCHARGE_TIPO, $aCHARGE_TIPO
$cboCHARGE_TIPO = GUICtrlCreateCombo("", 192, 184, 521, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
;~ $CHARGE_TIPO = _SQLite_GetTable($db,"SELECT distinct CHARGE_TIPO FROM cliente WHERE CHARGE_TIPO NOT IN ('CHARGE_TIPO') ORDER BY CHARGE_TIPO;", $aCHARGE_TIPO, $iCHARGE_TIPO, $cCHARGE_TIPO)
;~ GUICtrlSetData(-1, _ArrayToString($aCHARGE_TIPO,"|",3))

Local $ACCT_NBR, $iACCT_NBR, $cACCT_NBR, $aACCT_NBR
$cboACCT_NBR = GUICtrlCreateCombo("", 192, 216, 521, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
;~ $ACCT_NBR = _SQLite_GetTable($db,"SELECT distinct ACCT_NBR FROM cliente WHERE ACCT_NBR NOT IN ('ACCT_NBR') ORDER BY ACCT_NBR;", $aACCT_NBR, $iACCT_NBR, $cACCT_NBR)
;~ GUICtrlSetData(-1, _ArrayToString($aACCT_NBR,"|",3))

Local $ACCESS_NBR, $iACCESS_NBR, $cACCESS_NBR, $aACCESS_NBR
$cboACCESS_NBR = GUICtrlCreateCombo("", 192, 248, 521, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
;~ $ACCESS_NBR = _SQLite_GetTable($db, "SELECT distinct ACCESS_NBR FROM cliente WHERE ACCESS_NBR NOT IN ('ACCESS_NBR') ORDER BY ACCESS_NBR;", $aACCESS_NBR, $iACCESS_NBR, $cACCESS_NBR)
;~ GUICtrlSetData(-1, _ArrayToString($aACCESS_NBR,"|",3))

Local $SVC_CHARGE_TYPE_ID, $iSVC_CHARGE_TYPE_ID, $cSVC_CHARGE_TYPE_ID, $aSVC_CHARGE_TYPE_ID
$cboSVC_CHARGE_TYPE_ID = GUICtrlCreateCombo("", 192, 280, 521, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
;~ $SVC_CHARGE_TYPE_ID = _SQLite_GetTable($db,"SELECT distinct SVC_CHARGE_TYPE_ID FROM cliente WHERE SVC_CHARGE_TYPE_ID NOT IN ('SVC_CHARGE_TYPE_ID') ORDER BY SVC_CHARGE_TYPE_ID;", $aSVC_CHARGE_TYPE_ID, $iSVC_CHARGE_TYPE_ID, $cSVC_CHARGE_TYPE_ID)
;~ GUICtrlSetData(-1, _ArrayToString($aSVC_CHARGE_TYPE_ID,"|",3))

Local $CNPJ, $aCNPJ, $iCNPJ, $cCNPJ
$cboCNPJ = GUICtrlCreateCombo("", 192, 312, 521, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
;~ $CNPJ = _SQLite_GetTable($db,"SELECT distinct CNPJ FROM cliente WHERE CNPJ NOT IN ('CNPJ') ORDER BY CNPJ;", $aCNPJ, $iCNPJ, $cCNPJ)
;~ GUICtrlSetData(-1, _ArrayToString($aCNPJ,"|",2))

$lbl_SVC_NAME = GUICtrlCreateLabel("SVC_NAME : ", 24, 152, 82, 17)
$lbl_CHARGE_TIPO = GUICtrlCreateLabel("CHARGE_TIPO :", 24, 184, 99, 17)
$lbl_ACCT_NBR = GUICtrlCreateLabel("ACCT_NBR : ", 24, 216, 81, 17)
$lbl_ACCESS_NBR = GUICtrlCreateLabel("ACCESS_NBR : ", 24, 248, 97, 17)
$lbl_SVC_CHARGE_TYPE_ID = GUICtrlCreateLabel("SVC_CHARGE_TYPE_ID : ", 24, 280, 157, 17)
$lbl_CNPJ = GUICtrlCreateLabel("CNPJ : ", 24, 312, 157, 17)

GUICtrlCreateTabItem("")
$btnFiltra = GUICtrlCreateButton("FILTRAR DADOS", 728, 152, 131, 41)

$tabDados = GUICtrlCreateTab(24, 344, 841, 273)
$TabFiltro= GUICtrlCreateTabItem("DADOS FILTRADOS")
$lstDados = GUICtrlCreateList("", 40, 376, 801, 227)
GUICtrlSetData(-1, "DADO_01|DADO_02|DADO_03")

$TabLotes= GUICtrlCreateTabItem("LOTES")
$Button2 = GUICtrlCreateButton("EXECUTAR ROBO", 708, 569, 139, 41)
$lstLotes = GUICtrlCreateList("", 36, 409, 809, 149)
$Button3 = GUICtrlCreateButton("CARREGAR LOTES", 36, 569, 139, 41)
$txtNomeLote = GUICtrlCreateInput("", 588, 377, 257, 21)
$cboProcesso = GUICtrlCreateCombo("", 116, 377, 145, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "ADICIONAR|NEGOCIAR|EXCLUIR")

$lbl_PROCESSO = GUICtrlCreateLabel("PROCESSO : ", 40, 376, 72, 17)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$lbl_NOME_LOTE = GUICtrlCreateLabel("NOME DO LOTE : ", 488, 376, 95, 17)
GUICtrlSetBkColor(-1, 0xFFFFFF)

GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

_SQLite_Close()
_SQLite_Shutdown()

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $btnArquivo
	EndSwitch
WEnd

Func carregarPlanilha()
	local $tmpArqTexto = _SelecionarArquivo("*.csv")
	if $tmpArqTexto<>"" then GUICtrlSetData(4,$tmpArqTexto)
	EndFunc

Func ConfirmaEncerramento()
	Local $iAnswer = MsgBox(BitOR($MB_YESNO, $MB_SYSTEMMODAL), $sApp[$eTitle], "Deseja interromper a execução da automação?")
	If $iAnswer = 6 Then
		MsgBox(0, $sApp[$eTitle], "Processo abortado pelo usuário")
		_Exit()
	EndIf
	EndFunc

Func _Exit()
	Exit
	EndFunc

Func carregarDados()
	Local $x,$z,$y,$t

;~ 	if FileExists($sApp[$eBanco]) Then
;~ 		Local $iDelete = FileDelete($sApp[$eBanco])

;~ 		If $iDelete Then
;~ 			MsgBox($MB_SYSTEMMODAL, "", "The file was successfuly deleted."  & @CR & $sApp[$eBanco])
;~ 		Else
;~ 			MsgBox($MB_SYSTEMMODAL, "", "Ocorreu um erro ao tentar excluir o arquivo." & @CR & $sApp[$eBanco])
;~ 			Exit
;~ 		EndIf

;~ 	EndIf

	if GUICtrlRead($txtArquivo) <> "" then

		ConsoleWrite("INICIO : " & @HOUR &":"& @MIN &":"& @SEC & @CR)

		_FileReadToArray(GUICtrlRead($txtArquivo), $aRetArray, $FRTA_NOCOUNT)

		_SQLite_Startup()
		If @error Then
			MsgBox($MB_SYSTEMMODAL, "SQLite Error", "SQLite.dll Não pode ser carregado!")
			Exit -1
		EndIf

		local $db = _SQLite_Open($sApp[$eBanco])
		If @error Then
			MsgBox($MB_SYSTEMMODAL, "SQLite Error", "Não é possível carregar banco de dados!")
			Exit -1
		EndIf

		_SQLite_Exec($db, "CREATE TABLE IF NOT EXISTS " & $sApp[$eTable] & " (" & StringReplace($aRetArray[0],";",",") & ");")

;~ 		;ProgressOn("Carregando Registros da Planilha", "Por Favor Aguarde!", "0%")

;~ 		While $x<=ubound($aRetArray,1)

;~ 			if ubound($aRetArray,1) - $x  > 500 Then
;~ 				$sApp[$eGrupo] = 500
;~ 			Else
;~ 				$sApp[$eGrupo] = ubound($aRetArray,1) - $x
;~ 			EndIf

;~ 			for $z=1 to $sApp[$eGrupo]

;~ 				$iStatus = ($x / (Ubound($aRetArray)-1)) * 100
;~ 				if $z = 1 Then
;~ 					_ShowStatus("INSERIR DADOS")
;~ 					$sApp[$eTmp] = "INSERT INTO " & $sApp[$eTable] & " (" & StringReplace($aRetArray[0],";",",")  & ") VALUES "
;~ 				EndIf

;~ 				$sApp[$eTmp] = $sApp[$eTmp] & "('" & StringReplace($aRetArray[$x],";","','") & "'),"
;~ 				$y+=1

;~ 				_ShowStatus("ADD - GRUPO : " & $y)
;~ 				if $z - $sApp[$eGrupo] = 0 Then
;~ 					_SQLite_Exec($db, (StringLeft($sApp[$eTmp],StringLen($sApp[$eTmp])-1)) & ";")
;~ 					$sApp[$eTmp] = ""
;~ 					$y=0
;~ 					$t+=1
;~ 				EndIf
;~ 				;ProgressSet($iStatus, StringLeft($iStatus,4) & "%")

;~ 				_ShowStatus($iStatus)
;~ 				$x+=1
;~ 			Next

;~ 		WEnd

;~ 		;ProgressSet(100, "Carregamento Completo", "Completo")
;~ 		;Sleep(5000)
;~ 		;ProgressOff()

		$SVC_NAME = _SQLite_GetTable($db, "SELECT distinct SVC_NAME FROM " & $sApp[$eTable] & " WHERE SVC_NAME NOT IN ('SVC_NAME') ORDER BY SVC_NAME;", $aSVC_NAME, $iSVC_NAME, $cSVC_NAME)
		GUICtrlSetData(10, _ArrayToString($aSVC_NAME,"|",3))

		$CHARGE_TIPO = _SQLite_GetTable($db,"SELECT distinct CHARGE_TIPO FROM " & $sApp[$eTable] & " WHERE CHARGE_TIPO NOT IN ('CHARGE_TIPO') ORDER BY CHARGE_TIPO;", $aCHARGE_TIPO, $iCHARGE_TIPO, $cCHARGE_TIPO)
		GUICtrlSetData(11, _ArrayToString($aCHARGE_TIPO,"|",3))

		$ACCT_NBR = _SQLite_GetTable($db,"SELECT distinct ACCT_NBR FROM " & $sApp[$eTable] & " WHERE ACCT_NBR NOT IN ('ACCT_NBR') ORDER BY ACCT_NBR;", $aACCT_NBR, $iACCT_NBR, $cACCT_NBR)
		GUICtrlSetData(12, _ArrayToString($aACCT_NBR,"|",3))

		$ACCESS_NBR = _SQLite_GetTable($db, "SELECT distinct ACCESS_NBR FROM " & $sApp[$eTable] & " WHERE ACCESS_NBR NOT IN ('ACCESS_NBR') ORDER BY ACCESS_NBR;", $aACCESS_NBR, $iACCESS_NBR, $cACCESS_NBR)
		GUICtrlSetData(13, _ArrayToString($aACCESS_NBR,"|",3))

		$SVC_CHARGE_TYPE_ID = _SQLite_GetTable($db,"SELECT distinct SVC_CHARGE_TYPE_ID FROM " & $sApp[$eTable] & " WHERE SVC_CHARGE_TYPE_ID NOT IN ('SVC_CHARGE_TYPE_ID') ORDER BY SVC_CHARGE_TYPE_ID;", $aSVC_CHARGE_TYPE_ID, $iSVC_CHARGE_TYPE_ID, $cSVC_CHARGE_TYPE_ID)
		GUICtrlSetData(14, _ArrayToString($aSVC_CHARGE_TYPE_ID,"|",3))

		$CNPJ = _SQLite_GetTable($db,"SELECT distinct CNPJ FROM " & $sApp[$eTable] & " WHERE CNPJ NOT IN ('CNPJ') ORDER BY CNPJ;", $aCNPJ, $iCNPJ, $cCNPJ)
		GUICtrlSetData(15, _ArrayToString($aCNPJ,"|",2))

		_SQLite_Close()
		_SQLite_Shutdown()

		ConsoleWrite("TERMINIO : " & @HOUR &":"& @MIN &":"& @SEC & @CR)

	EndIf

	EndFunc