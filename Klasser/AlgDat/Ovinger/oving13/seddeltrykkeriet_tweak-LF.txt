from sys import stdin

def solve(w, h, S):
    B = [[0] * (h+1) for _ in xrange(w+1)]
    bx, by, bv, bo = 0, 0, 0, 0.0
    for x, y, v in S:
        if x <= w and y <= h:
            B[x][y] = max(B[x][y], v)
        if x <= h and y <= w:
            B[y][x] = max(B[y][x], v)
        if float(v) / (x*y) > bo:
            bx, by, bv, bo = x, y, v, float(v) / (x*y)
    for y in xrange(1, h+1):
        for x in xrange(y, w+1):
            if x % bx == 0 and y % by == 0:
                b = (x / bx) * (y / by) * bv
            elif x % by == 0 and y % bx == 0:
                b = (x / by) * (y / bx) * bv			
            else: 
                b = B[x][y]
                for s in xrange(1, x / 2 + 1):
                    if B[s][y] + B[x-s][y] > b:
                        b = B[s][y] + B[x-s][y]
                for s in xrange(1, y / 2 + 1):
                    if B[x][s] + B[x][y-s] > b:
                        b = B[x][s] + B[x][y-s]
            B[x][y] = b
            if x <= h:
                B[y][x] = b 
    return B

def main():
    S = []
    for seddel in [s for s in stdin.readline().split()]:
        dim_value = seddel.split(':', 1)
        dim = dim_value[0].split('x', 1)
        w = int(dim[0][1:])
        h = int(dim[1][:-1])
        S.append([w, h, int(dim_value[1])])
    WH = []
    W = []
    H = []
    for line in stdin:
        w, h = [int(x) for x in line.split('x',1)]
        if w < h:
            w, h = h, w
        W.append(w)
        H.append(h)
        WH.append((w, h))
    B = solve(max(W), max(H), S)
    for w, h in WH:
        print B[w][h]

main()
