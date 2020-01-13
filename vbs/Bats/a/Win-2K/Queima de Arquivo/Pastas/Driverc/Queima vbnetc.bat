cd\

net use i: \\denver\c$
i:
cd\
rd  i:\1561 /q /s
rd  i:\2151 /q /s
rd  i:\2153 /q /s
rd  i:\2154 /q /s
rd  i:\2266 /q /s
rd  i:\Join /q /s

pause
net use j: \\vancouver\c$
j:
cd\
rd  j:\1561 /q /s
rd  j:\2151 /q /s
rd  j:\2153 /q /s
rd  j:\2154 /q /s
rd  j:\2266 /q /s
rd  i:\Join /q /s

net use k: \\perth\c$
k:
cd\
rd  k:\1561 /q /s
rd  k:\2151 /q /s
rd  k:\2153 /q /s
rd  k:\2154 /q /s
rd  k:\2266 /q /s
rd  i:\Join /q /s

net use l: \\brisbane\c$
l:
cd\
rd  l:\1561 /q /s
rd  l:\2151 /q /s
rd  l:\2153 /q /s
rd  l:\2154 /q /s
rd  l:\2266 /q /s
rd  i:\Join /q /s

net use m: \\lisbon\c$
m:
cd\
rd  m:\1561 /q /s
rd  m:\2151 /q /s
rd  m:\2153 /q /s
rd  m:\2154 /q /s
rd  m:\2266 /q /s
rd  i:\Join /q /s

net use n: \\bonn\c$
n:
cd\
rd  n:\1561 /q /s
rd  n:\2151 /q /s
rd  n:\2153 /q /s
rd  n:\2154 /q /s
rd  n:\2266 /q /s
rd  i:\Join /q /s

net use o: \\lima\c$
o:
cd\
rd  o:\1561 /q /s
rd  o:\2151 /q /s
rd  o:\2153 /q /s
rd  o:\2154 /q /s
rd  o:\2266 /q /s
rd  i:\Join /q /s

net use p: \\santiago\c$
p:
cd\
rd  p:\1561 /q /s
rd  p:\2151 /q /s
rd  p:\2153 /q /s
rd  p:\2154 /q /s
rd  p:\2266 /q /s
rd  i:\Join /q /s

net use q: \\bangalore\c$
q:
cd\
rd  q:\1561 /q /s
rd  q:\2151 /q /s
rd  q:\2153 /q /s
rd  q:\2154 /q /s
rd  q:\2266 /q /s
rd  i:\Join /q /s

net use r: \\singapore\c$
r:
cd\
rd  r:\1561 /q /s
rd  r:\2151 /q /s
rd  r:\2153 /q /s
rd  r:\2154 /q /s
rd  r:\2266 /q /s
rd  i:\Join /q /s

net use s: \\casablanca\c$
s:
cd\
rd  s:\1561 /q /s
rd  s:\2151 /q /s
rd  s:\2153 /q /s
rd  s:\2154 /q /s
rd  s:\2266 /q /s
rd  i:\Join /q /s

net use t: \\tunis\c$
t:
cd\
rd  t:\1561 /q /s
rd  t:\2151 /q /s
rd  t:\2153 /q /s
rd  t:\2154 /q /s
rd  t:\2266 /q /s
rd  i:\Join /q /s

pause

net use * /delete /y