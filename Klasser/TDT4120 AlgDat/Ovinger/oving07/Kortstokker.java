import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.FileReader;
import java.util.StringTokenizer;
import java.util.ArrayList;

public class Kortstokker{

	public static int INF = Integer.MAX_VALUE;
	
	public static String flett(ArrayList kortstokker){
		//START IKKE-UTDELT KODE
		ArrayList sortert;
		while(kortstokker.size()>1){
			ArrayList kortstokk1 = (ArrayList)kortstokker.remove(0);
			ArrayList kortstokk2= (ArrayList)kortstokker.remove(0);
			sortert = new ArrayList();
			while(!kortstokk1.isEmpty() && !kortstokk2.isEmpty()){
				if(((Kort)kortstokk1.get(0)).verdi<((Kort)kortstokk2.get(0)).verdi) sortert.add((Kort)kortstokk1.remove(0));
				else sortert.add((Kort)kortstokk2.remove(0));
			}
			if(kortstokk1.isEmpty()) sortert.addAll(kortstokk2);
			else sortert.addAll(kortstokk1);
			kortstokker.add(sortert);
		}
		sortert = (ArrayList)kortstokker.get(0);
		StringBuffer sb = new StringBuffer();
		for(int i=0;i<sortert.size();i++) sb.append(((Kort)sortert.get(i)).bokstav);
		return sb.toString();
		//SLUTT IKKE-UTDELT KODE
	}


	public static void main(String[]  args){
		try{
			BufferedReader in;
                        if(args.length>0) in = new BufferedReader(new FileReader(args[0]));
                        else in= new BufferedReader(new InputStreamReader(System.in));
			ArrayList kortstokker = new ArrayList();
			String input=in.readLine();
			char kortstokkBokstav;
			while(input!=null){
				kortstokkBokstav = input.charAt(0);
				StringTokenizer st = new StringTokenizer(input.substring(2),",");
				ArrayList enKortstokk = new ArrayList();
				while(st.hasMoreTokens()){
					enKortstokk.add(new Kort(Integer.parseInt(st.nextToken()), kortstokkBokstav));
				}
				kortstokker.add(enKortstokk);
				input = in.readLine();
			}
			System.out.println(""+flett(kortstokker));
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
}

class Kort{
	public int verdi;
	public char bokstav;

	public Kort(int verdi, char bokstav){
		this.verdi=verdi;
		this.bokstav=bokstav;
	}
}

