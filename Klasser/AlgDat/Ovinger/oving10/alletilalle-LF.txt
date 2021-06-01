from sys import stdin, maxint

def korteste_rute(rekkefolge, nabomatrise, byer):
    # START IKKE-UTDELT KODE
    distansematrise = floydwarshall(nabomatrise, byer)
    distanse = 0
    for i in range(len(rekkefolge)):
        distanse += distansematrise[rekkefolge[i]][rekkefolge[(i+1) % byer]]
    if distanse >= maxint / 3: distanse = "umulig"
    return distanse


def floydwarshall(nabomatrise, n):
    for k in range(n):
        for i in range(n):
            for j in range(n):
                nabomatrise[i][j] = min(nabomatrise[i][j], nabomatrise[i][k] + nabomatrise[k][j])

    return nabomatrise

# SLUTT IKKE-UTDELT KODE

testcases = int(stdin.readline())
for test in range(testcases):
    byer = int(stdin.readline())
    rekkefolge = [int(by) for by in stdin.readline().split()]
    nabomatrise = []
    for by in range(byer):
    # START IKKE-UTDELT KODE
        naboer = []
        for distanse in stdin.readline().split():
            distanse = int(distanse)
            if distanse == -1: distanse = maxint / 3
            naboer.append(distanse)
        nabomatrise.append(naboer)
    # SLUTT IKKE-UTDELT KODE
    print korteste_rute(rekkefolge, nabomatrise, byer)
