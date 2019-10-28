import Array._
import scala.math._

object DoEvaluateFunctions {
   def main(args: Array[String]): Unit = {

       if (args.length == 0) {
          println("Need to provide the number of points")
       }

       val num_iterations = 10000;
       val n = args(0).toInt;

       var elapsedTime: Long = 0

       println("-----------------------------") ;
       println("Evaluate Functions: "+n) ;
       println("-----------------------------") ;

       var startTime = System.currentTimeMillis

       val a_min = -1500.0;
       val a_max = -1500.0;
       val h     = (a_max - a_min)/(n-1);

       // Array declarations
       //-------------------
       var x = Array.ofDim[Double](n);
       var y = Array.ofDim[Double](n);

       var i = 1;
       var j = 1;

       // build a matrix 
       for (i <- 0 to n-1) { 
           x(i) = a_min + i*h; 
       }

       for (i <- 0 to num_iterations-1) { 
           for ( j <- 0 to n-1) { 
               y(j) = sin(x(j));
               x(j) = asin(y(j));
               y(j) = cos(x(j));
               x(j) = acos(y(j));
               y(j) = tan(x(j));
               x(j) = atan(y(j));
           } 
       }

       var stopTime = System.currentTimeMillis

       println("Elapsed time (s): " + (stopTime-startTime)/1000.0)
       println("-------------------------------") 
   }
}

