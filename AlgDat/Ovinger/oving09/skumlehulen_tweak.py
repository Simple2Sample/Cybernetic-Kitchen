# Takk til Daniel Martin Lewis Barker for den foerste 
# korrekte loesningen uten nodesplitting.

from sys import stdin

def main():
    n, ns, ne = [int(x) for x in stdin.readline().split()]
    if n == 1: 
        return '1'
    S = [int(x) for x in stdin.readline().split()]
    E = [int(x) for x in stdin.readline().split()]
    iS = [False] * n
    iE = [False] * n
    for s in S: iS[s] = True
    for e in E: iE[e] = True
    L = [[]] * n
    for u in xrange(n):
        line = stdin.readline()
        if not iE[u]:
            L[u] = [v for v in xrange(n) if line[2*v] == '1' and not iS[v]]
    correct_paths = 0
    for s in S:
        if iE[s]:
            iE[s] = False
            continue
        P = [-1] * n
        Q = [s]
        while Q:
            u = Q.pop(0)
            for v in L[u]:
                if P[v] == -1:
                    P[v] = u
                    if not iE[v]:
                        Q.append(v)
                    else:
                        iE[v] = False
                        w = v
                        while w != s:
                            L[w] = L[P[w]] + [P[w]]
                            w = P[w]
                        Q = []
                        correct_paths += 1
                        break
    return "%d" % correct_paths

print main()
