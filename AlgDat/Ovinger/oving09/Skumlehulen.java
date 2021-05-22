import java.util.*;
import java.io.*;

public class Skumlehulen {

    public static String antallIsolerteStier(int[][] naboMatrise, 
                                             int[] startRom, 
                                             int[] utganger) {
        // START IKKE-UTDELT KODE
        int[][] utvidetNM = utvid(naboMatrise, startRom, utganger);
        int antNoder = utvidetNM.length;
        int SUPERKILDE = 0;
        int SUPERSLUK = antNoder - 1;
        int[][] flyt = new int[antNoder][antNoder];
        int[][] kapasitet = new int[antNoder][antNoder];
        for (int i = 0; i < antNoder; i++) {
            for (int j = 0; j < antNoder; j++) {
                kapasitet[i][j] = utvidetNM[i][j];
            }
        }
        int[] augPath = 
                finnAugmentingPath(SUPERKILDE, SUPERSLUK, flyt, kapasitet);
        while (augPath != null) {
            for (int i = 0; i < augPath.length - 1; i++) {
                flyt[augPath[i]][augPath[i + 1]] += 1;
                flyt[augPath[i + 1]][augPath[i]] -= 1;
            }
            flyt[SUPERKILDE][SUPERSLUK] += 1;
            augPath = finnAugmentingPath(SUPERKILDE, SUPERSLUK, flyt, kapasitet);
        }
        return new Integer(flyt[SUPERKILDE][SUPERSLUK]).toString();
        // SLUTT IKKE-UTDELT KODE
    }

    // START IKKE-UTDELT KODE
    private static int[][] utvid(int[][] naboMatrise, int[] startRom,
                                 int[] utganger) {
        int numRom = (naboMatrise.length + 2) << 1;
        int[][] unm = new int[numRom][numRom];
        // flytt inn i utvidet matrise
        for (int r = 3; r < numRom - 2; r += 2) {
            for (int c = 2; c < numRom - 2; c += 2) {
                int i = naboMatrise[(r >> 1) - 1][(c >> 1) - 1];
                unm[r][c] = i;
            }
        }

        // lag vei mellom parnoder
        for (int a = 0; a < numRom; a += 2) {
            unm[a][a + 1] = 1;
        }

        // lag veier fra source til startRom
        for (int a = 0; a < startRom.length; a++) {
            unm[1][(startRom[a] << 1) + 2] = 1;
        }

        // lag veier fra utganger til sink
        for (int a = 0; a < utganger.length; a++) {
            unm[(utganger[a] << 1) + 3][numRom - 2] = 1;
        }

        // unlimited internal on source and sink
        unm[0][1] = startRom.length;
        unm[numRom - 2][numRom - 1] = utganger.length;

        return unm;
    }

    // SLUTT IKKE-UTDELT KODE: Det kan vaere lurt med en hjelpefunksjon for aa lette oversikten


    // Finn augmenting path vha. breddefoerst-soek.
    // Max-flyt algoritmen kalles da egentlig Edmonds-Karp.
    public static int[] finnAugmentingPath(int kilde, int sluk, int[][] flyt,
                                           int[][] kapasitet) {
        boolean[]erOppdaga = new boolean[flyt.length];
        ArrayList<Integer> BFko = new ArrayList<Integer>();
        BFko.add(new Integer(kilde));
        int denne;
        int[] parent = new int[flyt.length];
        int[] dybde = new int[flyt.length];
        while (!BFko.isEmpty()) {
            denne = BFko.remove(0).intValue();
            for (int i = 0; i < flyt.length; i++) {
                if ((!erOppdaga[i]) && (flyt[denne][i] < kapasitet[denne][i])) {
                    BFko.add(new Integer(i));
                    erOppdaga[i] = true;
                    parent[i] = denne;
                    dybde[i] = dybde[denne] + 1;
                    if (i == sluk) {
                        int[] noder = new int[dybde[sluk] + 1];
                        int paaSti = i;
                        for (int j = dybde[sluk]; j >= 0; j--) {
                            noder[j] = paaSti;
                            paaSti = parent[paaSti];
                        }
                        return noder;
                    }
                }
            }
        }
        return null;
    }

    public static void main(String args[]) throws Exception {
        Scanner sc = null;
        if(args.length>0) sc = new Scanner(new FileReader(args[0]));
        else sc = new Scanner(System.in);
        int antNoder = sc.nextInt();
        int antStart = sc.nextInt();
        int antUtg = sc.nextInt();
        int[][] kapasitet = new int[antNoder][antNoder];
        int[] startRom = new int[antStart];
        int[] utganger = new int[antUtg];
        for (int j = 0; j < antStart; j++) {
            startRom[j] = sc.nextInt();
        }
        for (int j = 0; j < antUtg; j++) {
            utganger[j] = sc.nextInt();
        }
        for (int i = 0; i < antNoder; i++) {
            for (int j = 0; j < antNoder; j++) {
                kapasitet[i][j] = sc.nextInt();
            }
        }
        System.out.println(antallIsolerteStier(kapasitet, startRom, utganger));
    }
}
