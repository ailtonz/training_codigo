'conectar com objeto
set oOU = getobject("LDAP://cn=admin25,ou=wst,dc=nwtraders,dc=msft")
'exibir propriedades em cache
wscript.Echo "propriedades em cache: " & oOU.propertycount
'carregar uma propriedade em especial
oOU.getinfoex array("memberof"),0
'exibir propriedades em cache
wscript.Echo "propriedades em cache: " & oOU.propertycount
'carregar e exibir todas as  propriedades em cache
oOU.getinfo
wscript.Echo "propriedades em cache: " & oOU.propertycount
'carregar uma propriedade em especial (das 33 que já estão em cache)
wscript.Echo oOU.get("cn")
'o mesmo que o comando acima......
wscript.Echo oOU.cn
'carregar e exibir valores de uma propriedade que possui vários valores (matriz)
grupos = oOU.getEx("memberof")
for each g in grupos
wscript.Echo g
next
