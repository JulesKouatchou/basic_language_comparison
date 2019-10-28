// import java.util.Scanner;
import java.io.*;
import java.util.concurrent.*;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Random;
import java.lang.*;

class testBeliefPropagation {

    public static void main (String[] args) {

        long startTime;
        long estimatedTime;
        int n;
        int dim = 5000;

        // create a scanner so we can read the command-line input
        //Scanner scanner = new Scanner(System.in);

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

        System.out.println("Belief Propagation: "+n);

        double A[][] = new double[dim][dim];
        double x[]   = new double[dim];
        double x2[]  = new double[dim];

        double mysum  = 0;
        double mynorm = 0;

        startTime = System.currentTimeMillis();

        for (int i=0;i<dim;i++) {
            for (int j=0;j<dim;j++) {
                A[i][j] = rand.nextDouble();
            }
        }

        for (int k=0;k<n;k++) {
            for (int i=0;i<dim;i++) {
                x2[i] = 0;
                for (int j=0;j<dim;j++) {
                    x2[i] = x2[i] + A[i][j]*Math.exp(x[j]);
                }
            }

            for (int i=0;i<dim;i++) {
                x[i] = Math.log(x2[i]);
            }

            mysum = 0;
            for (int i=0;i<dim;i++) {
                mysum = mysum + Math.exp(x[i]);
            }

            mynorm = Math.log(mysum);
            for (int i=0;i<dim;i++) {
                x[i] = x[i] - mynorm;
            }

        }

        estimatedTime = System.currentTimeMillis() - startTime;
        NumberFormat formatter = new DecimalFormat("#00000.00000000");
        System.out.println("    Time: " + formatter.format(estimatedTime  / 1000d) + " seconds");
    }
}

