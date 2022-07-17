from sys import stdin

def minCoinsGreedy(coins, value):
    # START IKKE-UTDELT KODE
        currentCoin = 0
        numCoins = 0
        while value > 0:
            if coins[currentCoin] <= value:
                value -= coins[currentCoin]
                numCoins += 1
            else:
                currentCoin += 1
        return numCoins                                                                                                                                
    # SLUTT IKKE-UTDELT KODE

def minCoinsDynamic(coins, value):
    # START IKKE-UTDELT KODE
        results = [Inf] * (value + 1)
        usefulCoins = []
        for c in coins:
            if c <= value:
                results[c] = 1
                usefulCoins.append(c)
        for curVal in xrange(1, value + 1):
            if results[curVal] != Inf:
                continue
            best = Inf
            for c in usefulCoins:
                if c <= curVal:
                    current = 1 + results[curVal - c]
                    if current < best:
                        best = current
            results[curVal] = best
        return results[value]                                                                                                                                                                                                                            
    # SLUTT IKKE-UTDELT KODE

def canUseGreedy(coins):
    # bare returner False her hvis du ikke klarer aa finne ut 
    # hva som er kriteriet for at den graadige algoritmen skal fungere
    # START IKKE-UTDELT KODE
        for i in xrange(len(coins) - 1):
            if coins[i] % coins[i + 1] != 0:
                return False
        return True
    # SLUTT IKKE-UTDELT KODE

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
