from sys import stdin, stderr

def beste_sti(nm, sans):
    # START IKKE-UTDELT KODE
    n = len(sans)
    ferdig = [False] * n
    ksans = [0.0] * n # kummulativ sannsynlighet
    ksans[0] = sans[0]
    forrige = range(n)
    beste_node = 0
    for i in range(n):
        node = beste_node
        ferdig[node] = True
        hoyeste_ksans = -1.0
        for nabo in range(n):
            if not ferdig[nabo]:
                if nm[node][nabo]:
                    tilbud = ksans[node] * sans[nabo]
                    if tilbud > ksans[nabo]:
                        forrige[nabo] = node
                        ksans[nabo] = tilbud
                if ksans[nabo] > hoyeste_ksans:
                    beste_node = nabo
                    hoyeste_ksans = ksans[nabo]
    if(ksans[-1] == 0.0):
        return '0'
    index = n - 1
    sti = []
    while index != 0:
        sti.append(index)
        index = forrige[index]
    sti.append(0)
    return '-'.join(map(str, reversed(sti)))
    # SLUTT IKKE-UTDELT KODE

n = int(stdin.readline())
sansynligheter = [float(x) for x in stdin.readline().split()]
nabomatrise = []
for linje in stdin:
    naborad = [0] * n
    naboer = [int(nabo) for nabo in linje.split()]
    for nabo in naboer:
        naborad[nabo] = 1
    nabomatrise.append(naborad)
print beste_sti(nabomatrise, sansynligheter)
