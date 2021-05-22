from sys import stdin

Inf = float(1e3000)
False = 0
True = 1

def mst(nm):
    # START IKKE-UTDELT KODE
    mintre = prim(nm)
    sum = 0
    for (fra, til) in mintre:
        sum = max(sum, nm[fra][til])
    return sum

def prim(nm):
    n = len(nm)
    tre = []
    bestenabo = [None] * n
    bestepris = [Inf] * n
    ikke_funnet = range(1, n)
    forrige = 0
    while len(ikke_funnet) > 0:
        for i in ikke_funnet:
            if nm[i][forrige] < bestepris[i]:
                bestenabo[i] = forrige
                bestepris[i] = nm[i][forrige]
        minpris = Inf
        for i in ikke_funnet:
            if bestepris[i] < minpris:
                nestefra = i
                nestetil = bestenabo[i]
                minpris = bestepris[i]
        tre.append( (nestefra,nestetil) )
        ikke_funnet.remove(nestefra)
        forrige = nestefra
    return tre
# SLUTT IKKE-UTDELT KODE


linjer = []
for str in stdin:
    linjer.append(str)
n = len(linjer)
nabomatrise = [None] * n
node = 0
for linje in linjer:
    nabomatrise[node] = [Inf] * n
    for k in linje.split():
        data = k.split(':')
        nabo = int(data[0])
        vekt = int(data[1])
        nabomatrise[node][nabo] = vekt
    node += 1
print mst(nabomatrise)
