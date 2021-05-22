from sys import stdin
from math import log

Inf = float('Inf')
False = 0
True = 1

def mst(strukt):
    mintre = prim_heap(strukt)
    sum = 0
    for (fra, til, pris) in mintre:
        sum = max(sum, pris)
    return sum

def prim_heap(naboliste, start = 0):
    n = len(naboliste)
    tre = []
    heap = [None] * n
    for i in range(n):
        #         [Pris, node, nabo]
        heap[i] = [Inf, i, None]
    heap[start][0] = 0
    pos = range(n)
    heapify(heap, pos)
    for i in range(n):
        (pris, node, forelder) = heappop(heap, pos)
        tre.append( (forelder, node, pris) )
        for (barn, pris) in naboliste[node]:
            pb = pos[barn]
            if pb != None and pris < heap[pb][0]:
                heap[pb][0] = pris
                heap[pb][2] = node
                heaphoist(heap, pos, pb)
    # remove first edge, which is (None, 0, 0)
    tre.pop(0)
    return tre    

def heapify(heap, pos):
    for i in range(len(heap) / 2 - 1, -1, -1):
        heapfall(heap, pos, i)

def heappop(heap, pos):
    heap[0], heap[-1] = heap[-1], heap[0]
    pos[heap[0][1]] = 0
    pos[heap[-1][1]] = None
    ret = heap.pop()
    if len(heap) > 1:
        heapfall(heap, pos, 0)
    return ret

def heapfall(heap, pos, i):
    minv = heap[i]
    mini = i
    il = i * 2 + 1
    ir = il + 1
    if il < len(heap) and heap[il] < minv:
        minv = heap[il]
        mini = il
    if ir < len(heap) and heap[ir] < minv:
        minv = heap[ir]
        mini = ir
    if mini != i:
        heap[i], heap[mini] = heap[mini], heap[i]
        pos[heap[i][1]], pos[heap[mini][1]] = pos[heap[mini][1]], pos[heap[i][1]]
        heapfall(heap, pos, mini)
    
def heaphoist(heap, pos, i):
    if i == 0:
        return 
    p = (i - 1) / 2
    if heap[i] < heap[p]:
        pos[heap[i][1]] = p
        pos[heap[p][1]] = i
        heap[i], heap[p] = heap[p], heap[i]
        heaphoist(heap, pos, p)

def main():
    linjer = []
    for linje in stdin:
        linjer.append(linje)

    naboliste = []
    for linje in linjer:
        kanter = linje.split()
        naboer = []
        for k in kanter:
            data = k.split(':')
            nabo = int(data[0])
            vekt = int(data[1])
            naboer.append( (nabo, vekt) )
        naboliste.append(naboer)
    pris = mst(naboliste)
    print pris

main()
