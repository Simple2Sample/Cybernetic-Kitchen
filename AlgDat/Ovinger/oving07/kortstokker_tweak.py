# takk til Arne Bergene Fossaa og Simon Jonassen for lure triks

from sys import stdin
from math import ceil
from itertools import repeat

def merge(stokker, total_n):
    ls = len(stokker)
    ps = 0 # hvilken stokk ser vi paa?
    while ls > 1:
        if ps >= ls - 1:
            if ps == ls - 1: # ble det en til overs?
                stokker[ps // 2] = stokker[ps]
            ps = 0
            ls = int(ceil(ls / 2.0))
            continue
        s1 = stokker[ps]
        s2 = stokker[ps+1]
        if s1[-1] > s2[-1]:
            s1, s2 = s2, s1
        ls1 = len(s1)
        ls2 = len(s2)
        sr = [0] * (ls1 + ls2)
        psr = ps1 = ps2 = 0
        v2 = s2[0]
        while ps1 < ls1:
            v1 = s1[ps1] 
            if v1 < v2:
                sr[psr] = v1
                ps1 += 1
            else:
                sr[psr] = v2
                ps2 += 1
                v2 = s2[ps2] # vil aldri gaa utenfor
            psr += 1
        sr[psr:] = s2[ps2:]
        stokker[ps // 2] = sr
        ps += 2
    return stokker[0]

def main():
    linjer = []
    for linje in stdin:
        linjer.append(linje)

    oppslag = {}
    stokker = []
    total_n = 0
    for linje in linjer:
        (bokstav, tall) = linje.split(':')
        par = zip(tall.split(','), repeat(bokstav))
        n = len(par)
        stokk = [0] * n
        for i in xrange(n):
            tall = int(par[i][0])
            stokk[i] = tall
            oppslag[tall] = par[i][1]
        stokker.append(stokk)
        total_n += n

    sortert = merge(stokker, total_n)
    print ''.join(map(oppslag.get, sortert))

main()
