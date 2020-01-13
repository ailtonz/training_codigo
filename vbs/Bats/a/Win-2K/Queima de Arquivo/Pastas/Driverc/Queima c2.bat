cd\

net use i: \\192.168.1.1\c$
i:
cd\
rd  i:\1561 /q /s
rd  i:\2151 /q /s
rd  i:\2153 /q /s
rd  i:\2154 /q /s
rd  i:\2266 /q /s

net use j: \\192.168.1.2\c$
j:
cd\
rd  j:\1561 /q /s
rd  j:\2151 /q /s
rd  j:\2153 /q /s
rd  j:\2154 /q /s
rd  j:\2266 /q /s

net use k: \\192.168.1.3\c$
k:
cd\
rd  k:\1561 /q /s
rd  k:\2151 /q /s
rd  k:\2153 /q /s
rd  k:\2154 /q /s
rd  k:\2266 /q /s

net use l: \\192.168.1.4\c$
l:
cd\
rd  l:\1561 /q /s
rd  l:\2151 /q /s
rd  l:\2153 /q /s
rd  l:\2154 /q /s
rd  l:\2266 /q /s

net use m: \\192.168.1.5\c$
m:
cd\
rd  m:\1561 /q /s
rd  m:\2151 /q /s
rd  m:\2153 /q /s
rd  m:\2154 /q /s
rd  m:\2266 /q /s

net use n: \\192.168.1.6\c$
n:
cd\
rd  n:\1561 /q /s
rd  n:\2151 /q /s
rd  n:\2153 /q /s
rd  n:\2154 /q /s
rd  n:\2266 /q /s

net use o: \\192.168.1.7\c$
o:
cd\
rd  o:\1561 /q /s
rd  o:\2151 /q /s
rd  o:\2153 /q /s
rd  o:\2154 /q /s
rd  o:\2266 /q /s

net use p: \\192.168.1.8\c$
p:
cd\
rd  p:\1561 /q /s
rd  p:\2151 /q /s
rd  p:\2153 /q /s
rd  p:\2154 /q /s
rd  p:\2266 /q /s

net use q: \\192.168.1.9\c$
q:
cd\
rd  q:\1561 /q /s
rd  q:\2151 /q /s
rd  q:\2153 /q /s
rd  q:\2154 /q /s
rd  q:\2266 /q /s

net use r: \\192.168.1.10\c$
r:
cd\
rd  r:\1561 /q /s
rd  r:\2151 /q /s
rd  r:\2153 /q /s
rd  r:\2154 /q /s
rd  r:\2266 /q /s

net use s: \\192.168.1.11\c$
s:
cd\
rd  s:\1561 /q /s
rd  s:\2151 /q /s
rd  s:\2153 /q /s
rd  s:\2154 /q /s
rd  s:\2266 /q /s

net use t: \\192.168.1.12\c$
t:
cd\
rd  t:\1561 /q /s
rd  t:\2151 /q /s
rd  t:\2153 /q /s
rd  t:\2154 /q /s
rd  t:\2266 /q /s

pause

net use * /delete /y