from sys import stdin

def minste_avstand(strenger):
    N = len(strenger)

    strenger.sort(lambda x,y: len(x) - len(y))
    le = [len(s) for s in strenger]

    count = [{' ':0, 'A':0, 'T':0, 'C':0, 'G':0} for _ in xrange(N)]
    for i in xrange(N):
        for b in strenger[i]:
            count[i][b] += 1

    min_avstand = float(1E300)
    total_avstand = [0 for _ in xrange(N)]
    avstand = [0] * le[-1]
    hopp = 1
    while hopp < N:
        for x in xrange(0, N - hopp):
            y = x + hopp
            s1 = strenger[x]
            s2 = strenger[y]
            l1 = le[x]
            l2 = le[y]
            c1 = count[x]
            c2 = count[y]
            for i in xrange(l2):
                avstand[i] = i
            for i in xrange(1, l1):
                avstand[0] = i
                skraa = i - 1
                for j in xrange(1, l2):
                    fjern = avstand[j] + 1
                    leggtil = avstand[j - 1] + 1
                    bytt = skraa
                    if s1[i] != s2[j]:
                        bytt += 1
                    skraa = avstand[j]
                    kost = fjern
                    if leggtil < kost:
                        kost = leggtil
                    if bytt < kost:
                        kost = bytt
                    avstand[j] = kost
            total_avstand[x] += avstand[l2-1]
            total_avstand[y] += avstand[l2-1]

        hopp += 1
    return min(total_avstand)

def main():
    print minste_avstand([' ' + linje.strip() for linje in stdin.readlines()])

main()
