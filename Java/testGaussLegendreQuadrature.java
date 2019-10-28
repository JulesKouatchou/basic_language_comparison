import java.io.*;
import java.util.concurrent.*;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import static java.lang.Math.*;
 
public class testGaussLegendreQuadrature {
    public static void main(String[] args) {

        int N;
        long startTime;
        long estimatedTime;
        double quad;

        if (args.length > 0) {
            try {
                N = Integer.parseInt(args[0]);
            } catch (NumberFormatException e) {
                System.err.println("Argument" + args[0] + " must be an integer.");
                System.exit(1);
            }
        }

        N = Integer.parseInt(args[0]);
 
        double[] lroots = new double[N];
        double[] weight = new double[N];
        double[][] lcoef = new double[N + 1][N + 1];
 
        System.out.println("Gauss-Legendre Quadrature: "+N);

        startTime = System.currentTimeMillis();

        legendreCoef(lcoef);
        System.out.println("    Done legendreCoef: ");
        legendreRoots(lcoef, weight, lroots);
        System.out.println("    Done legendreRoots: ");
        quad = legendreInte(weight, lroots, -3, 3);
        
        estimatedTime = System.currentTimeMillis() - startTime;
        NumberFormat formatter = new DecimalFormat("#00000.00000000");
        System.out.println("    Time: " + formatter.format(estimatedTime  / 1000d) + " seconds");
        double exact = exp(3) - exp(-3);
        double diff  = quad - exact;
        System.out.println("       Quad: " + quad + " Exact: " + exact + " Diff: " + diff);
    }

    public static void legendreCoef(double[][] mylcoef) {
        int M = mylcoef.length - 1;

        // for(int n=0; n<=M; n++) for(int i=0; i<M; i++) mylcoef[n][i]=0.0;
        mylcoef[0][0] = 1.0;
        mylcoef[1][1] = 1.0;
 
        for (int n = 2; n <= M; n++) {
            mylcoef[n][0] = -(n - 1) * mylcoef[n - 2][0] / n;
 
            for (int i = 1; i <= n; i++) {
                mylcoef[n][i] = ((2 * n - 1) * mylcoef[n - 1][i - 1] - (n - 1) * mylcoef[n - 2][i]) / n;

            }
        }
    }
 
    public static double legendreEval(double[][] mylcoef, int n, double x) {
        double s = mylcoef[n][n];
        for (int i = n; i > 0; i--)
            s = s * x + mylcoef[n][i - 1];
        return s;
    }
 
    public static double legendreDiff(double[][] mylcoef, int n, double x) {
        return n * (x * legendreEval(mylcoef, n, x) - legendreEval(mylcoef, n - 1, x)) / (x * x - 1);
    }
 
    public static void legendreRoots(double[][] mylcoef, double[] myweight, double[] mylroots) {
        int M = mylcoef.length - 1;
        double x, x1;
        double eps = 0.3E-9;
        //double eps = 1.0E-10;
        for (int i = 1; i <= M; i++) {
            x = cos(PI * (i - 0.25) / (M + 0.5));
        System.out.println("    Inside legendreRoots: " + i + " " + PI);
            do {
                x1 = x;
                x -= legendreEval(mylcoef, M, x) / legendreDiff(mylcoef, M, x);
            } while ( abs (x - x1) >= eps);
 
            mylroots[i - 1] = x;
 
            x1 = legendreDiff(mylcoef, M, x);
            myweight[i - 1] = 2 / ((1 - x * x) * x1 * x1);
        }
    }
 
    public static double legendreInte(double[] myweight, double[] mylroots, double a, double b) {
        int M = myweight.length;
        double c1 = (b - a) / 2;
        double c2 = (b + a) / 2;
        double sum = 0;
        for (int i = 0; i < M; i++)
            sum += myweight[i] * exp(c1 * mylroots[i] + c2);
        return c1 * sum;
    }
}
