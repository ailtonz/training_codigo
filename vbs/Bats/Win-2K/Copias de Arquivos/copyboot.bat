cd\
c:
md boot
xcopy boot.ini /h c:\boot

pause

cd\
net use x: \\vancouver\c$
x:
xcopy \\london\c$\boot *.* /e /s /h /y 

pause

net use f: \\denver\c$
f:
xcopy \\london\c$\boot *.* /e /s /h /y


net use z: \\perth\c$
z:
xcopy \\london\c$\boot *.* /e /s /h /y


net use h: \\brisbane\c$
h:
xcopy \\london\c$\boot *.* /e /s /h /y


net use i: \\lisbon\c$
i:
xcopy \\london\c$\boot *.* /e /s /h /y


net use j: \\bonn\c$
j:
xcopy \\london\c$\boot *.* /e /s /h /y


net use l: \\lima\c$
l:
xcopy \\london\c$\boot *.* /e /s /h /y


net use m: \\santiago\c$
m:
xcopy \\london\c$\boot *.* /e /s /h /y


net use n: \\bangalore\c$
n:
xcopy \\london\c$\boot *.* /e /s /h /y

net use o: \\singapore\c$
o:
xcopy \\london\c$\boot *.* /e /s /h /y


net use p: \\casablanca\c$
p:
xcopy \\london\c$\boot *.* /e /s /h /y


net use q: \\tunis\c$
q:
xcopy \\london\c$\boot *.* /e /s /h /y


pause

net use * /delete /y