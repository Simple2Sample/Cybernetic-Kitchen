from sys import stdin, maxint

##stdin = open('C:/input10.txt')
def extractMin(Q, estimate):
    #find node with best estimat from nodes in Q
    best_node = None
    best_estimate = maxint
    for i in Q:
        if estimate[i] < best_estimate:
            best_estimate = estimate[i]
            best_node = i
    return best_node

def KortesteRute(rekkefolge, nabomatrise, byer):
    rekkefolge.append(rekkefolge[0])
    n = len(nabomatrise)
    total_cost = 0
    for i in range(len(rekkefolge) - 1):
        fra = rekkefolge[i]
        til = rekkefolge[i+1]
            
        #Dijkstras
        estimate = [maxint]*n
        estimate[fra] = 0
        Q = set(i for i in range(n))
        while Q:
            u = extractMin(Q, estimate)
            if u == None or u == til:
                break
            Q.remove(u)
            #relax alle noder som er nabo med u
            for nabo in Q:
                if nabomatrise[u][nabo] != -1:
                    if estimate[u] + nabomatrise[u][nabo] < estimate[nabo]:
                        estimate[nabo] = estimate[u] + nabomatrise[u][nabo]
        
        cost = estimate[til]
        if cost == maxint:
            return 'umulig'
        total_cost += cost
    return total_cost


def Solve(): 
    testcases = int(stdin.readline())
    for test in range(testcases):
        byer = int(stdin.readline())
        rekkefolge = [int(by) for by in stdin.readline().split()]
        matrix = []
        for by in range(byer):
            matrix.append([int(tall) for tall in stdin.readline().split()])
        print KortesteRute(rekkefolge, matrix, byer)
Solve()

