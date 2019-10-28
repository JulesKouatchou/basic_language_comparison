import Array._
import math._

object DoBeliefPropagation {
   def main(args: Array[String]): Unit = {

   object Matrix{
     def apply( rowCount:Int, colCount:Int )( f:(Int,Int) => Float ) = (
         for(i <- 1 to rowCount) yield 
	   ( for( j <- 1 to colCount) yield f(i,j) ).toList
       ).toList
   }

       if (args.length == 0) {
          println("Need to provide matrix dimension")
       }
       val N = args(0).toInt;

       val dim = 5000;
       // val N = 250;

       var elapsedTime: Long = 0;

       val r = scala.util.Random;

       // Array declarations
       //-------------------

       var A  = ofDim[Double](dim,dim);
       var x  = ofDim[Double](dim);
       var x2 = ofDim[Double](dim);

       var mysum : Double = 0;
       var mynorm : Double = 0;

       var i = 1;
       var j = 1;
       var k = 1;

       var startTime = System.currentTimeMillis
       
       // build a matrix 
       for (i <- 0 to dim-1) { 
           x(i) = 0;
           for ( j <- 0 to dim-1) { 
               A(i)(j) = r.nextDouble; 
           } 
       }

       println("-----------------------------") ;
       println("Perform belief calculations "+N) ;
       println("-----------------------------") ;

     
       // Perform the matrix multiplcation
       //---------------------------------
   
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

