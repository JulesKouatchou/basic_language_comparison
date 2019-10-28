import Array._
import math._

object DoMarkovChain {
   def main(args: Array[String]): Unit = {

       if (args.length == 0) {
          println("Need to provide matrix dimension")
       }
       val N = args(0).toInt;

       // val N = 5000;

       var elapsedTime: Long = 0;

       val r = scala.util.Random;
       val s = scala.util.Random;

       // Array declarations
       //-------------------

       var x  = ofDim[Double](2);
       var x2 = ofDim[Double](2);

       var p1 : Double = 0;
       var p2 : Double = 0;

       var i = 1;
       var j = 1;
       var k = 1;

       var startTime = System.currentTimeMillis
       
       println("-----------------------------") ;
       println("Perform Markov Chain calculations "+N) ;
       println("-----------------------------") ;

       x(0) = 0;
       x(1) = 0;
     
       p1 = scala.math.exp(scala.math.sin(5*x(0)) - x(0)*x(0) - x(1)*x(1));
       for (k <- 0 to N-1) {
           x2(0) = x(0) + 0.01*s.nextGaussian;
           x2(1) = x(1) + 0.01*s.nextGaussian;

           p2 = scala.math.exp(scala.math.sin(5*x2(0)) - x2(0)*x2(0) - x2(1)*x2(1));

           if (r.nextDouble < (p2/p1)) {
              x(0) = x2(0);
              x(1) = x2(1);
              p1   = p2;
           }
           
       }
       var stopTime = System.currentTimeMillis

       println("Elapsed time (s): " + (stopTime-startTime)/1000.0)
       println("Done with Markov Chain computations") 
       println("-------------------------------") 
   }
}

