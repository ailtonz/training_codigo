#include-Once
#include <IE.au3>


Func ConexaoATIS($sUsuario,$sSenha)

   ;Chama instância do objeto internet explorer
   Global $oIE = _IECreate()
   If IsObj($oIE) = 0 Then
	  MsgBox($MB_ICONERROR,"","Erro na abertura do Internet Explorer.")
	  Exit
   EndIf

   ;Acessa o sistema Atis
   _IENavigate($oIE, "http://atiscrm.telefonica.br:10000/")
   _IELoadWait($oIE)

   $o_frmLogin = _IEFormGetObjByName($oIE, "formLogin")
   $o_txt_user = _IEFormElementGetObjByName($o_frmLogin, "user")
   $o_txt_pwd =  _IEFormElementGetObjByName($o_frmLogin, "password")

   _IEFormElementSetValue($o_txt_user, $sUsuario)
   _IEFormElementSetValue($o_txt_pwd, $sSenha)
   _IEImgClick($oIE, "imgAceptar", "id")
   _IELoadWait($oIE)

   Sleep(15000)

   If WinExists("Informações de Segurança") Then
	  WinActivate("Informações de Segurança")
	  Send("{Enter}")
	  Sleep(2000)
   EndIf

   Send("{Enter}")
   Sleep(5000)

   Send("{Enter}")
   Sleep(7000)

   Send("{Enter}")
   Sleep(5000)

   If WinExists("Sistema ATIS para o perfil T") Then
	  Local $hwnd = WinActivate("Sistema ATIS para o perfil T")
	  WinSetState($hwnd,"",@SW_MAXIMIZE)
	  Local $aClientSize = WinGetClientSize($hWnd)
	  Sleep(5000)
	  Send("{Enter}")
   Else
	  exit
   EndIf

EndFunc


Func ConexaoStaffware($strUser, $strPassword)

   $oIE = _IECreate()
   _IENavigate($oIE, "http://10.20.142.117:8081/caixaEntrada/index.jsp?close=1")
   _IELoadWait($oIE)

   ; Ativa a janela do Staffware e Aguarda ativação da janela por 30 segundos
   WinActivate("<- Caixa Entrada Staffware -> - Windows Internet Explorer")
   $nStfw = WinWaitActive("<- Caixa Entrada Staffware -> - Windows Internet Explorer", "",30)
   if $nStfw = 0 Then
	  ;Timeout
	  MsgBox($MB_ICONERROR, "", "Erro na abertura do Staffware")
	  Exit
   EndIf

   ; Maximiza a janela do Staffware
   WinSetState($nStfw,"",@SW_MAXIMIZE)

   $o_frmLogin = _IEFormGetObjByName($oIE, "userForm")
   $o_txt_RE = _IEFormElementGetObjByName($o_frmLogin, "user")
   $o_txt_Senha = _IEFormElementGetObjByName($o_frmLogin, "password")

   ; Preenche usuário e senha
   _IEFormElementSetValue($o_txt_RE, $strUser)
   _IEFormElementSetValue($o_txt_Senha, $strPassword)
   Sleep(2000)

   ;Clica no botão LOGIN
   _IEFormSubmit($o_frmLogin)
   _IELoadWait($oIE)

   Sleep(3000)

EndFunc


Func ConexaoSADDR($strUser,$strPassword)

   $oIE = _IECreate()
   _IENavigate($oIE, "http://10.128.222.48/saddr_rd/")
   _IELoadWait($oIE)

   ; Ativa a janela e aguarda sua ativação por 30 segundos
   WinActivate("SADDR-RD Religue/ Desligue de DDR - Windows Internet Explorer")
   $nSADDR = WinWaitActive("SADDR-RD Religue/ Desligue de DDR - Windows Internet Explorer", "",30)
   if $nSADDR = 0 Then
	  MsgBox($MB_ICONERROR, "", "Erro na abertura do SADDR")
	  Exit
   EndIf

   ;Maximiza a janela do SADDR
   WinSetState($nSADDR,"",@SW_MAXIMIZE)

   $oFrame = _IEFrameGetObjByName($oIE, "principal")
   $o_txt_RE = _IEGetObjByName($oFrame, "TUsuario")
   $o_txt_Senha = _IEGetObjByName($oFrame, "TSenha")

   ; Preenche usuario e senha
   _IEFormElementSetValue($o_txt_RE, $strUser)
   _IEFormElementSetValue($o_txt_Senha, $strPassword)
   Sleep(2000)

   $o_btnEntrar = _IEGetObjByName($oFrame, "BEntrar")
   If IsObj($o_btnEntrar) Then
	  $o_btnEntrar.click
	  _IELoadWait($oIE)
   Else
	  MsgBox($MB_ICONERROR, "", "Botão Entrar não encontrado!")
	  Exit
   EndIf

EndFunc


