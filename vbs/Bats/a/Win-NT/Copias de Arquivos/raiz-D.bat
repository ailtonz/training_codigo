cd\

net use h: \\131.107.2.1\c$
h:
xcopy \\131.107.2.200\c$\aluno *.* /e /s /h 

pause

net use i: \\131.107.2.2\c$
i:
xcopy \\131.107.2.200\c$\aluno *.* /e /s /h 

net use j: \\131.107.2.3\c$
j:
xcopy \\131.107.2.200\c$\aluno *.* /e /s /h 

net use l: \\131.107.2.4\c$
l:
xcopy \\131.107.2.200\c$\aluno *.* /e /s /h 

net use k: \\131.107.2.5\c$
k:
xcopy \\131.107.2.200\c$\aluno *.* /e /s /h 

net use m: \\131.107.2.6\c$
m:
xcopy \\131.107.2.200\c$\aluno *.* /e /s /h 

net use n: \\131.107.2.7\c$
n:
xcopy \\131.107.2.200\c$\aluno *.* /e /s /h 

net use o: \\131.107.2.8\c$
o:
xcopy \\131.107.2.200\c$\aluno *.* /e /s /h 

net use p: \\131.107.2.9\c$
p:
xcopy \\131.107.2.200\c$\aluno *.* /e /s /h 

net use q: \\131.107.2.10\c$
q:
xcopy \\131.107.2.200\c$\aluno *.* /e /s /h 

net use r: \\131.107.2.11\c$
r:
xcopy \\131.107.2.200\c$\aluno *.* /e /s /h 

net use s: \\131.107.2.12\c$
s:
xcopy \\131.107.2.200\c$\aluno *.* /e /s /h 

pause

net use * /delete 