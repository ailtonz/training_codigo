' WaitMSDN.vbs
'
' MSDN's setup.exe does not stay open while MSDN is installed.  This script waits until MSDN
' is listed as an installed program.

ProductToLookFor = "MSDN Library for Visual Studio .NET 2003"
SearchCondition = false
set installer = createobject("WindowsInstaller.Installer")

'loop until ProductToLookFor is registered as installed
do 
   set products = installer.products
   for each product in products
      if InStr(installer.productinfo(product,"ProductName"),ProductToLookFor) > 0 then
         SearchCondition = true
   end if
   next
wscript.sleep 10000
loop until SearchCondition = true
