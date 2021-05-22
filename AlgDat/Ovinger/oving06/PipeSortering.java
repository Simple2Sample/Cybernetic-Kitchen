import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.StringTokenizer;
import java.io.FileNotFoundException;
import java.io.FileReader;


public class PipeSortering{

	public static void sorter(int[] liste){
		// START IKKE-UTDELT KODE
		for(int i=0;i<liste.length-1;i++){
			int minste= i;
			for(int j=i+1;j<liste.length;j++){
				if(liste[j]<liste[minste]) minste=j;
			}
			int mellomlagring= liste[i];
			liste[i]=liste[minste];
			liste[minste]=mellomlagring;
		}
		// SLUTT IKKE-UTDELT KODE
	}
	
	public static int[] finnMinMax(int[] sortert, int min, int max){
		// START IKKE-UTDELT KODE
		int ret[] = new int[2];
		ret[0]=binsok(sortert, min);
		ret[1]=binsok(sortert, max);
		if(sortert[ret[0]]>min)
            ret[0]--;
		if(sortert[ret[1]]<max)
            ret[1]++;
        int[] toReturn = {sortert[ret[0]<0?0:ret[0]],sortert[ret[1]==sortert.length?ret[1]-1:ret[1]]};
        return toReturn;
	}
		
	public static int binsok(int[] tabell, int verdi){	
		int l=0;
		int r=tabell.length-1;
		int m=0;
		while(l<=r){
			m=(int)((r+l)/2);
			if(tabell[m]==verdi) break;
			else if(verdi < tabell[m]) r = m - 1;
			else l = m + 1;
		}
		return m;
		// SLUTT IKKE-UTDELT KODE
	}

	public static void main(String args[]){
		try{
			BufferedReader in;
        		if (args.length > 0) {
				try {
					in = new BufferedReader(new FileReader(args[0]));
				}
				catch (FileNotFoundException e) {
					System.out.println("Kunne ikke åpne filen " + args[0]);
					return;
				}
			}
        		else {
				in = new BufferedReader(new InputStreamReader(System.in));
			}
			StringTokenizer st = new StringTokenizer(in.readLine());
			int numTokens=st.countTokens();
			int liste[] = new int[numTokens];
			for(int i=0;i<numTokens;i++){
				liste[i]=Integer.parseInt(st.nextToken());
			}
			sorter(liste);
			String linje = in.readLine();
			while(linje!=null){
				st = new StringTokenizer(linje);
				int[] ret = finnMinMax(liste, Integer.parseInt(st.nextToken()), Integer.parseInt(st.nextToken()));
				linje = in.readLine();
				System.out.println(ret[0]+" "+ret[1]);
			}
			
			
		}
                catch (Exception e) {
			e.printStackTrace();
		}
	}

}
