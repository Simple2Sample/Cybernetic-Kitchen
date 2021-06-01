# Metoden tar i betraktning at flere sok blir gjort i den samme grafen, 
# naar of naaralle sees paa baade som input og output
def subgraftetthet(naboliste, naar, naaralle, startnode):
    n = len(naboliste)
    # START IKKE-UTDELT KODE
    innenfor = [False] * n
    innenfor[startnode] = True
    queue = [startnode] 
    komplettert = {}
    while queue:
        franode = queue.pop(0)
        if franode in naaralle:
            naaralle[startnode] = True
            return 0.0
        if franode in komplettert:
            continue
        if franode in naar:
            for tilnode in naar[franode]:
                innenfor[tilnode] = True
                komplettert[tilnode] = True
        else:
            for tilnode in naboliste[franode]:
                if not innenfor[tilnode]:
                    innenfor[tilnode] = True
                    queue.append(tilnode)
    naar[startnode] = []
    for tilnode in xrange(n):
        if innenfor[tilnode]:
            naar[startnode].append(tilnode)
    ute_noder = n - len(naar[startnode])
    if ute_noder == 0:
        naaralle[startnode] = True
        return 0.0
    ute_kanter = 0
    for franode in xrange(n):
        if not innenfor[franode]:
            for tilnode in naboliste[franode]:
                if not innenfor[tilnode]:
                    ute_kanter += 1
    return float(ute_kanter) / ute_noder**2 
    # SLUTT IKKE-UTDELT KODE

def main():
    from sys import stdin
    n = int(stdin.readline())
    naar = {}
    naaralle = {}
    naboliste = [None] * n
    for i in range(0, n):
        naboliste[i] = []
        linje = stdin.readline()
        for j in xrange(0, n):
            if linje[j] == '1':
                naboliste[i].append(j)
    cache = {}
    for linje in stdin:
        start = int(linje)
        if not start in cache:
            cache[start] = subgraftetthet(naboliste, naar, naaralle, start)    
        print %.3f % (cache[start] + 1E-12)

main()
