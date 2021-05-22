# Takk til Daniel Martin Lewis Barker 

from sys import stdin

def main():
    L = stdin.readlines()
    n = int(L[0])
    P = [float(x) for x in L[1].split()]
    if n == 1:
        return '0'
    H = [(P[0], 0, 0)]
    S = [False] * n
    previous = range(n)
    while H:
        p, u, prev = heappop(H)
        if S[u]:
            continue
        previous[u] = prev
        S[u] = True
        for v in reversed([int(x) for x in L[2 + u].split()]):
            if v == n - 1:
                previous[v] = u
                if(p * P[v] != 0.0):
                    return trace_path(previous)
                else:
                    return '0'
            heappush(H,(p * P[v], v, u))
    return '0'

def trace_path(predecessors):
    index = len(predecessors) - 1
    path = []
    while(index != 0):
        path.append(index)
        index = predecessors[index]
    path.append(0)
    return '-'.join(map(str, reversed(path)))

def heappop(H):
    H[0], H[-1] = H[-1], H[0]
    x = H.pop()
    n = len(H)
    i = 0
    while True:
        l = 2 * i + 1
        r = l + 1
        if l < n:
            b = l
            if r < n and H[r] > H[l]:
                b = r
            if H[b] > H[i]:
                H[b], H[i] = H[i], H[b]
                i = b
            else: 
                break
        else:
            break
    return x

def heappush(H, x):
    H.append(x)
    i = len(H) - 1
    while i > 0:
        p = (i-1) // 2
        if H[p] < H[i]:
            H[p], H[i] = H[i], H[p]
            i = p
        else:
            break


print main()
