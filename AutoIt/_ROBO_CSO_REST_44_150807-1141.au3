; COMO FUNCIONA: PreSets - (eventos de controle) | MAIN - (PRINCIPAL) | INTERFACE - (ADM USUÁRIO X ROBO) | VALIDACAO - (VALIDAR DADOS DA INTERFACE) | PRODUCAO - (FUNCOES DO ROBO)

#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <FileConstants.au3>
#include <Constants.au3>
#include <excel.au3>

#include "funcoes_CSO.au3"
#include "funcoes_UTIL.au3"

#Region PreSets
; Quando pressionar a tecla 'Esc' sai da rotina
HotKeySet("^{end}", "CaptureEsc")

; Liga a opção de eventos de controle
Opt("GUIOnEventMode",1)
#EndRegion

#Region __MAIN

; CSO
Global Enum $eMonitor, $eTransacao, $eIP, $eSrv, $eO_CAD, $eO_BC, $eT, $eLOCAL, $eNAT, $eSP, $eLimiteDeRegistros, $eNUMERO, $eSleepTime,$eAutomatioName,$eDirectory,$eInicioRegistros
Global $sApp[16]

$sApp[$eAutomatioName]		=	"ROBO - RESTRIÇÃO 44"
$sApp[$eDirectory]			=	@ScriptDir
$sApp[$eSleepTime]			=	1000
$sApp[$eMonitor]			=	"RC"
$sApp[$eTransacao]			=	"o010"
$sApp[$eIP]					=	"10.20.5.2" ; "10.20.1.63"
$sApp[$eSrv]				=	"23"
$sApp[$eInicioRegistros]	=	2
$sApp[$eLimiteDeRegistros]	=	94			; LIMITE DE REGISTROS POR OPERAÇÃO

$sApp[$eO_CAD]				=	"1"
$sApp[$eO_BC]				=	"6"
$sApp[$eT]					=	"N"
$sApp[$eLOCAL]				=	"11000"
$sApp[$eNAT]				=	"BC"
$sApp[$eSP]					=	"LP"
$sApp[$eNUMERO]				=	"" 	; NUMERO DE NRC


; ANALISTA
Global Enum $eUsuario, $eSenha, $eSenhaQry, $eNome, $eArea, $eUserIni, $eUserMid, $eUserDig, $eUserPwd
Global $sAnalista[9]

; EMISSÃO DE BC
Global Enum $eCampo_END, $eCampo_DESC_PEDIDO_01, $eCampo_DESC_PEDIDO_02, $eCampo_DESC_PEDIDO_03, $eCampo_URG, $eCampo_REC_SER, $eCampo_SETOR, $eCampo_ASSUNTO, $eCampo_SUB, $eNumBC
Global $sEmissaoBC[10]

$sEmissaoBC[$eCampo_END]				=	"I"
$sEmissaoBC[$eCampo_DESC_PEDIDO_01]		=	"PECO CANCELAR O SERVICO DE BUSCA,"
$sEmissaoBC[$eCampo_DESC_PEDIDO_02]		=	"MESMO ESTANDO O CLIENTE INADIMPLENTE,"
$sEmissaoBC[$eCampo_DESC_PEDIDO_03]		=	"PARA EMISSAO AUTOMATICA DE RET TAR POR INADIMPLENCIA."
$sEmissaoBC[$eCampo_URG]				=	"S"
$sEmissaoBC[$eCampo_REC_SER]			=	"S"
$sEmissaoBC[$eCampo_SETOR]				=	"K"
$sEmissaoBC[$eCampo_ASSUNTO]			=	"1"
$sEmissaoBC[$eCampo_SUB]				=	"A"
$sEmissaoBC[$eNumBC]					=	""

Global $sRetorno =""


;~ ---------------
;~ EXECUÇÃO
;~ ---------------

ExibeInterface()

#EndRegion

#Region __INTERFACE


