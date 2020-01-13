cd\

net use i: \\192.168.1.1\c$
i:
cd\
rd  i:\2150 /q /s


net use j: \\192.168.1.2\c$
j:
cd\
rd  j:\2150 /q /s


net use k: \\192.168.1.3\c$
k:
cd\
rd  k:\2150 /q /s


net use l: \\192.168.1.4\c$
l:
cd\
rd  l:\2150 /q /s


net use m: \\192.168.1.5\c$
m:
cd\
rd  m:\2150 /q /s
rd  m:\2151 /q /s
rd  m:\2153 /q /s
rd  m:\2154 /q /s
rd  m:\2266 /q /s

net use n: \\192.168.1.6\c$
n:
cd\
rd  n:\2150 /q /s


net use o: \\192.168.1.7\c$
o:
cd\
rd  o:\2150 /q /s


net use p: \\192.168.1.8\c$
p:
cd\
rd  p:\2150 /q /s


net use q: \\192.168.1.9\c$
q:
cd\
rd  q:\2150 /q /s


net use r: \\192.168.1.10\c$
r:
cd\
rd  r:\2150 /q /s


net use s: \\192.168.1.11\c$
s:
cd\
rd  s:\2150 /q /s


net use t: \\192.168.1.12\c$
t:
cd\
rd  t:\2150 /q /s


pause

net use * /delete /y