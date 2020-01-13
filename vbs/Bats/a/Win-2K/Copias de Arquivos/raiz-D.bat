cd\
net use u: \\192.168.1.13\c$
u:
xcopy \\192.168.1.200\c$\aluno *.* /e /s /h /y 

pause

net use v: \\192.168.1.14\c$
v:
xcopy \\192.168.1.200\c$\aluno *.* /e /s /h /y


net use z: \\192.168.1.15\c$
z:
xcopy \\192.168.1.200\c$\aluno *.* /e /s /h /y


net use x: \\192.168.1.16\c$
x:
xcopy \\192.168.1.200\c$\aluno *.* /e /s /h /y


net use y: \\192.168.1.17\c$
y:
xcopy \\192.168.1.200\c$\aluno *.* /e /s /h /y


net use w: \\192.168.1.18\c$
w:
xcopy \\192.168.1.200\c$\aluno *.* /e /s /h /y


pause

net use * /delete /y