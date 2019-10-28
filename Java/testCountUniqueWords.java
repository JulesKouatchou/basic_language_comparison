import java.util.*;
import java.io.*;
import java.util.concurrent.*;
import java.text.DecimalFormat;
import java.text.NumberFormat;

public class testCountUniqueWords {

    public static void main(String args[]) throws FileNotFoundException { 

        long startTime;
        long estimatedTime;
        
        NumberFormat formatter = new DecimalFormat("#00000.00000000");

        String filename = args[0];

        System.out.println("Looking for the number of unique words in "+ filename);

        startTime = System.nanoTime();

        File f = new File(filename);
        ArrayList arr=new ArrayList();
        HashMap<String, Integer> listOfWords = new HashMap<String, Integer>(); 
        Scanner in = new Scanner(f);
        int i=0;
        while(in.hasNext())
        {
            String s=in.next();
            //System.out.println(s);
            arr.add(s.replaceAll("[^a-zA-Z]", "").toLowerCase());
            // arr.add(s);
        }
        Iterator itr=arr.iterator();
        while(itr.hasNext())
        {
            i++;

            listOfWords.put((String) itr.next(), i);
            //System.out.println(listOfWords);    //for Printing the words 
         }

        Set<Object> uniqueValues = new HashSet<Object>(listOfWords.values()); 

        System.out.println("The number of unique words: "+uniqueValues.size());
        estimatedTime = System.nanoTime() - startTime;
        System.out.println("  Time: " + formatter.format(estimatedTime  / 1000000000d) + " seconds");

        
    }
}
