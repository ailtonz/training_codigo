@echo off

net stop mssqlserver

net start mssqlserver

isql -Usa -P -Q"exec sp_dropserver caracas"
isql -Usa -P -Q"exec sp_addserver %computername%, 'local'"
echo Trocou nome!

net stop mssqlserver

net start mssqlserver



net stop mssql$MOC

echo Stop Service
net start mssql$MOC

net stop msmq /y

rem @echo off

 
osql -Usa -S"(local)\MOC" -P -t15000 -Q"exec sp_dropserver 'caracas\moc'"
osql -Usa -S(local)\MOC -P -t15000 -Q"exec sp_addserver '%computername%\moc', 'local'"
 
echo trocou nome

net stop mssql$MOC
echo Stop Service
net start mssql$MOC
net start

exit