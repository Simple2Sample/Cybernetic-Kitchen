from sys import stdin
from heapq import heappush, heappop
Inf = float(1e3000)

def mst(n,mat):
    usett=[1]*n
    count=1
    heaviest=0
    heapvei=[]
    minvei=[Inf]*n
    for i in mat[0]:
        heappush(heapvei,(mat[0][i],i))
        minvei[i] = mat[0][i]
    usett[0]=0
    while count<n:
        m, ind=heappop(heapvei)
        while not usett[ind]:
            m, ind=heappop(heapvei)
        usett[ind]=0
        minvei[ind]=Inf
        heaviest=max(heaviest, m)
        for i in mat[ind]:
            if usett[i]:
                if mat[ind][i]<minvei[i]:
                    minvei[i]=mat[ind][i]
                    heappush(heapvei,(mat[ind][i],i))
        count+=1
    return heaviest

def main():
    linjer = stdin.readlines()
    n = len(linjer)
    nabomatrise = [0] * n
    for i in xrange(n):
        nabomatrise[i]={}
    node = 0
    for linje in linjer:
        s=linje.split()
        s.reverse()
        for k in s:
            nabo, kant = k.split(':')
            nabo = int(nabo)
            if nabo<=node:  break;
            kant = int(kant)
            nabomatrise[node][nabo] = kant
            nabomatrise[nabo][node] = kant
        node += 1
    print mst(n,nabomatrise)

main()
