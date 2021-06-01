import java.io.BufferedReader;
import java.io.FileReader;
import java.io.InputStreamReader;
import java.util.StringTokenizer;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.LinkedList;
import java.math.MathContext;

public class Mumien{

	public static String besteSti(int[][] nabomatrise, ArrayList<Float> sannsynligheter){
		//START IKKE-UTDELT KODE
		int n = nabomatrise.length;
			//n betegner her antall noder, altså |V|. Dette er en implemntasjon av 
			//Dijkstras algoritme på O(n^2).
		boolean[] ferdig = new boolean[n];
		int[] forrige = new int[n];
		ArrayList<Float> kumulativSannsynlighet= new ArrayList<Float>();
		kumulativSannsynlighet.add(sannsynligheter.get(0));
		for(int i=1;i<n;i++)kumulativSannsynlighet.add(new Float(0.0));
		int besteNode =0;
		//Vi vet vi maksimalt skal holde på til vi har funnet n noder.
		for(int i=0;i<n;i++){
			int node = besteNode;
			//Hvis den vi plukker ut som den det er kortest vei til som er uoppdaget er den vi leter etter returnerer vi.
            if(kumulativSannsynlighet.get(node) == 0.0){
                return "0";
            }
			if(node==n-1){
				return foelg_sti(forrige);
            }
			//Vi setter at vi har oppdaget den noden vi nå har valgt ut.
			ferdig[node]=true;
			Float hoyesteKSanns=new Float(-1.0);
			for(int j=0;j<n;j++){
				if(!ferdig[j]){
					//Finnes det en vei til node j?
					if(nabomatrise[node][j]==1){
						//Hvis det er tilfelle sjekker vi her om denne veien er bedre enn den vi har funnet, i tilfelle oppdaterer vi.
						Float tilbud = kumulativSannsynlighet.get(node) * sannsynligheter.get(j);
						if(tilbud.compareTo(kumulativSannsynlighet.get(j))>0){
							forrige[j] = node;
							kumulativSannsynlighet.set(j,tilbud);
						}
					}
					//Hvis dette er den høyeste kumulative sannsynligheten for å komme til et rom vi har funnet setter vi dette her, slik at denne muligens
					//blir valgt ut i neste runde.
					if(kumulativSannsynlighet.get(j).compareTo(hoyesteKSanns)>0){
						hoyesteKSanns= kumulativSannsynlighet.get(j);
						besteNode=j;
					}
				}
			}
		}
		return "0";
	}

	public static String foelg_sti(int[] forgjengere){
		LinkedList<Integer> sti = new LinkedList<Integer>();
		Integer naavaerende_node = forgjengere.length - 1;
		while(naavaerende_node != 0){
			sti.addFirst(naavaerende_node);
			naavaerende_node = forgjengere[naavaerende_node];
		}
		StringBuilder resultat = new StringBuilder(forgjengere.length * 2);
		resultat.append("0");
		for(int node: sti){
			resultat.append("-");
			resultat.append(node);
		}
		return resultat.toString();
		//SLUTT IKKE-UTDELT KODE
	}

	public static void main(String[]  args){
		try{
			BufferedReader in=null;
			if(args.length>0)
				in = new BufferedReader(new FileReader(args[0]));
			else
				in = new BufferedReader(new InputStreamReader(System.in));
			int n = Integer.parseInt(in.readLine());
			ArrayList<Float> sannsynligheter = new ArrayList<Float>();
			int[][] nabomatrise = new int[n][n];
			StringTokenizer st = new StringTokenizer(in.readLine());
			int i =0,j=0;
			while(st.hasMoreTokens())sannsynligheter.add(new Float(st.nextToken()));
			for(i=0;i<n;i++){
				st = new StringTokenizer(in.readLine());
				while(st.hasMoreTokens()){
					nabomatrise[i][Integer.parseInt(st.nextToken())]=1;
				}
			}
			System.out.println(besteSti(nabomatrise, sannsynligheter));
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
}
