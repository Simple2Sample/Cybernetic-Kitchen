from sys import stdin, maxint

unlim = 5000
##stdin = open('C:/input10.txt')
def korteste_rute(rekkefolge, nabomatrise, byer):
    rekkefolge.append(rekkefolge[0])
    FloydWarshall(nabomatrise)
    total_cost = 0
    current_city = rekkefolge[0]
    for city in rekkefolge[1:]:
        cost = nabomatrise[current_city][city]
        if cost == unlim:
            return 'umulig'
        total_cost += cost
        current_city = city
    return total_cost

def FloydWarshall(matrix):
    n = len(matrix)
    for k in range(n):
        for i in range(n):
            for j in range(n):
                matrix[i][j] = min(matrix[i][j], matrix[i][k] + matrix[k][j])

def solve():                
    testcases = int(stdin.readline())
    for test in range(testcases):
        byer = int(stdin.readline())
        rekkefolge = [int(by) for by in stdin.readline().split()]
        matrix = []
        for by in range(byer):
          matrix.append([int(tall) for tall in stdin.readline().split()])
        for i in range(byer):
            for j in range(byer):
                if matrix[i][j] == -1:
                    matrix[i][j] = unlim
        print korteste_rute(rekkefolge, matrix, byer)
solve()

