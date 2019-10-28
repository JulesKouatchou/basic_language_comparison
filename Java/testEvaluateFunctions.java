// import java.util.Scanner;
import java.io.*;
import java.util.concurrent.*;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Random;

class testEvaluateFunctions {

    public static void main (String[] args) {

        long startTime;
        long estimatedTime;
        int num_iterations = 10000;
        double a_min = -1500.0;
        double a_max =  1500.0;
        double h;
        int n;

        // create a scanner so we can read the command-line input
        //Scanner scanner = new Scanner(System.in);

        if (args.length > 0) {
            try {
                n = Integer.parseInt(args[0]);
            } catch (NumberFormatException e) {
                System.err.println("Argument" + args[0] + " must be an integer.");
                System.exit(1);
            }
        }

        n = Integer.parseInt(args[0]);

        System.out.println("Evaluate Functions: "+n);

        startTime = System.currentTimeMillis();

        double x[]=new double[n];
        double y[]=new double[n];

        h = (a_max - a_min)/(n-1);

        for (int i=0;i<n;i++) {
                    x[i] = a_min + i*h;
        }

        for (int i=0;i<num_iterations;i++) {
            for (int j=0;j<n;j++) {
                y[j] = Math.sin(x[j]);
                x[j] = Math.asin(y[j]);
                y[j] = Math.cos(x[j]);
                x[j] = Math.acos(y[j]);
                y[j] = Math.tan(x[j]);
                x[j] = Math.atan(y[j]);
            }
        }

        estimatedTime = System.currentTimeMillis() - startTime;
        NumberFormat formatter = new DecimalFormat("#00000.00000000");
        System.out.println("    Time Evaluate Functions: " + formatter.format(estimatedTime  / 1000d) + " seconds");

    }

}

