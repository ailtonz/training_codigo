#include "funcoes_CSO.au3"
#include "funcoes_UTIL.au3"


#Region PreSets
; Quando pressionar a tecla 'Esc' sai da rotina
HotKeySet("{Esc}", "CaptureEsc")

; Liga a opção de eventos de controle
Opt("GUIOnEventMode",1)
#EndRegion


; APLICAÇÕES GERAIS
Global $iAutomatioName = "ROBO CONSULTA DE OS RETTAR"
Global $iMsgTitle = "Automação - " & $iAutomatioName
Global $s_Directory = @ScriptDir
Global $SleepTime = 1500

; APENAS PW
Global $WindowTitle = "pw3270"
Global $UserIni = "e"
Global $UserMid = "623331"
Global $UserDig = "7"
Global $UserPwd = "gvmeaj04"
Global $UserQry = ""
Global $csoTransacao = "o010"
Global $csoMonitor = "RC"


Global $REF_O = "4"
Global $REF_T = "N"
Global $REF_NUMERO = StringFormat("%010s", "111708591")
Global $REF_LOCAL = "11000"
Global $REF_AT = $UserMid & $UserDig
Global $NAT = ""
Global $ES = "SP"


IF @DesktopWidth <> "1600" Then
	MsgBox(0,$iMsgTitle,"ATENÇÃO: O ROBO FOI DESENVOLVIDO PARA USO EM RESOLUÇÃO: 1600 x 900. FAVOR CHAMAR RESPONSAVEL PELO ROBO")
Else
	main()
EndIf


Func main()

#Region PREPARACAO

	_ATIVAR_JANELA($WindowTitle)

	_LOGIN_TELEFONICA($UserIni,$UserMid,$UserPwd,$SleepTime)

	_USUARIO_CONTROLE(RetornaLinhaDaTela(22,$WindowTitle,1249, 731),$iMsgTitle,$SleepTime)

	_LOGIN_TELEFONICA_INICIO($csoMonitor,$csoTransacao,$SleepTime)

	_LOGIN_TELEFONICA_CONSULTA($REF_O,$REF_T,$REF_NUMERO,$REF_LOCAL,$REF_AT,$SleepTime,$NAT,$ES)

	; COPIAR A TELA
	Local $arrayTela = ""
	$arrayTela = RetornaLinhaDaTela(0,$WindowTitle,1249, 731)

	If StringInStr($arrayTela[1],"Resumo") > 0 Then
		marcarRegistro($SleepTime,$WindowTitle,1249, 731,"RETTAR")
	EndIf


	; CARREGAR REGISTRO
	Local $sREGISTRO[23]

	; COPIAR A TELA
	$arrayTela = RetornaLinhaDaTela(0,$WindowTitle,1249, 731)

	$sREGISTRO[0] 	= _ALLTRIM(StringMid($arrayTela[3],11,65))	; ASS

	$sREGISTRO[1] 	= _ALLTRIM(StringMid($arrayTela[4],11,7)) 	; NATU
	$sREGISTRO[2] 	= _ALLTRIM(StringMid($arrayTela[4],24,8)) 	; SIT
	$sREGISTRO[3] 	= _ALLTRIM(StringMid($arrayTela[4],39,25))	; DATA
	$sREGISTRO[4] 	= _ALLTRIM(StringMid($arrayTela[4],11,4))	; PERIODO

	$sREGISTRO[5]	= _ALLTRIM(StringMid($arrayTela[5],11,7))	; TAR
	$sREGISTRO[6] 	= _ALLTRIM(StringMid($arrayTela[5],30,33))	; MOT/PROV

	$sREGISTRO[7] 	= _ALLTRIM(StringMid($arrayTela[6],11,7))	; DATAVIG
	$sREGISTRO[8] 	= _ALLTRIM(StringMid($arrayTela[6],30,4))	; MOT/ANT
	$sREGISTRO[9]	= _ALLTRIM(StringMid($arrayTela[6],72,4))	; DATA FAT

	$sREGISTRO[10] 	= _ALLTRIM(StringMid($arrayTela[7],11,13))	; NROCS
	$sREGISTRO[11] 	= _ALLTRIM(StringMid($arrayTela[7],36,5))	; CLA ASS
	$sREGISTRO[12] 	= _ALLTRIM(StringMid($arrayTela[7],51,9))	; DATEMIS
	$sREGISTRO[13] 	= _ALLTRIM(StringMid($arrayTela[7],72,5))	; CS

	$sREGISTRO[14]	= _ALLTRIM(StringMid($arrayTela[8],11,13))	; TEL
	$sREGISTRO[15] 	= _ALLTRIM(StringMid($arrayTela[8],36,5))	; CLA SERV
	$sREGISTRO[16]	= _ALLTRIM(StringMid($arrayTela[8],51,9))	; ES
	$sREGISTRO[17] 	= _ALLTRIM(StringMid($arrayTela[8],72,5))	; CPCC

	$sREGISTRO[18] 	= _ALLTRIM(StringMid($arrayTela[9],11,13))	; TEL D/P
	$sREGISTRO[19]	= _ALLTRIM(StringMid($arrayTela[9],36,5))	; CLA ANT
	$sREGISTRO[20] 	= _ALLTRIM(StringMid($arrayTela[9],51,9))	; LOC/AT
	$sREGISTRO[21]	= _ALLTRIM(StringMid($arrayTela[9],72,5))	; CC

	$sREGISTRO[22] 	= _ALLTRIM(StringMid($arrayTela[17],1,80)) & @CR & _ALLTRIM(StringMid($arrayTela[18],1,80)) & @CR & _ALLTRIM(StringMid($arrayTela[19],1,80)) & @CR & _ALLTRIM(StringMid($arrayTela[20],1,38))

	_ArrayDisplay($sREGISTRO)

	MsgBox(0,"AMBIENTE DE TESTES","FIM DOS TESTES")

#EndRegion PREPARACAO

EndFunc

;~ Func marcarRegistro($SleepTime,$sNAT="RETTAR")
;~ 	Local $AuxTela = RetornaLinhaDaTela(0,$WindowTitle,1249, 731) ; RetornaLinhaDaTela(0)
;~ 	SendWait("{ENTER}", $SleepTime)
;~ 	SendWait("{TAB}", $SleepTime)
;~ 	SendWait("{DOWN}", 50, 17)

;~ 	Local $FlagEncontrou = 0

;~ 	For $a = UBound($AuxTela) - 5 To 3 Step -1
;~ 		If ($FlagEncontrou = 0) And (StringInStr($AuxTela[$a+1], $sNAT) > 0) Then
;~ 			SendWait("x", 50)
;~ 			SendWait("{UP}", 50, 2)
;~ 			$FlagEncontrou = 1
;~ 		Else
;~ 			SendWait("{UP}", 50)
;~ 		EndIf

;~ 	Next

;~ 	SendWait("{F1}", 1000)

;~ EndFunc