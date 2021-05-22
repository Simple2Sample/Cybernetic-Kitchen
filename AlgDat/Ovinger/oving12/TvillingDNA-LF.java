import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Arrays;

public class TvillingDNA{

	public static int avstand(String s1, String s2){
		//START IKKE-UTDELT KODE
		int n1 = s1.length();
		int n2 = s2.length();
		int bytt=0, settinn=0, slett=0;
		int[][] avstand = new int[n1][n2];
		for(int i=0;i<n1;i++)avstand[i][0]=i;
		for(int i=1;i<n2;i++)avstand[0][i]=i;
		for(int i=1;i<n1;i++){
			for(int j=1;j<n2;j++){
				bytt=avstand[i-1][j-1];
				slett=avstand[i-1][j]+1;
				settinn=avstand[i][j-1]+1;
				if(s1.charAt(i)!=s2.charAt(j)) bytt++;
				avstand[i][j]=Math.min(Math.min(slett, settinn),bytt);
			}
		}
		return avstand[n1-1][n2-1];
		//SLUTT IKKE-UTDELT KODE
	}

	public static int minsteAvstand(String[] strenger){
		//START IKKE-UTDELT KODE
		int total_avstand[] = new int[strenger.length];
		for(int i=0;i<strenger.length;i++){
			strenger[i]= " "+strenger[i];
		}
		for(int i=0;i<strenger.length;i++){
			for(int j=0;j<i;j++){
				int a = avstand(strenger[i], strenger[j]);
				total_avstand[i] += a;
				total_avstand[j] += a;
			}
		}
		int minste = total_avstand[0];
		for(int a: total_avstand)
			minste = a < minste? a : minste;
		return minste;
		//SLUTT IKKE-UTDELT KODE
	}

	public static void main(String[] args){
		try{
			BufferedReader in = null;
			if(args.length>0) in = new BufferedReader(new FileReader(args[0]));
			else in = new BufferedReader(new InputStreamReader(System.in));
			String linje = in.readLine();
			ArrayList<String> a = new ArrayList<String>();
			while(linje!=null){
				a.add(linje);
				linje=in.readLine();
			}
			String[] strenger = new String[a.size()];
			for(int i=0;i<a.size();i++){
				strenger[i]=a.get(i);
			}
			System.out.println(""+minsteAvstand(strenger));

		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
}
