cd\
net use i: \\131.107.2.1\d$
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

net use j: \\131.107.2.2\d$
j:
cd\
cd WINNT\Profiles\Administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use l: \\131.107.2.3\d$
l:
cd\
cd WINNT\Profiles\Administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use k: \\131.107.2.4\d$
k:
cd WINNT\Profiles\Administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use m: \\131.107.2.5\d$
m:
cd\
cd WINNT\Profiles\Administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use n: \\131.107.2.6\d$
n:
cd\
cd WINNT\Profiles\Administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use o: \\131.107.2.7\d$
o:
cd\
cd WINNT\Profiles\Administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use p: \\131.107.2.8\d$
p:
cd\
cd WINNT\Profiles\Administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use q: \\131.107.2.9\d$
q:
cd\
cd WINNT\Profiles\Administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use r: \\131.107.2.10\d$
r:
cd\
cd WINNT\Profiles\Administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use s: \\131.107.2.11\d$
s:
cd\
cd WINNT\Profiles\Administrator\desktop
del  /q /f /s  *.*
cd..
cd..
cd all users\desktop
del  /q /f /s  *.*

net use t: \\131.107.2.12\d$
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