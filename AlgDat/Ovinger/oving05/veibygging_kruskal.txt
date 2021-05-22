from sys import stdin

Inf = float('Inf')
False = 0
True = 1

def mst(n, kanter):
    # START IKKE-UTDELT KODE
    mintre = kruskal(n, kanter)
    return max([vekt for (vekt, fra, til) in mintre])

def kruskal(n, kanter):
    kanter.sort()
    T = range(n) # node -> komponent
    K = [[i] for i in range(n)] # komponent -> noder
    spenntre = []
    traer = n
    for (vekt, u, v) in kanter:
        Tu = T[u] 
        Tv = T[v]
        if Tu != Tv:
            if len(K[Tu]) > len(K[Tv]):
                u, v = v, u
                Tu, Tv = Tv, Tu
            K[Tv] += K[Tu]
            for w in K[Tu]:
                T[w] = Tv
            K[Tu] = []
            spenntre.append( (vekt, u, v) )
            traer -= 1
            if traer == 1:
                break
    return spenntre

# SLUTT IKKE-UTDELT KODE

kanter = []
fra = 0
for linje in stdin:
    for k in linje.split():
        data = k.split(':')
        til = int(data[0])
        vekt = int(data[1])
        kanter.append( (vekt, fra, til) )
    fra += 1
print mst(fra, kanter)
