from sys import stdin
#stdin = open('input.txt')
 
def avstand(s1, s2):
    s1 = ' ' + s1
    s2 = ' ' + s2
    m, n = len(s1), len(s2)
    d = [range(n)]
    for i in range(1, m):
        d.append([0]*n)
        d[i][0] = i
    for j in range(1, n):
        for i in range(1, m):
            if s1[i] == s2[j]:
                d[i][j] = d[i-1][j-1]
            else:
                d[i][j] = min(d[i-1][j] + 1, d[i][j-1] + 1, d[i-1][j-1] + 1)
    return d[-1][-1]
 
def minste_avstand(strings):
    least = 1e200
    solved = [[None for j in range(len(strings))] for i in range(len(strings))]
    for i, string in enumerate(strings):
        temp = 0
        for j, other_string in enumerate(strings):
            if string != other_string:
                if solved[i][j] == None:
                    solved[i][j] = solved[j][i] = avstand(string, other_string)
                temp += solved[i][j]
        if temp < least:
            least = temp
    return least
 
def solve():
    print minste_avstand(map(str.strip, stdin))
solve()
