from sys import stdin

stdin = open('C:/input11-2.txt')
def minCoinsGreedy(coins, value):
    # SKRIV DIN KODE HER
    count = 0
    i = 0
    while value > 0:
        if value/coins[i] >= 1:
            add = value/coins[i]
            value = value%coins[i]
            count = count + add
        i += 1
    return count
        
def minCoinsDynamic(coins, value):
    # SKRIV DIN KODE HER
    count = [0]
    for i in range(len(count), value + 1):
        count.append(count[i-1] + 1)
        for coin in coins:
            if coin <= i and count[i-coin] + 1 < count[i]:
                count[i] = count[i-coin] + 1
    return count[value]

def canUseGreedy(coins):
    # bare returner False her hvis du ikke klarer aa finne ut 
    # hva som er kriteriet for at den graadige algoritmen skal fungere
    # SKRIV DIN KODE HER
    for i in range(1,len(coins)):
        if coins[i]%coins[i-1] != 0:
            return False
    return True

Inf = 1000000000
coins = []
for c in stdin.readline().split():
    coins.append(int(c))
coins.sort()
coins.reverse()
method = stdin.readline().strip()
if method == "graadig" or (method == "velg" and canUseGreedy(coins)):
    for line in stdin:
        print minCoinsGreedy(coins, int(line))
else:
    for line in stdin:
        print minCoinsDynamic(coins, int(line))