Func ExibeInterface()

	#Region ### START - Form Aplication ###

		Global $hGUI = GUICreate($sApp[$eAutomatioName], 615, 308, 192, 124)
		GUISetOnEvent($GUI_EVENT_CLOSE, "ConfirmaEncerramento")

		$grpLogin = GUICtrlCreateGroup("LOGIN", 8, 8, 593, 65)
		GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

		Global $txtUsuario = GUICtrlCreateInput("", 104, 32, 153, 21)
		$lblName = GUICtrlCreateLabel("USUÁRIO :", 24, 32, 68, 17, $SS_RIGHT)
		GUICtrlSetTip(-1, "(com letra e dígito")

		Global	$txtSenha = GUICtrlCreateInput("", 424, 32, 161, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))

		$lblSenha = GUICtrlCreateLabel("SENHA :", 352, 32, 54, 17, $SS_RIGHT)
		GUICtrlCreateGroup("", -99, -99, 1, 1)

		$grpAnalista = GUICtrlCreateGroup("ANALISTA", 8, 80, 593, 89)
		GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

		Global	$txtNome = GUICtrlCreateInput("", 104, 104, 153, 21)
		GUICtrlSetTip(-1, "(com letra e dígito")

		Global	$txtSenhaQry = GUICtrlCreateInput("", 424, 104, 161, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))
		$lblNome = GUICtrlCreateLabel("NOME :", 24, 104, 48, 17, $SS_RIGHT)
		$lblSenhaQry = GUICtrlCreateLabel("SENHA :", 352, 104, 54, 17, $SS_RIGHT)

		Global	$txtArea = GUICtrlCreateInput("", 104, 136, 153, 21)
		GUICtrlSetTip(-1, "(com letra e dígito")

		$lblArea = GUICtrlCreateLabel("AREA :", 24, 136, 45, 17, $SS_RIGHT)
		GUICtrlCreateGroup("", -99, -99, 1, 1)

		$grpImpressao = GUICtrlCreateGroup("PROCEDIMENTO", 8, 184, 593, 113)
		GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

		Global	$txtArquivo = GUICtrlCreateInput("", 104, 208, 481, 21)

		$btnArquivo = GUICtrlCreateButton("CARREGAR PLANILHA", 104, 240, 355, 41)
		GUICtrlSetOnEvent($btnArquivo, "carregarPlanilha")

		$btnExecutar = GUICtrlCreateButton("EXECUTAR", 480, 240, 107, 41)
		GUICtrlSetOnEvent($btnExecutar, "ValidaInterface")

		$lblArquivo = GUICtrlCreateLabel("ARQUIVO :", 16, 208, 68, 17, $SS_RIGHT)
		GUICtrlCreateGroup("", -99, -99, 1, 1)

		GUISetState(@SW_SHOW)

	#EndRegion ### END - Form Aplication  ###

	;-- Aguarda ação do usuário
	While 1
		Sleep(10); comando para nao usar muito a CPU
	WEnd

EndFunc

Func carregarPlanilha()
   local $tmpArqTexto = _SelecionarArquivo("*.xls*")
   GUICtrlSetData(18,$tmpArqTexto)
EndFunc

Func ValidaInterface()
	Local $strAux = ""

	if (GUICtrlRead($txtUsuario) = "") or (GUICtrlRead($txtSenha) = "") Then
		$strAux = $strAux & "  - Preencha todos os dados para execucao do robô" & @CRLF
	Else
		$sAnalista[$eUsuario]			=	GUICtrlRead($txtUsuario)
		$sAnalista[$eSenha]				=	GUICtrlRead($txtSenha)
		$sAnalista[$eNome]				=	GUICtrlRead($txtNome)
		$sAnalista[$eSenhaQry]			=	GUICtrlRead($txtSenhaQry)
		$sAnalista[$eArea]				=	GUICtrlRead($txtArea)

		$sAnalista[$eUserIni] 			= 	StringLeft(($sAnalista[$eUsuario]),1)
		$sAnalista[$eUserMid] 			= 	StringMid(($sAnalista[$eUsuario]),2,StringLen(($sAnalista[$eUsuario]))-2)
		$sAnalista[$eUserDig] 			= 	StringRight(($sAnalista[$eUsuario]),1)
		$sAnalista[$eUserPwd] 			= 	($sAnalista[$eSenha])
	EndIf

	if $strAux = "" Then
		if SheetExists(GUICtrlRead($txtArquivo),"Dados") Then
			MsgBox($MB_ICONERROR, $sApp[$eAutomatioName],"A guia 'Dados' não existe nesta planilha!")
			Exit
		Else
			mainEXCEL(GUICtrlRead($txtArquivo),"Dados")
			_Exit()
		EndIf
	Else
		MsgBox($MB_ICONERROR, $sApp[$eAutomatioName],"Ocorreram inconsistências no preenchimento. Veja abaixo:" & @CRLF & @CRLF & $strAux)
	EndIf

EndFunc

Func ConfirmaEncerramento()
   Local $iAnswer = MsgBox(BitOR($MB_YESNO, $MB_SYSTEMMODAL), $sApp[$eAutomatioName], "Deseja interromper a execução da automação?")
	If $iAnswer = 6 Then 	; Verifica se o usuário abortou a operação
		MsgBox(0, $sApp[$eAutomatioName], "Processo abortado pelo usuário")
		_Exit()
	EndIf
EndFunc

Func _Exit()
   _PLANILHA_FECHAR()
   Exit
EndFunc

#EndRegion __INTERFACE

#Region __VALIDACAO

