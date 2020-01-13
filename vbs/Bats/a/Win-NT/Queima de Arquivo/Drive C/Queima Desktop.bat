cd\

net use h: \\131.107.2.1\d$
h:
xcopy \\131.107.2.200\d$\aluno *.* /e /s /h 

pause

net use i: \\131.107.2.2\d$
i:
xcopy \\131.107.2.200\d$\aluno *.* /e /s /h 

net use j: \\131.107.2.3\d$
j:
xcopy \\131.107.2.200\d$\aluno *.* /e /s /h 

net use l: \\131.107.2.4\d$
l:
xcopy \\131.107.2.200\d$\aluno *.* /e /s /h 

net use k: \\131.107.2.5\d$
k:
xcopy \\131.107.2.200\d$\aluno *.* /e /s /h 

net use m: \\131.107.2.6\d$
m:
xcopy \\131.107.2.200\d$\aluno *.* /e /s /h 

net use n: \\131.107.2.7\d$
n:
xcopy \\131.107.2.200\d$\aluno *.* /e /s /h 

net use o: \\131.107.2.8\d$
o:
xcopy \\131.107.2.200\d$\aluno *.* /e /s /h 

net use p: \\131.107.2.9\d$
p:
xcopy \\131.107.2.200\d$\aluno *.* /e /s /h 

net use q: \\131.107.2.10\d$
q:
xcopy \\131.107.2.200\d$\aluno *.* /e /s /h 

net use r: \\131.107.2.11\d$
r:
xcopy \\131.107.2.200\d$\aluno *.* /e /s /h 

net use s: \\131.107.2.12\d$
s:
xcopy \\131.107.2.200\d$\aluno *.* /e /s /h 

pause

net use * /delete 