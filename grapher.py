# Prepares a graph-viv file from MSMBuilder output

import sys
import re
import decimal as d

#Usage: python grapher.py Populations.dat tProb.mtx
#(Delete the first 3 lines of tProb.mtx)

file1 = open(sys.argv[1],"r")
file2 = open(sys.argv[2],"r")

print "digraph G {"
print
print "size=\"8,8\";"
print
print "// Graph"
  
a = []

i = 0
for line in file1:
   # print line,
    a.append(round(d.Decimal(float(line.rstrip("\n"))),4))
    i = i + 1

for line in file2:
     x = re.split('\s', line)
         
     x[0] = int(x[0]) -1
     x[1] = int(x[1]) -1
     x[2] = round(d.Decimal(float(x[2])),3)
     x[2] = str(x[2])
     
     print a[x[0]], "->", a[x[1]], '[label=%s]' %x[2]

print
print "}"
print