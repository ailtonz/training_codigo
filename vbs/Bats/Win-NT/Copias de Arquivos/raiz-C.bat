cd\
c:
md boot
xcopy boot.ini /h c:\boot

pause

cd\
net use x: \\131.107.2.1\c$
x:
xcopy \\131.107.2.200\c$\boot *.* /e /s /h  

pause

net use f: \\131.107.2.2\c$
f:
xcopy \\131.107.2.200\c$\boot *.* /e /s /h 


net use z: \\131.107.2.3\c$
z:
xcopy \\131.107.2.200\c$\boot *.* /e /s /h 


net use h: \\131.107.2.4\c$
h:
xcopy \\131.107.2.200\c$\boot *.* /e /s /h 


net use i: \\131.107.2.5\c$
i:
xcopy \\131.107.2.200\c$\boot *.* /e /s /h 


net use j: \\131.107.2.6\c$
j:
xcopy \\131.107.2.200\c$\boot *.* /e /s /h 


net use l: \\131.107.2.7\c$
l:
xcopy \\131.107.2.200\c$\boot *.* /e /s /h 


net use m: \\131.107.2.8\c$
m:
xcopy \\131.107.2.200\c$\boot *.* /e /s /h 


net use n: \\131.107.2.9\c$
n:
xcopy \\131.107.2.200\c$\boot *.* /e /s /h 

net use o: \\131.107.2.10\c$
o:
xcopy \\131.107.2.200\c$\boot *.* /e /s /h 


net use p: \\131.107.2.11\c$
p:
xcopy \\131.107.2.200\c$\boot *.* /e /s /h 


net use q: \\131.107.2.12\c$
q:
xcopy \\131.107.2.200\c$\boot *.* /e /s /h 


pause

net use * /delete 