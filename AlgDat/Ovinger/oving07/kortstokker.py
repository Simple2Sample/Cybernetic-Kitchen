from sys import stdin
from itertools import repeat

def merge(decks):
    # START IKKE-UTDELT KODE
    while len(decks) > 1:
        s1 = decks.pop(0)
        s2 = decks.pop(0)
        s = []
        while len(s1) > 0 and len(s2) > 0:
            if s1[0] < s2[0]:
                s.append(s1.pop(0))
            else:
                s.append(s2.pop(0))
        s.extend(s1)
        s.extend(s2)
        decks.append(s)
    letters = []
    for (number, letter) in decks[0]:
        letters.append(letter)
    return ''.join(letters)
    # SLUTT IKKE-UTDELT KODE

decks = []
for line in stdin:
    (index, list) = line.split(':')
    deck = zip(map(int, list.split(',')), repeat(index))
    decks.append(deck)
print merge(decks)
