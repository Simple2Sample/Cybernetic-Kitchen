from sys import stdin

def sorter(A):
    # Merk: den sorterte lista ma returneres
    # START IKKE-UTDELT KODE
    for j in xrange(1, len(A)):
        k = A[j]
        i = j - 1
        while i >= 0 and A[i] > k:
            A[i+1] = A[i]
            i = i - 1
        A[i+1] = k
    return A
    # SLUTT IKKE-UTDELT KODE

def finn(A, nedre, ovre):
    # Merk: resultatet ma returneres
    # START IKKE-UTDELT KODE
    indeks_nedre = binsok(A, nedre)
    indeks_ovre = binsok(A, ovre)
    if A[indeks_nedre] > nedre and indeks_nedre != 0:
        indeks_nedre -= 1
    if A[indeks_ovre] < ovre and indeks_ovre != len(A) - 1:
        indeks_ovre += 1
    return [A[indeks_nedre], A[indeks_ovre]]

def binsok(A, verdi):
    l = 0
    r = len(A) - 1
    while l <= r:
        m = (l + r) // 2
        if verdi == A[m]:
            break
        elif verdi < A[m]:
            r = m - 1
        else:
            l = m + 1
    return m
# SLUTT IKKE-UTDELT KODE

liste = []
for x in stdin.readline().split():
    liste.append(int(x))

sortert = sorter(liste)

for linje in stdin:
    ord = linje.split()
    minst = int(ord[0])
    maks = int(ord[1])
    resultat = finn(sortert, minst, maks)
    print str(resultat[0]) + " " + str(resultat[1])