Func mainEXCEL($sFilename,$sSheetName)

	local $iFileExists = FileExists($sFilename)

	If Not $iFileExists Then
		MsgBox($MB_ICONERROR, $sApp[$eAutomatioName], "Arquivo " & $sFilename & " não encontrado.")
	Else

		; INSTANCIAR OBJETO
		Global $iExcelObj = ObjCreate("Excel.Application")
		$iExcelObj.application = true

		; ABRIR WORKBOOK
		Global $oDocument =  $iExcelObj.WorkBooks.Open($sFilename)

	;~ 	; CARREGAR WORKSHEET
		Global $iSheetName =  $oDocument.Worksheets($sSheetName)
	;~
	;~ 	; QUANTIDADE DE LINHAS
		Global $iRowCount = $iSheetName.UsedRange.Rows.Count
	;~ 	MsgBox(0,"$iRowCount",$iRowCount)

	;~ 	; QUANTIDADE COLUNAS
		Global $iColumnCount = $iSheetName.UsedRange.Columns.Count
	;~ 	MsgBox(0,"$iColumnCount",$iColumnCount)

	;~ 	; POSICIONAR APOS A ULTIMA COLUNA PARA STATUS
		Global $iLastColumn = _Excel_ColumnToLetter($iColumnCount+1)
	;~ 	MsgBox(0,"$iLastColumn",$iLastColumn)

	;~ 	; RANGE
		Local $iRange = "A1" & ":" & $iLastColumn  & $iRowCount
	;~ 	MsgBox(0,"$iRowCount",$iRowCount)


	;~ 	; ARRAY DO RANGE
		Global $iArrayValues = $iSheetName.range($iRange).value

		If IsArray($iArrayValues) and Ubound($iArrayValues,0)>0 then

			;~ ; ORDERNAR RANGE
	;~ 		_Excel_RangeSort($oDocument,$iSheetName, $iRange, "F:F", Default, Default, $xlYes)

			;~ ; IDENTIFICA O ULTIMO REGISTRO - STATUS
			Local $UltStatus = $iExcelObj.WorksheetFunction.CountA($iSheetName.Range("F:F"))+1

			;~ ; INICIO DOS REGISTROS DEPOIS DO STATUS
		   if $UltStatus > $sApp[$eInicioRegistros] Then
			   $sApp[$eInicioRegistros] = $UltStatus
		   EndIf

			#Region PREPARACAO

				_showstatus("CONEXAO PW3270")
				ConexaoPW3270($sApp[$eIP], $sApp[$eSrv])

				_showstatus("LOGIN TELEFONICA")
				_LOGIN_TELEFONICA($sAnalista[$eUserIni], $sAnalista[$eUserMid],	$sAnalista[$eSenha])

				_ShowStatus("CONTROLE DE TRANSAÇÃO")
				_LOGIN_TELEFONICA_INICIO($sApp[$eMonitor],$sApp[$eTransacao])

			#EndRegion PREPARACAO


			#Region PRODUÇÃO
			   Local $y = 1

			   for $x = $sApp[$eInicioRegistros] to $iRowCount
				 if $y <= $sApp[$eLimiteDeRegistros] Then
					$sApp[$eNUMERO]		=	$iSheetName.range("A" &($x)).value

					_ShowStatus("CADASTRO DE CLIENTE")
					_CADASTRO_CLIENTE($sApp[$eO_CAD],$sApp[$eT],$sApp[$eNUMERO],"",$sAnalista[$eUserMid] & $sAnalista[$eUserDig],"",$sApp[$eSP],$sAnalista[$eSenhaQry])

					_ShowStatus("VOLTAR")
					sendWait("{pause}",$sApp[$eSleepTime])

					_ShowStatus("CARREGA BC")
					_CADASTRO_BC($sApp[$eO_BC],$sApp[$eNAT])

					 $sRetorno = _ALLTRIM(StringMid(RetornaLinhaDaTela(4),36,30))
					 if $sRetorno <> "******************************"  OR $sRetorno <> "" Then
						_ShowStatus("EMISSAO DO BC")
						$sEmissaoBC[$eNumBC] = _EMISSAO_BC($sEmissaoBC[$eCampo_END],$sEmissaoBC[$eCampo_DESC_PEDIDO_01],$sEmissaoBC[$eCampo_DESC_PEDIDO_02],$sEmissaoBC[$eCampo_DESC_PEDIDO_03],$sAnalista[$eNome],$sAnalista[$eArea],$sEmissaoBC[$eCampo_URG],$sEmissaoBC[$eCampo_REC_SER],$sEmissaoBC[$eCampo_SETOR],$sEmissaoBC[$eCampo_ASSUNTO],$sEmissaoBC[$eCampo_SUB])

						$iSheetName.range("B" &($x)).Value	= _ALLTRIM(StringMid(RetornaLinhaDaTela(22),13,15))
						$iSheetName.range("C" &($x)).Value	= $sEmissaoBC[$eNumBC]

						$iSheetName.range("F" &($x)).Value	= "OK"
						$oDocument.Save

					 Else

						$iSheetName.range("B" &($x)).Value	= _ALLTRIM(StringMid(RetornaLinhaDaTela(22),13,15))
						$iSheetName.range("C" &($x)).Value	= "--ERROR--"

						$iSheetName.range("F" &($x)).Value	= "--ERROR--"
						$oDocument.Save

						_ShowStatus("VOLTAR")
						sendWait("{pause}",$sApp[$eSleepTime])

					 EndIf

					_ShowStatus("LIMPAR TELA")
					sendWait("{ESC}",$sApp[$eSleepTime])
					$y+=1
				 EndIf

			   Next

			#EndRegion PRODUÇÃO

			MsgBox(0,"FIM","FIM DA EXECUÇÃO")

		EndIf

	EndIf

EndFunc

Func _PLANILHA_FECHAR()
	$oDocument.close
	$iExcelObj.quit
	$iExcelObj = Null
EndFunc

#EndRegion __VALIDACAO