from sys import *
import traceback

def subgraftetthet(nabomatrise, startnode):
    n = len(nabomatrise)
    # START IKKE-UTDELT KODE
    innenfor = [False] * n
    innenfor[startnode] = True
    queue = [startnode] # BFS
    while len(queue) > 0:
        fra = queue.pop(0)
        for til in range(0, n):
            if nabomatrise[fra][til] and not innenfor[til]:
                innenfor[til] = True
                queue.append(til)
    noder = 0
    kanter = 0
    for fra in range(0, n):
        if not innenfor[fra]:
            noder += 1
            for til in range(0, n):
                if nabomatrise[fra][til] and not innenfor[til]:
                    kanter += 1
    # SLUTT IKKE-UTDELT KODE
    if noder == 0:
        return 0.0
    else:
        return float(kanter) / float(noder**2)


try:
    n = int(stdin.readline())
    nabomatrise = [None] * n # rader
    for i in range(0, n):
        nabomatrise[i] = [False] * n # kolonner
        linje = stdin.readline()
        for j in range(0, n):
            nabomatrise[i][j] = (linje[j] == '1')
    for linje in stdin:
        start = int(linje)
        print "%.3f" % (subgraftetthet(nabomatrise, start) + 1E-12)
except:
    traceback.print_exc(file=stderr)
