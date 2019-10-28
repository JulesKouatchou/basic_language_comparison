import java.util.Scanner;
import java.io.*;
import java.util.concurrent.*;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Random;

class testMatrixMultiplication {

    public static void main (String[] args) {

        long startTime;
        long estimatedTime;
        int n;

        // create a scanner so we can read the command-line input
        Scanner scanner = new Scanner(System.in);

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
        double a[][]=new double[n][n];
        double b[][]=new double[n][n];
        double c[][]=new double[n][n];

        for (int i=0;i<n;i++) {
            for (int j=0;j<n;j++) {
                a[i][j] = rand.nextDouble();
                b[i][j] = rand.nextDouble();
            }
        }

        System.out.println("Matrix Multiplication: "+n);

        startTime = System.currentTimeMillis();
        c = multiply(a, b);
        estimatedTime = System.currentTimeMillis() - startTime;
        NumberFormat formatter = new DecimalFormat("#00000.00000000");
        System.out.println("    Time for matMult: " + formatter.format(estimatedTime  / 1000d) + " seconds");

    }

    // return c = a * b
    public static double[][] multiply(double[][] a, double[][] b) {
        int m1 = a.length;
        int n1 = a[0].length;
        int m2 = b.length;
        int n2 = b[0].length;
        if (n1 != m2) throw new RuntimeException("Illegal matrix dimensions.");
        double[][] c = new double[m1][n2];
        for (int i = 0; i < m1; i++)
            for (int j = 0; j < n2; j++)
                for (int k = 0; k < n1; k++)
                    c[i][j] += a[i][k] * b[k][j];
        return c;
    }
}
