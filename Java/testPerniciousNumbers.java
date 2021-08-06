// import java.util.Scanner;
import java.io.*;
import java.util.concurrent.*;
import java.text.DecimalFormat;
import java.text.NumberFormat;

public class testPerniciousNumbers{
    //very simple isPrime since x will be <= Long.SIZE
    public static boolean isPrime(int x){
        if(x < 2) return false;
        for(int i = 2; i < x; i++){
            if(x % i == 0) return false;
        }
        return true;
    }
 
    public static int popCount(long x){
        return Long.bitCount(x);
    }
 
    public static void main(String[] args){

        long startTime;
        long estimatedTime;
        int max_num;

        if (args.length > 0) {
            try {
                max_num = Integer.parseInt(args[0]);
            } catch (NumberFormatException e) {
                System.err.println("Argument" + args[0] + " must be an integer.");
                System.exit(1);
            }
        }

        max_num = Integer.parseInt(args[0]);

        System.out.println("Pernicious number: "+max_num);

        startTime = System.currentTimeMillis();

        for(long i = 1, n = 0; n < max_num; i++){
            if(isPrime(popCount(i))){
                // System.out.print(i + " ");
                n++;
            }
        }

        estimatedTime = System.currentTimeMillis() - startTime;
        NumberFormat formatter = new DecimalFormat("#00000.00000000");
        System.out.println("    Pernicious number: " + formatter.format(estimatedTime  / 1000d) + " seconds");
 
    }
}
