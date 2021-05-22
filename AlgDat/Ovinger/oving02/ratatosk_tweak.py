# orginal skrevet av Njaal Kaarevoll
# edit (kommentarer/refaktorering) av Eirik Reksten 01.09.06

from sys import stdin

def main():
    
    # Vi trenger ikke de to foerste linjene:
    stdin.readline()
    stdin.readline()
    
    # Henter ut rotnoden og ratatosks plassering
    rotnode = stdin.readline().strip()
    ratatosk = stdin.readline().strip()
    
    # Dictionary (hashtabell) med nodenes foreldre
    foreldre = {}
    
    # Teller for aa finne hoyden ratatosk befant seg på
    nivaa = 0
    
    # Mens vi leser inn treet, lar vi ratatosk klatre oppover så snart han faar sjansen.
    for linje in stdin:
        barn_liste = linje.split()
        far = barn_liste.pop(0)
        for barn in barn_liste:
            foreldre[barn] = far
    
        # Dersom noden ratatosk befant seg paa har faatt en forelder, klatrer ratatosk opp til denne,
        # og vi inkrementerer nivaaet.
        while ratatosk in foreldre:
            ratatosk = foreldre[ratatosk]
            nivaa+=1
        
        # Dersom ratatosk har kommet til roten, skriver vi ut nivaaet og avslutter algoritmen.
        if ratatosk == rotnode :
            print nivaa
            return

main()
