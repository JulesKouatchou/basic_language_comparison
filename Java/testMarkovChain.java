// import java.util.Scanner;
import java.io.*;
import java.util.concurrent.*;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Random;
import java.lang.*;

class testMarkovChain {

    public static void main (String[] args) {

        long startTime;
        long estimatedTime;
        int n;

        // create instance of Random class
        Random rand = new Random();

        if (args.length > 0) {
            try {
                n = Integer.parseInt(args[0]);
            } catch (NumberFormatException e) {
                System.err.println("Argument" + args[0] + " must be an integer.");
                System.exit(1);
            }
        }

        n = Integer.parseInt(args[0]);

        System.out.println("Perform Markov Chain calculations: "+n);

        double x[]   = new double[2];
        double x2[]  = new double[2];

        double p1 = 0;
        double p2 = 0;

        startTime = System.currentTimeMillis();

        x[0] = 0;
        x[1] = 0;

        p1 = Math.exp(Math.sin(5*x[0]) - x[0]*x[0] - x[1]*x[1]);

        for (int k=0;k<n;k++) {
            x2[0] = x[0] + 0.01*rand.nextGaussian();
            x2[1] = x[1] + 0.01*rand.nextGaussian();

            p2 = Math.exp(Math.sin(5*x2[0]) - x2[0]*x2[0] - x2[1]*x2[1]);

            if (rand.nextDouble() < (p2/p1)) {
               x[0] = x2[0];
               x[1] = x2[1];
               p1   = p2;
            }

        }

        estimatedTime = System.currentTimeMillis() - startTime;
        NumberFormat formatter = new DecimalFormat("#00000.00000000");
        System.out.println("    Time: " + formatter.format(estimatedTime  / 1000d) + " seconds");
    }
}
