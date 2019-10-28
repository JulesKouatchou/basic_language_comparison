// import java.util.Scanner;
import java.io.*;
import java.util.concurrent.*;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Random;
import java.lang.*;

class testLaplaceJacobi4 {

    public static void main (String[] args) {

        long startTime;
        long estimatedTime;
        int n;

        if (args.length > 0) {
            try {
                n = Integer.parseInt(args[0]);
            } catch (NumberFormatException e) {
                System.err.println("Argument" + args[0] + " must be an integer.");
                System.exit(1);
            }
        }

        n = Integer.parseInt(args[0]);

        System.out.println("Jacobi Iterative Solver: "+n);

       int    niter = 10000000;
       int    count = 0;
       double eps   = 1e-6;
       double err   = 999999.0;

       // Array declarations
       //-------------------
        double u[][] = new double[n][n];
        double v[][] = new double[n][n];
        double w[][] = new double[n][n];
        double x[]   = new double[n];

       double sum = 0.0;
       double h   = 1.0/(n-1);

        startTime = System.currentTimeMillis();

       //--------------------------
       // Set the initial condition
       //--------------------------
       for (int i=0;i<n;i++) {
           x[i] = i*h;
       }

       for (int i=0;i<n;i++) {
           for (int j=0;j<n;j++) {
               u[i][j] = 0;
           }
       }

       for (int i=0;i<n;i++) {
           u[i][0]   = Math.sin(x[i]*Math.PI);
           u[i][n-1] = Math.sin(x[i]*Math.PI)*Math.exp(-Math.PI);
       }

       //--------------------------
       // Iterative solver
       //--------------------------
       while ((err > eps) & (count < niter)) {
           count = count + 1;
           copyArray(u, w);

           for (int i=1; i<n-1; i++) {
               for (int j=1; j<n-1; j++) {
                   u[i][j] = ((u[i-1][j] + u[i+1][j] + u[i][j-1] + u[i][j+1])*4.0 +
                              u[i-1][j-1] + u[i-1][j+1] + u[i+1][j-1] + u[i+1][j+1])/20.0;
               }
           }
           v = diffArray(u, w);
           err = dotProduct(v,v);
       }

        estimatedTime = System.currentTimeMillis() - startTime;
        NumberFormat formatter = new DecimalFormat("#00000.00000000");
        System.out.println("    Time: " + formatter.format(estimatedTime  / 1000d) + " seconds");
        System.out.println("  Sweeps: " + count + " Err: " + err);
    }

      public static double[][] diffArray(double[][] as, double[][] bs) {
           int nRows = as.length;
           int nCols = as[0].length;
           double[][] v = new double[nRows][nCols];

           for (int i=0; i < nRows; i++){
               for (int j=0; j < nCols; j++){
                   v[i][j] = as[i][j] - bs[i][j];
               }
           }
           return v;
       }

       public static void copyArray(double[][] aSource, double[][] aDestination) {
           for (int i = 0; i < aSource.length; i++) {
               System.arraycopy(aSource[i], 0, aDestination[i], 0, aSource[i].length);
           }
       }

        public static double dotProduct(double[][] as, double[][] bs) {
           int nRows = as.length;
           int nCols = as[0].length;
           double sum = 0.0;

           for (int i=0; i < nRows; i++){
               for (int j=0; j < nCols; j++){
                   sum += as[i][j]*bs[i][j];
               }
           }
           return sum;
       }


}
