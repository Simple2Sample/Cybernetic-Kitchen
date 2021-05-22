# laget av: Fredrik Ludvigsen

from sys import stdin

def minCoinsGreedy(coins, value):
	i = 0
	ant_mynt = 0
	while value > 0:
		while coins[i] > value:
			i += 1
		mul = value // coins[i]
		value = value - (coins[i] * mul)
		ant_mynt += mul
	return ant_mynt

def minCoinsDynamic(coins, value):
	# myntkombinasjoner[i] skal inneholde summer som bruker i-1 mynter, hvis 
	# den samme summen ikke har blitt laget tidligere med faerre mynter
	
	myntkombinasjoner = [[]]
	
	# filtrer ut ubrukelige mynter, stopp hvis en mynt alene dekker det eksakte beloepet
	
	for coin in coins:
		if coin < value:
			myntkombinasjoner[0].append(coin)
		elif coin == value:
			return 1
	taken = {}
	while True:
		myntkombinasjoner.append([])
		for previous_sum in myntkombinasjoner[-2]:
			for coin in myntkombinasjoner[0]:
				sum = coin + previous_sum
				if sum > value:
					continue
				if sum == value:
					return len(myntkombinasjoner)
				if sum not in taken:
					taken[sum] = True
					myntkombinasjoner[-1].append(sum)
				

def canUseGreedy(coins):
    # I foelge "The Greedy Extension Theorem" vil man kunne utvide et graadig
    # myntsett med en stoerre mynt Ai+1 hvis og bare hvis ceil(Ai+1 / Ai) * Ai
    # kan bygges graadig med ceil(Ai+1 / Ai) antall mynter eller faerre.
	checkamounts = []
	for i in xrange(len(coins)-1):
		if coins[i] % coins[i+1]:
			# mul er anntall coins[i+1] som trengs for aa overgaa coins[i]
			mul = (coins[i] // coins[i+1]) + 1
			difference = coins[i+1]*(mul)-coins[i]
			checkamounts.append((difference,mul))
	
	for amount in checkamounts:
		i = 0
		ant_mynt = 0
		while amount[0] > 0:
			while amount[0] < coins[i]:
				i += 1
			mul = amount[0] // coins[i]
			amount = (amount[0] - (coins[i] * mul) ,amount[1])
			ant_mynt += mul
		if ant_mynt >= amount[1]:
			return False
	return True

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