Func ConexaoEnova($strUser,$strPassword)

   $oIE = _IECreate()
   _IENavigate($oIE, "http://10.31.40.37/blecfull/modulos/admin/login/interfaces/frmLogin.asp")
   _IELoadWait($oIE)

   $o_frmLogin = _IEFormGetObjByName($oIE, "frmLogin")
   $o_txt_RE = _IEFormElementGetObjByName($o_frmLogin, "txt_RE")
   $o_txt_Senha = _IEFormElementGetObjByName($o_frmLogin, "txt_Senha")

   ; Preenche usuario e senha
   _IEFormElementSetValue($o_txt_RE, $strUser)
   _IEFormElementSetValue($o_txt_Senha, $strPassword)
   Sleep(2000)

   $o_btnLogin = _IEFormElementGetObjByName($o_frmLogin, "btnLogin")

   If IsObj($o_btnLogin) Then
	  $o_btnLogin.click
	  _IELoadWait($oIE)
   Else
	  MsgBox($MB_ICONERROR, "", "Botão de Login não encontrado!")
	  Exit
   EndIf

EndFunc


Func ConexaoPortalEmpresas($strUser,$strPassword)

   $oIE = _IECreate()
   _IENavigate($oIE, "http://10.128.222.26/PortalEmpresas/",1)
   _IELoadWait($oIE

   ; Ativa a janela e aguarda sua ativação por 30 segundos
   WinActivate("...::::: Portal Empresas :::::... - Windows Internet Explorer")
   $nPagPrinc = WinWaitActive("...::::: Portal Empresas :::::... - Windows Internet Explorer","",30)
   if $nPagPrinc = 0 Then
	  MsgBox($MB_ICONERROR, "", "Erro na abertura do Portal Empresas")
	  Exit
   EndIf

   ;Maximiza Janela
   WinSetState($nPagPrinc,"",@SW_MAXIMIZE)

   $oFrame = _IEFrameGetObjByName($oIE, "principal")
   $o_txt_RE = _IEGetObjByName($oFrame, "ctl00$Main$txtLogin")
   $o_txt_Senha = _IEGetObjByName($oFrame, "ctl00$Main$txtSenha")

   ; Preenche usuário e senha
   _IEFormElementSetValue($o_txt_RE, $strUser)
   _IEFormElementSetValue($o_txt_Senha, $strPassword)

   $o_btnEntrar = _IEGetObjByName($oFrame, "ctl00$Main$btnEntrar")
   If IsObj($o_btnEntrar) Then
	  $o_btnEntrar.click
	  _IELoadWait($oIE)
   Else
	  MsgBox($MB_ICONERROR, "", "Botão Entrar não encontrado!")
	  Exit
   EndIf

   Sleep(7000)

EndFunc


Func ConexaoBenner($strUser,$strPassword)

   ;CONEXÃO COM BENNER
   Global $oIEBenner = _IECreate()
   If IsObj($oIEBenner) = 0 Then
	  MsgBox($MB_ICONERROR,"","Erro na abertura do Internet Explorer.")
	  Exit
   EndIf
   _IENavigate($oIEBenner, "http://10.20.179.79/juridico/login.aspx")
   _IELoadWait($oIEBenner)

   ;Ativar os controles da tela para preenchimento de usuário e senha
   $o_FormLogin = _IEFormGetObjByName($oIEBenner, "FormLogin")
   $o_txt_user = _IEFormElementGetObjByName($o_FormLogin, "pu")
   $o_txt_pwd = _IEFormElementGetObjByName($o_FormLogin, "pp")

   ;Atribuir usuário e senha nos controles da tela
   _IEFormElementSetValue($o_txt_user, $strUser)
   _IEFormElementSetValue($o_txt_pwd, $strPassword)
   _IEFormSubmit($o_FormLogin, "Entrar")

   ;Ativa a janela do Benner
   WinActivate("WEB Juridico Telefonica")
   Local $hWnd = WinWait("WEB Juridico Telefonica", "", 10)

   ; Maximiza Janela do WCD
   WinSetState($hWnd, "", @SW_MAXIMIZE)

EndFunc


Func ConexaoWCD($strUser,$strPassword)

   ; CONEXÃO COM WCD
   Global $oIE = _IECreate()
   If IsObj($oIE) = 0 Then
	  MsgBox($MB_ICONERROR,"","Erro na abertura do Internet Explorer.")
	  Exit
   EndIf

   _IENavigate($oIE, "http://10.31.1.10/jsp/main/login.jsp")
   _IELoadWait($oIE)

   Global $o_FormLogin

   ; Aguarda o carregamento da pagina
   While IsObj($o_FormLogin) = 0
	  Sleep(300)
	  $o_FormLogin = _IEFormGetObjByName($oIE, "login")
   WEnd

   $o_txt_user = _IEFormElementGetObjByName($o_FormLogin, "log1")
   $o_txt_pwd = _IEFormElementGetObjByName($o_FormLogin, "pass1")

   ; Preenche usuario e senha
   _IEFormElementSetValue($o_txt_user, $sUsuario)
   _IEFormElementSetValue($o_txt_pwd, $sSenha)
   _IEImgClick($o_FormLogin,"/images/imgslogin/login_btn.jpg","src")

   Sleep(2000)

   ; Aguarda o login no WCD
   Local $hWnd = WinWait("iColabora", "", 60)
   If $hWnd = 0 Then
	  MsgBox($MB_ICONERROR,"","Erro na abertura do WCD")
	  Exit
   EndIf

   ; Maximiza Janela do WCD
   WinSetState($hWnd, "", @SW_MAXIMIZE)

EndFunc