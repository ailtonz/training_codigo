cd\
net use w: \\131.107.2.1\c$
w:
cd WINNT\Profiles\Administrator\Desktop
xcopy \\131.107.2.200\c$\aluno2 /e /s /h

pause

net use j: \\131.107.2.2\c$
j:
cd WINNT\Profiles\Administrator\Desktop
xcopy \\131.107.2.200\c$\aluno2 


net use l: \\131.107.2.3\c$
l:
cd WINNT\Profiles\Administrator\Desktop
xcopy \\131.107.2.200\c$\aluno2 


net use m: \\131.107.2.4\c$
m:
cd WINNT\Profiles\Administrator\Desktop
xcopy \\131.107.2.200\c$\aluno2 


net use n: \\131.107.2.5\c$
n:
cd WINNT\Profiles\Administrator\Desktop
xcopy \\131.107.2.200\c$\aluno2 


net use o: \\131.107.2.6\c$
o:
cd WINNT\Profiles\Administrator\Desktop
xcopy \\131.107.2.200\c$\aluno2 


net use p: \\131.107.2.7\c$
p:
cd WINNT\Profiles\Administrator\Desktop
xcopy \\131.107.2.200\c$\aluno2 


net use q: \\131.107.2.8\c$
q:
cd WINNT\Profiles\Administrator\Desktop
xcopy \\131.107.2.200\c$\aluno2 


net use r: \\131.107.2.9\c$
r:
cd WINNT\Profiles\Administrator\Desktop
xcopy \\131.107.2.200\c$\aluno2 

net use s: \\131.107.2.10\c$
s:
cd WINNT\Profiles\Administrator\Desktop
xcopy \\131.107.2.200\c$\aluno2 

net use t: \\131.107.2.11\c$
t:
cd WINNT\Profiles\Administrator\Desktop
xcopy \\131.107.2.200\c$\aluno2 

net use u: \\131.107.2.12\c$
u:
cd WINNT\Profiles\Administrator\Desktop
xcopy \\131.107.2.200\c$\aluno2 

pause

net use * /delete 