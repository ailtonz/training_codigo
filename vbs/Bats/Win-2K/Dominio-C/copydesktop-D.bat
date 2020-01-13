cd\

net use h: \\192.168.1.1\d$
h:
xcopy \\192.168.1.200\d$\aluno *.* /e /s /h /y

pause

net use i: \\192.168.1.2\d$
i:
xcopy \\192.168.1.200\d$\aluno *.* /e /s /h /y

net use j: \\192.168.1.3\d$
j:
xcopy \\192.168.1.200\d$\aluno *.* /e /s /h /y

net use l: \\192.168.1.4\d$
l:
xcopy \\192.168.1.200\d$\aluno *.* /e /s /h /y

net use k: \\192.168.1.5\d$
k:
xcopy \\192.168.1.200\d$\aluno *.* /e /s /h /y

net use m: \\192.168.1.6\d$
m:
xcopy \\192.168.1.200\d$\aluno *.* /e /s /h /y

net use n: \\192.168.1.7\d$
n:
xcopy \\192.168.1.200\d$\aluno *.* /e /s /h /y

net use o: \\192.168.1.8\d$
o:
xcopy \\192.168.1.200\d$\aluno *.* /e /s /h /y

net use p: \\192.168.1.9\d$
p:
xcopy \\192.168.1.200\d$\aluno *.* /e /s /h /y

net use q: \\192.168.1.10\d$
q:
xcopy \\192.168.1.200\d$\aluno *.* /e /s /h /y

net use r: \\192.168.1.11\d$
r:
xcopy \\192.168.1.200\d$\aluno *.* /e /s /h /y

net use s: \\192.168.1.12\d$
s:
xcopy \\192.168.1.200\d$\aluno *.* /e /s /h /y

pause

net use * /delete /y