# Takk til Halvor Sakshaug for Lure Triks (tm)
# (bruk av radix sort med siffergrupper bestaaende av 11 bits).

from sys import stdin

def merge():
     bits_per_gruppe = 11
     bits_brukt = 0
     maksverdi = 0
     siffergruppe_verdier = 1 << bits_per_gruppe
     siffergruppe_maks = siffergruppe_verdier-1
     siffer = [[] for i in xrange(siffergruppe_verdier)]
     for linje in stdin:
          (bokstav, linje_med_tall) = linje.split(':')
          for tall in map(int, linje_med_tall.split(',')):
               if (tall > maksverdi):
                   maksverdi = tall
               siffer[tall & siffergruppe_maks].append((tall, bokstav))
     while(maksverdi > siffergruppe_verdier):
          maksverdi >>= bits_per_gruppe
          bits_brukt += bits_per_gruppe
          a = siffer
          siffer = [[] for i in xrange(siffergruppe_verdier)]
          # Foelgende plasserer noen tupler i siffer[0], disse staar da bakerst og er sortert
          for aa in a:
               for p in aa:
                    siffer[(p[0] >> bits_brukt) & siffergruppe_maks].append(p)
     
     print ''.join([''.join([d[1] for d in c]) for c in siffer])

merge()
