import Array._
import math._
import Jama._

object DoBelief_jama {
   def main(args: Array[String]): Unit = {

       if (args.length == 0) {
          println("Need to provide matrix dimension")
       }
       val N = args(0).toInt;

       val dim = 5000;
       // val N = 250;

       var elapsedTime: Long = 0;

       // Create the matrix
       val A = new Matrix(dim, dim)
 
       var startTime = System.currentTimeMillis

       // Fill the matrix with random numbers
       val r = new scala.util.Random(0)

       for(i <- 0 until A.getRowDimension())
           for(j <- 0 until A.getColumnDimension())
               A.set(i, j, r.nextDouble())

       var x  = ofDim[Double](dim);
       var x2 = ofDim[Double](dim);

       var mysum : Double = 0;
       var mynorm : Double = 0;

       var i = 1;
       var j = 1;
       var k = 1;

       
       println("-----------------------------") ;
       println("Perform belief calculations "+N) ;
       println("-----------------------------") ;

       for (k <- 0 to N-1) {
           for (i <- 0 to dim-1) {
               x2(i) = 0;
               for (j <- 0 to dim-1) {
                   x2(i) = x2(i) + A(i)(j)*scala.math.exp(x(j));
               }
           }

           for (i <- 0 to dim-1) {
               x(i) = scala.math.log(x2(i));
           }

           mysum = 0;
           for (i <- 0 to dim-1) {
               mysum = mysum + scala.math.exp(x(i));
           }

           mynorm = scala.math.log(mysum);
           for (i <- 0 to dim-1) {
               x(i) = x(i) - mynorm;
           }

           
       }
       var stopTime = System.currentTimeMillis

       println("Elapsed time (s): " + (stopTime-startTime)/1000.0)
       println("Done with belief computations") 
       println("-------------------------------") 
   }
}

