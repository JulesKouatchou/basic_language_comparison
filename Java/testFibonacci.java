import java.util.Scanner;
import java.io.*;
import java.util.concurrent.*;
import java.text.DecimalFormat;
import java.text.NumberFormat;

class testFibonacci {

    public static void main (String args[]) {
        int n;
        long a;
        long b;
        long startTime;
        long estimatedTime;

        NumberFormat formatter = new DecimalFormat("#00000.00000000");

        if (args.length > 0) {
            try {
                n = Integer.parseInt(args[0]);
            } catch (NumberFormatException e) {
                System.err.println("Argument" + args[0] + " must be an integer.");
                System.exit(1);
            }
        }

        n = Integer.parseInt(args[0]);

        System.out.println("Fibonacci sequence: "+n);
        startTime = System.nanoTime();
        a = itFibN(n);
        estimatedTime = System.nanoTime() - startTime;
        System.out.println("  Time for iterative Fib: " + formatter.format(estimatedTime  / 1000000000d) + " seconds");

        startTime = System.nanoTime();
        b = recFibN(n);
        estimatedTime = System.nanoTime() - startTime;
        System.out.println("  Time for recursive Fib: " + formatter.format(estimatedTime  / 1000000000d) + " seconds");


    }

    // Iterative
    public static long itFibN(int n)
    {
        if (n < 2)
           return n;
        long ans = 0;
        long n1 = 0;
        long n2 = 1;
        for(n--; n > 0; n--)
        {
         ans = n1 + n2;
         n1 = n2;
         n2 = ans;
        }
        return ans;
    }

    // Recursive
    public static long recFibN(final int n)
    {
        return (n < 2) ? n : recFibN(n - 1) + recFibN(n - 2);
    }

}
