import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.FileReader;
import java.util.StringTokenizer;
import java.util.ArrayList;
import java.math.BigDecimal;

public class Prinsessejakt{

    public static BigDecimal subgraftetthet(boolean[][] nabomatrise, 
                                                int startnode){
        //START IKKE-UTDELT KODE
        int n = nabomatrise.length;
        int i=0,j=0, antallNoderMed=n-1;
        boolean[] med = new boolean[n];
        for(i=0;i<n;i++) med[i]=true;
        ArrayList<Integer> ko = new ArrayList<Integer>();
        med[startnode]=false;
        ko.add(new Integer(startnode));
        //Vil ikke remove fra ArrayList fordi det er sykt treigt.
        int currentIndex=0;
        while(currentIndex!=ko.size()){
            int currentNode = ((Integer)ko.get(currentIndex++)).intValue();
            for(j=0;j<n;j++){
                if(nabomatrise[currentNode][j] && med[j]){
                    med[j]=false;
                    antallNoderMed--;
                    ko.add(new Integer(j));
                }
            }
        }
        if(antallNoderMed==0) return new BigDecimal(0).setScale(3, 
                        BigDecimal.ROUND_HALF_UP);
        int antallKanter=0;
        for(i=0;i<n;i++){
            if(med[i]){
                for(j=0;j<n;j++){
                    if(nabomatrise[i][j] && med[j]) antallKanter++;
                }
            }
        }
        //SLUTT IKKE-UTDELT KODE
        return new BigDecimal(antallKanter).divide(
                        new BigDecimal(antallNoderMed*antallNoderMed),
                        3, BigDecimal.ROUND_HALF_UP);
    }


    public static void main(String[]  args) {
        try {
            BufferedReader in;
            if(args.length>0){
                in = new BufferedReader(new FileReader(args[0]));
            }
            else{
                in= new BufferedReader(new InputStreamReader(System.in));
            }
            int n = Integer.parseInt(in.readLine());    
            boolean[][] nabomatrise = new boolean[n][n];
            String naboRad;
            for(int i=0;i<n;i++){
                naboRad=in.readLine();
                for(int j=0;j<n;j++) 
                    if(naboRad.charAt(j)=='1')nabomatrise[i][j]=true;
            }
            String linje = in.readLine();
            while(linje!=null && linje.length()>0){
                int startnode= Integer.parseInt(linje);
                System.out.println(subgraftetthet(nabomatrise, startnode));                                                        
                linje=in.readLine();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
