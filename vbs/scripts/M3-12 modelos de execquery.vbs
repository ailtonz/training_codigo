'==========================================================================
'carregar todas as propriedades da classe logicaldisk, mas exibe somente 
'uma propriedade

set objsvc = getobject("Winmgmts:")
set objdisk = objsvc.execquery("select * from win32_logicaldisk")
for each disco in objdisk
	wscript.Echo disco.name
next


'==========================================================================
'carregar propriedades espec�ficas da classe logicaldisk
set objsvc = getobject("Winmgmts:")
set objdisk = objsvc.execquery("select name, filesystem, freespace from win32_logicaldisk")
for each disco in objdisk
	wscript.Echo disco.name, "-" , disco.filesystem , "-" , disco.freespace
next



'==========================================================================
'A classe CIM_MediaAccessDevice possui v�rias subclasses, mas a consulta
'pode ser filtrada para retornar dados de uma classe espec�fica

set objsvc = getobject("Winmgmts:")
set objdisk = objsvc.execquery("select * from cim_mediaaccessdevice where __class = 'win32_cdromdrive'")
for each disco in objdisk
	wscript.Echo disco.name, "-" , disco.mediatype , "-" , disco.Manufacturer
next
