import java.util.Scanner;
import java.io.*;
import java.util.concurrent.*;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.lang.Math;

class testMunchausenNumber {

    static final long[] power_of_digits = new long[10];

    public static void main (String args[]) {
        int n;
        long i;
        long a;
        long b;
        long startTime;
        long estimatedTime;

        NumberFormat formatter = new DecimalFormat("#00000.00000000");

        System.out.println("Munchausen numbers: ");

        startTime = System.nanoTime();

        for (int k = 1; k < 10; k++) {
            power_of_digits[k] = (long) Math.pow(k, k);
        }

        i = 0L;
        n = 0;
        while (n < 4) {
              if (is_munchhausen_number(i)) {
                 n++;
                 System.out.println("Munchausen number "+n+": "+ i);
              }
              i++;
        }
        estimatedTime = System.nanoTime() - startTime;
        System.out.println("  Time for Munchausen numbers: " + formatter.format(estimatedTime  / 1000000000d) + " seconds");

    }

    private static boolean is_munchhausen_number(long n) {
        long sum = 0, nn = n;
        do {
            sum += power_of_digits[(int)(nn % 10)];
            if (sum > n) {
                return false;
            }
            nn /= 10;
        } while (nn > 0);
 
        return sum == n;
    }
}
