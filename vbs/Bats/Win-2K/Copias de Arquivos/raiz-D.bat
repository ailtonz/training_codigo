cd\

net use h: \\192.168.1.1\c$
h:
xcopy \\192.168.1.200\c$\aluno *.* /e /s /h /y

pause

net use i: \\192.168.1.2\c$
i:
xcopy \\192.168.1.200\c$\aluno *.* /e /s /h /y

net use j: \\192.168.1.3\c$
j:
xcopy \\192.168.1.200\c$\aluno *.* /e /s /h /y

net use l: \\192.168.1.4\c$
l:
xcopy \\192.168.1.200\c$\aluno *.* /e /s /h /y

net use k: \\192.168.1.5\c$
k:
xcopy \\192.168.1.200\c$\aluno *.* /e /s /h /y

net use m: \\192.168.1.6\c$
m:
xcopy \\192.168.1.200\c$\aluno *.* /e /s /h /y

net use n: \\192.168.1.7\c$
n:
xcopy \\192.168.1.200\c$\aluno *.* /e /s /h /y

net use o: \\192.168.1.8\c$
o:
xcopy \\192.168.1.200\c$\aluno *.* /e /s /h /y

net use p: \\192.168.1.9\c$
p:
xcopy \\192.168.1.200\c$\aluno *.* /e /s /h /y

net use q: \\192.168.1.10\c$
q:
xcopy \\192.168.1.200\c$\aluno *.* /e /s /h /y

net use r: \\192.168.1.11\c$
r:
xcopy \\192.168.1.200\c$\aluno *.* /e /s /h /y

net use s: \\192.168.1.12\c$
s:
xcopy \\192.168.1.200\c$\aluno *.* /e /s /h /y

pause

net use * /delete /y