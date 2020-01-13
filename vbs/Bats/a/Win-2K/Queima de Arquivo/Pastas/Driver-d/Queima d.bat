cd\

net use i: \\192.168.1.1\c$
i:
cd\
rd  i:\1561 /q /s
rd  i:\2063 /q /s
rd  i:\2389 /q /s
rd  i:\2124 c /q /s
rd  i:\Curso BF-83 /q /s

net use j: \\192.168.1.2\c$
j:
cd\
rd  j:\1561 /q /s
rd  j:\2063 /q /s
rd  j:\2389 /q /s
rd  j:\2124 c /q /s
rd  j:\Curso BF-83 /q /s

net use k: \\192.168.1.3\c$
k:
cd\
rd  k:\1561 /q /s
rd  k:\2063 /q /s
rd  k:\2389 /q /s
rd  k:\2124 c /q /s
rd  k:\Curso BF-83 /q /s

net use l: \\192.168.1.4\c$
l:
cd\
rd  l:\1561 /q /s
rd  l:\2063 /q /s
rd  l:\2389 /q /s
rd  l:\2124 c /q /s
rd  l:\Curso BF-83 /q /s

net use m: \\192.168.1.5\c$
m:
cd\
rd  m:\1561 /q /s
rd  m:\2063 /q /s
rd  m:\2389 /q /s
rd  m:\2124 c /q /s
rd  m:\Curso BF-83 /q /s

net use n: \\192.168.1.6\c$
n:
cd\
rd  n:\1561 /q /s
rd  n:\2063 /q /s
rd  n:\2389 /q /s
rd  n:\2124 c /q /s
rd  n:\Curso BF-83 /q /s

net use o: \\192.168.1.7\c$
o:
cd\
rd  o:\1561 /q /s
rd  o:\2063 /q /s
rd  o:\2389 /q /s
rd  o:\2124 c /q /s
rd  o:\Curso BF-83 /q /s

net use p: \\192.168.1.8\c$
p:
cd\
rd  p:\1561 /q /s
rd  p:\2063 /q /s
rd  p:\2389 /q /s
rd  p:\2124 c /q /s
rd  p:\Curso BF-83 /q /s

net use q: \\192.168.1.9\c$
q:
cd\
rd  q:\1561 /q /s
rd  q:\2063 /q /s
rd  q:\2389 /q /s
rd  q:\2124 c /q /s
rd  q:\Curso BF-83 /q /s

net use r: \\192.168.1.10\c$
r:
cd\
rd  r:\1561 /q /s
rd  r:\2063 /q /s
rd  r:\2389 /q /s
rd  r:\2124 c /q /s
rd  r:\Curso BF-83 /q /s

net use s: \\192.168.1.13\c$
s:
cd\
rd  s:\1561 /q /s
rd  s:\2063 /q /s
rd  s:\2389 /q /s
rd  s:\2124 c /q /s
rd  s:\Curso BF-83 /q /s

net use t: \\192.168.1.12\c$
t:
cd\
rd  t:\1561 /q /s
rd  t:\2063 /q /s
rd  t:\2389 /q /s
rd  t:\2124 c /q /s
rd  t:\Curso BF-83 /q /s

pause

net use * /delete /y