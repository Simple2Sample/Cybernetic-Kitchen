# Takk til Christian B^hn
# Skrevet av Eirik Reksten ut fra koden til ovennevnte

from sys import stdin
from math import log

# *************************** SORTERINGSMETODER ************************

# En implementasjon av countsort som fjerner duplikater
def count_sort_singles(nums, range, l):

  b = ['X'] * range
  for x in nums:
    b[x - l] = x
  endList = []
  for x in b:
    if x != 'X':
      endList.append(x)
  return endList

# Den folgende metoden er en korrekt implementasjon for 
# radixsort (iallfall hva tall angaar, test selv paa annet)
def radix_sort(m, max):
  bits = 0
  while max > 2**bits:
    m = shifted_count_sort(bits, m)
    bits += 8
  return m

# Den folgende metoden sorterer list paa de 8 minst
# signifikante bits over shift-bitene
def shifted_count_sort(shift, list):

  c = [0] * 256
  for x in list:
    b = (x >> shift) & 0xFF
    c[b] += 1
    
  for x in xrange(1, 256):
    c[x] += c[x - 1]
    
  endList = [0] * len(list)
  
  for x in reversed(list):
    b = (x >> shift) & 0xFF
    c[b] -= 1
    endList[c[b]] = x
    
  return endList
    
# ****************************** SOKEMETODER ******************************

# Vanlig binart sok
def binsok(A, v):
  l = 0
  r = len(A) - 1
  while l <= r:
    m = (l + r) >> 1
    if A[m] < v:
      l = m + 1
    elif v < A[m]:
      r = m - 1
    else:
      break
  return m
  
# Ved liten range, tjener man paa aa regne ut min og maks-verdier
# for alle verdier innenfor hoyeste og laveste verdi i listen,
# for deretter aa hente ut alle resultatene...
def finn_smallRange(n, reqs, l, u, range):

  b1 = [0] * range
  b2 = [0] * range
  
  result = []
  a = result.append
  
  i = int
  if len(n) > 1:
    b1[0] = n[0]
    b2[:n[1] - l] = [n[0]] * (n[1] - l)
    n2 = n[0] - l
    n3 = n[1] - l
    for x in xrange(1, len(n) - 1):
      n1 = n2
      n2 = n3
      n3 = n[x + 1] - l
      b1[n1 + 1:n2 + 1] = [n2 + l] * (n2 - n1)
      b2[n2:n3] = [n2 + l] * (n3 - n2)
      
    ln = len(n) - 1
    b1[n[ln - 1] - l + 1:] = [n[ln]] * (n[ln] - n[ln - 1])
    b2[len(b2) - 1] = n[ln]
  else:
    b1[0] = n[0]
    b2[0] = n[0]
    
  for b in reqs:
    min = i(b[0]) - l
    if min < 0:
      min = 0
    minv = b2[min]
    
    max = i(b[1])
    if max <= u:
      max = max - l
    else:
      max = range - 1
    maxv = b1[max]
    a("%s %s" % (minv, maxv))
  print "\n".join(result)
  
  
# Lineart sok (brukes paa usortert liste)
def finn_linear(liste, reqs, maksimum, minimum):
  results = []
  a = results.append
  for req in reqs:
    min = int(req[0])
    max = int(req[1])
    minv = minimum
    maxv = maksimum
    for v in liste:
      if v > minv and v <= min:
        minv = v
      if v < maxv and v >= max:
        maxv = v
    a("%s %s" % (minv, maxv))
  print "\n".join(results)
  
# ******************** MAIN-METODE (PROGRAMMET) ****************

def main():
  nums = map(int, stdin.readline().split())
  l = min(nums)
  u = max(nums)
  range = u - l + 1
  reqs = map(str.split, stdin)
  if len(reqs) < log(len(nums), 2):
    finn_linear(nums, reqs, u, l)
  else:
    if len(nums) * 4 > range:
      n = count_sort_singles(nums, range, l)
    else:
      n = radix_sort(nums, u)
    finn_smallRange(n, reqs, l, u, range)

main()
