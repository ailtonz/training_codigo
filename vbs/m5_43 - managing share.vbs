'criando uma OU
on error resume next
set oroot = getobject("LDAP://rootDSE")
set odom = getobject("LDAP://" & oroot.get("defaultnamingcontext"))

set oou = odom.create("OrganizationalUnit", "ou=teste")
oou.description = "Ou de teste criada por script"
oou.setinfo


'-----------------------------------------------------------------------
	'criando um usu�rio
	'estas 2 propriedades s�o obrigat�rias (cn e samaccountname)
set objuser = oou.create("user","cn=Sandro Lopes")  'canonical name para consulta por LDAP
with objuser
	.put "samaccountname", "slopes"					  'nome netbios do usu�rio
	.setinfo

	'estas propriedades j� s�o opcionais
	.put "displayname", "Sandro Lopes"
	.put "userprincipalname", "slopes@nwtraders.msft" 'nome UPN para logon no windows2k
	.put "userWorkstations", "London"
	.put "profilePath", "\\london\Profiles\slopes"
	.put "homeDirectory", "\\london\home\slopes"
	.put "homeDrive", "U:"
	.AccountExpirationDate = "25/09/2003"
	
	'--------------------------------------------------------------------------------
	'as propriedades abaixo s� podem ser definidas se o objeto user j� existir no AD
	'por isso o setinfo na linha 20, caso contr�rio o comando n�o funcionaria
	'
	'
	' 		!!!!Toda conta criada por script fica DESABILITADA POR PADR�O!!!!
	'
	'--------------------------------------------------------------------------------
	.SetPassword "password"
	.AccountDisabled = False
	.setinfo
end with

'-----------------------------------------------------------------------
	'criando um GRUPO GLOBAL
	'definir os valores para as constantes de ADSI
	
	ADS_GROUP_TYPE_DOMAIN_LOCAL_GROUP = &H4
	ADS_GROUP_TYPE_GLOBAL_GROUP = &H2
	ADS_GROUP_TYPE_SECURITY_ENABLED = &H80000000
	Set objOU = GetObject("LDAP://OU=teste,dc=nwtraders,dc=msft")
	Set objGroup = objOU.Create("Group", "cn=curso2433a")
	with objGroup
		' se for omitodo a propriedade grouptype ser� usado o default (Grupo Global / Security)
		.put "grouptype", ADS_GROUP_TYPE_GLOBAL_GROUP OR ADS_GROUP_TYPE_SECURITY_ENABLED
		.Put "sAMAccountName", "curso2433a"
		.put "description", "Grupo Global serve para agrupar usu�rios."
		.setInfo
		
	'--------------------------------------------------------------------------------
	'a propriedade abaixo s� pode ser definida se o objeto grupo j� existir no AD
	'por isso o setinfo na linha 48, caso contr�rio n�o funcionar�
	'
	'   !!!!! deve-se usar no cn do usu�rio o nome de exibi��o (displayname) !!!!!
	'--------------------------------------------------------------------------------

		.add ("LDAP://CN=sandro lopes,ou=teste,dc=nwtraders,dc=msft")
		.SetInfo
	end with
	
	'criando um GRUPO Local
	Set objOU = GetObject("LDAP://OU=teste,dc=nwtraders,dc=msft")
	Set objGroup = objOU.Create("Group", "cn=HP-550c")
	with objGroup
		' se for omitodo a propriedade grouptype ser� usado o default (Grupo Global / Security)
		.put "grouptype", ADS_GROUP_TYPE_DOMAIN_LOCAL_GROUP OR ADS_GROUP_TYPE_SECURITY_ENABLED
		.Put "sAMAccountName", "HP-550c"
		.put "description", "Grupo Domain Local serve para atribuir permiss�es."
		.setInfo
		.add ("LDAP://CN=curso2433a,ou=teste,dc=nwtraders,dc=msft")
		'------------------------------------------------------------------
		'para remover usu�rio do grupo � s� trocar o m�todo add por remove
		'------------------------------------------------------------------
		.SetInfo
	end with

if err.Number = 0 then
wscript.Echo "OU teste" & vbnewline _
		& "Usu�rio Sandro" & vbnewline _
		& "Grupo Global curso2433a" & vbnewline _
		& "Grupo Domain Local HP-550c" & vbnewline  & vbnewline _
		& "Foram criados com sucesso!"
else
wscript.Echo "Um dos items j� estava criado."
end if

set oshell = createobject("wscript.shell")
oshell.Run "dsa.msc"
