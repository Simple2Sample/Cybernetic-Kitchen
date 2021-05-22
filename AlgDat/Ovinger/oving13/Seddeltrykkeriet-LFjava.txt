import java.io.BufferedReader;
import java.io.FileReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.StringTokenizer;

public class Seddeltrykkeriet {
    public static int maxValue(ArrayList<Integer> widths, ArrayList<Integer> heights, ArrayList<Integer> values, int paperWidth, int paperHeight) {
        // START IKKE-UTDELT KODE
        int [][] result;
        int w, h, a;
        int minSize = 1000000000;
        int best;
        int cutWidth, cutHeight;
        
        result = new int[paperWidth + 1][paperHeight + 1];
        for (w = 0; w < paperWidth + 1; ++ w)
            for (h = 0; h < paperHeight + 1; ++ h)
                result[w][h] = -1;
        
        for (w = 0; w < widths.size(); ++ w)
            if (w < minSize)
                minSize = w;
        for (h = 0; h < heights.size(); ++ h)
            if (h < minSize)
                minSize = h;
        
        for (a = 0; a < minSize; ++ a) {
            for (w = 0; w < widths.size(); ++ w)
                result[w][a] = 0;
            for (h = 0; h < heights.size(); ++ h)
                result[a][h] = 0;
        }
        
        for (a = 0; a < values.size(); ++ a) {
            if (widths.get(a) <= paperWidth && heights.get(a) <= paperHeight && result[widths.get(a)][heights.get(a)] < values.get(a))
                result[widths.get(a)][heights.get(a)] = values.get(a);
            if (heights.get(a) <= paperWidth && widths.get(a) <= paperHeight && result[heights.get(a)][widths.get(a)] < values.get(a))
                result[heights.get(a)][widths.get(a)] = values.get(a);
        }
        
        for (w = 0; w < paperWidth + 1; ++ w) {
            for (h = 0; h < paperHeight + 1; ++ h) {
                if (result[w][h] == 0)
                    continue;
                if (result[w][h] == -1)
                    best = 0;
                else
                    best = result[w][h];
                for (cutWidth = 1; cutWidth < w; ++ cutWidth)
                    if (best < result[cutWidth][h] + result[w - cutWidth][h])
                        best = result[cutWidth][h] + result[w - cutWidth][h];
                for (cutHeight = 1; cutHeight < h; ++ cutHeight)
                    if (best < result[w][cutHeight] + result[w][h - cutHeight])
                        best = result[w][cutHeight] + result[w][h - cutHeight];
                result[w][h] = best;
            }
        }
        return result[paperWidth][paperHeight];
        // SLUTT IKKE-UTDELT KODE
    }
    
    public static void main(String[] args) {
        try {
            BufferedReader in;
            StringTokenizer st;
            String line;
            ArrayList<Integer> widths;
            ArrayList<Integer> heights;
            ArrayList<Integer> values;
            String [] sheet;
            
            if (args.length > 0)
                in = new BufferedReader(new FileReader(args[0]));
            else
                in = new BufferedReader(new InputStreamReader(System.in));
            
            line = in.readLine();
            st = new StringTokenizer(line);
            
            widths = new ArrayList<Integer>();
            heights = new ArrayList<Integer>();
            values = new ArrayList<Integer>();

            while (st.hasMoreTokens()) {
                String triple = st.nextToken();
                int xIndex = triple.indexOf("x");
                int closeParenIndex = triple.indexOf(")");
                widths.add(new Integer(triple.substring(1,xIndex)));
                heights.add(new Integer(triple.substring(xIndex+1, closeParenIndex)));
                values.add(new Integer(triple.substring(closeParenIndex+2)));
            }

            line = in.readLine();
            while (line != null) {
                sheet = line.split("x");
                System.out.println("" + maxValue(widths, heights, values, Integer.parseInt(sheet[0]), Integer.parseInt(sheet[1])));
                line = in.readLine();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

