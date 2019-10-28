import Array._
import scala.math._

object DoLaplaceJacobi4 {
   def main(args: Array[String]): Unit = {

       if (args.length == 0) {
          println("Need to provide matrix dimension")
       }
       val n = args(0).toInt;

       // val n = 200;
       //val n = 150;
       //val n = 100;

       val niter = 10000000;
       val eps   = 1e-6;
       var err: Double = 999999;

       var count = 0

       var elapsedTime: Long = 0

       // Array declarations
       //-------------------
       var u = Array.ofDim[Double](n,n);
       var v = Array.ofDim[Double](n,n);
       var uold = Array.ofDim[Double](n,n);
       var x = Array.ofDim[Double](n);

       var sum : Double = 0;

       var i = 1;
       var j = 1;
       var k = 1;
       val h: Double = 1.0/(n-1);

       def diffArray(as: Array[Array[Double]], bs: Array[Array[Double]]): Array[Array[Double]] = {
           require(as.size == bs.size)
           val nRows = as.length;
           val nCols = as(0).length;
           var v = Array.ofDim[Double](nRows,nCols);
           sum = 0.0;
           for (i <- 0 to nRows-1){
               for (j <- 0 to nCols-1){
                   v(i)(j) = as(i)(j) - bs(i)(j);
               }
           }
           return v
       }

       def dotProduct(as: Array[Array[Double]], bs: Array[Array[Double]]): Double = {
           require(as.size == bs.size)
           val nRows = as.length;
           val nCols = as(0).length;
           sum = 0.0;
           for (i <- 0 to nRows-1){
               for (j <- 0 to nCols-1){
                   sum += as(i)(j)*bs(i)(j);
               }
           }
           return sum
       }

       println("-----------------------------") ;
       println("Jacobi Iterative Solver: "+n) ;
       println("-----------------------------") ;

       var startTime = System.currentTimeMillis

       //-------------------------- 
       // Set the initial condition
       //-------------------------- 
       for (i <- 0 to n-1) { 
           x(i) = i*h;
       }

       for (i <- 0 to n-1) { 
           for ( j <- 0 to n-1) { 
               u(i)(j) = 0; 
           } 
       }

       for (i <- 0 to n-1) { 
           u(i)(0) = sin(x(i)*Pi);         
           u(i)(n-1) = sin(x(i)*Pi)*exp(-Pi);         
       }

       //-------------------------- 
       // Iterative solver
       //-------------------------- 
       while ((err > eps) && (count < niter)) {
           count = count + 1;
           uold = u.map(_.clone);
           for (i <- 1 to n-2) { 
               for ( j <- 1 to n-2) { 
                   u(i)(j) = ((u(i-1)(j) + u(i+1)(j) + u(i)(j-1) + u(i)(j+1))*4.0 + u(i-1)(j-1) + u(i-1)(j+1) + u(i+1)(j-1) + u(i+1)(j+1))/20.0;
               } 
           }
           v = diffArray(u, uold);
           err = dotProduct(v,v);
       }

       var stopTime = System.currentTimeMillis

       println("Elapsed time (s): " + (stopTime-startTime)/1000.0)
       println("       Number of iterations: " + count) 
       println("       Error:                " + err) 
       println("-------------------------------") 
   }
}

