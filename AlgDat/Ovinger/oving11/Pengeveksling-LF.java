import java.util.*;
import java.io.*;
import java.lang.Math.*;

public class Pengeveksling{

	public static int minMynterGraadig(ArrayList mynter, int verdi){
		// START IKKE-UTDELT KODE
		int aktuellMynt=0;
		int antallMynter=0;
		while(verdi>0){
			if(((Integer)mynter.get(aktuellMynt)).intValue()>verdi){
				aktuellMynt+=1;
			}
			else{
				verdi -= ((Integer)mynter.get(aktuellMynt)).intValue();
				antallMynter+=1;
			}
		}
		return antallMynter;
		// SLUTT IKKE-UTDELT KODE
	}

	public static int minMynterDynamisk(ArrayList mynter, int verdi){
	   // START IKKE-UTDELT KODE
	   int[] resultat = new int[verdi+1];
	   for (int i = 0; i < resultat.length; i ++)
	           resultat[i] = Integer.MAX_VALUE;

	   ArrayList brukbareMynter=new ArrayList();
	   for (int i = 0; i < mynter.size(); i ++) {
	           int myntverdi = ((Integer)mynter.get(i)).intValue();
	           if (myntverdi <= verdi) {
	                   resultat[myntverdi]=1;
	                   brukbareMynter.add(mynter.get(i));
	           }
	   }

	   for (int denneVerdi = 1; denneVerdi < verdi + 1; denneVerdi ++) {
	           if (resultat[denneVerdi] == Integer.MAX_VALUE) {
	                   int besteResultat = Integer.MAX_VALUE;
	                   for (int mynt = 0; mynt < brukbareMynter.size(); mynt ++) {
	                           int myntverdi = ((Integer)brukbareMynter.get(mynt)).intValue();
	                           if(myntverdi <= denneVerdi){
	                                   int detteResultat = 1 + resultat[denneVerdi - myntverdi];
	                                   if(detteResultat < besteResultat)
	                                           besteResultat = detteResultat;
	                           }
	                   }
	                   resultat[denneVerdi] = besteResultat;
	           }
	   }

	   return resultat[verdi];
	   // SLUTT IKKE-UTDELT KODE
	}


	public static boolean kanBrukeGraadig(ArrayList mynter){
		// Hvis du ikke finner ut hva som er kriteriet for at den grådige
		// algoritmen skal fungere, returner false.

		// START IKKE-UTDELT KODE
		for(int i=0; i<mynter.size()-1; i++){
			if(((Integer)mynter.get(i+1)).intValue()*2>((Integer)mynter.get(i)).intValue()){
				return false;
			}
		}
		return true;
		// SLUTT IKKE-UTDELT KODE
	}



	public static void main(String args[]) throws Exception{
		ArrayList mynter = new ArrayList();

		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));

		String linje = in.readLine();
		StringTokenizer st = new StringTokenizer(linje);
		while(st.hasMoreTokens()){
			mynter.add(Integer.parseInt(st.nextToken()));
		}
		Collections.sort(mynter, Collections.reverseOrder());

		String metode=in.readLine();

		if(metode.equals("graadig")){
			linje=in.readLine();
			while(linje!=null){
				System.out.println(minMynterGraadig(mynter, Integer.parseInt(linje)));
				linje=in.readLine();
			}
		}
		else if(metode.equals("dynamisk")){
			linje=in.readLine();
			while(linje!=null){
				System.out.println(minMynterDynamisk(mynter, Integer.parseInt(linje)));
				linje=in.readLine();
			}
		}
		else{
			if(kanBrukeGraadig(mynter)){
				linje=in.readLine();
				while(linje!=null){
					System.out.println(minMynterGraadig(mynter, Integer.parseInt(linje)));
					linje=in.readLine();
				}
			}
			else{
				linje=in.readLine();
				while(linje!=null){
					System.out.println(minMynterDynamisk(mynter, Integer.parseInt(linje)));
					linje=in.readLine();
				}
			}
		}
	}
}




