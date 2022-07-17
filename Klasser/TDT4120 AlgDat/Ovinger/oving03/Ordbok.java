import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.StringTokenizer;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

public class Ordbok{

    public static Node bygg(String[] ordliste){
        // START IKKE-UTDELT KODE
        Node rotNode = new Node();
        int currentPos=0;
        for(int i=0;i<ordliste.length;i++){
            Node currentNode = rotNode;
            for(int j=0;j<ordliste[i].length();j++){
                if(!currentNode.barn.containsKey(String.valueOf(ordliste[i].charAt(j)))) currentNode.barn.put(String.valueOf(ordliste[i].charAt(j)), new Node());
                currentNode=(Node)currentNode.barn.get(String.valueOf(ordliste[i].charAt(j)));
            }
            currentNode.posisjoner.add(new Integer(currentPos));
            currentPos+=ordliste[i].length()+1;
        }
        return rotNode;
        // SLUTT IKKE-UTDELT KODE
    }

    public static ArrayList posisjoner(String ord, int index, Node currentNode){
        // START IKKE-UTDELT KODE
        if(index>=ord.length()) return currentNode.posisjoner;
        else if(ord.charAt(index)=='?'){
            ArrayList ret = new ArrayList();
            Iterator it=currentNode.barn.keySet().iterator();
            while(it.hasNext()){
                ret.addAll(posisjoner(ord, index+1, (Node)currentNode.barn.get((String)it.next())));
            }
            return ret;
        }
        else if(currentNode.barn.containsKey(String.valueOf(ord.charAt(index)))) return posisjoner(ord, index+1, (Node)currentNode.barn.get(String.valueOf(ord.charAt(index))));
        else return new ArrayList();
        // SLUTT IKKE-UTDELT KODE
    }


    public static void main(String[]  args){
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
            String[] ord = new String[st.countTokens()];
            int i=0;
            while(st.hasMoreTokens()) ord[i++]=st.nextToken();
            Node rotNode = bygg(ord);
            String sokeord= in.readLine();
            while(sokeord!=null){
                sokeord=sokeord.trim();
                System.out.print(sokeord+":");
                ArrayList pos = posisjoner(sokeord, 0, rotNode);
                int[] posi = new int[pos.size()];
                for(i=0;i<posi.length;i++)posi[i]=((Integer)pos.get(i)).intValue();
                Arrays.sort(posi);
                for(i=0;i<posi.length;i++) System.out.print(" "+posi[i]);
                System.out.println();
                sokeord=in.readLine();
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }
}

class Node{
    public ArrayList posisjoner;
    public HashMap barn;

    public Node(){
        posisjoner=new ArrayList();
        barn=new HashMap();
    }
}
