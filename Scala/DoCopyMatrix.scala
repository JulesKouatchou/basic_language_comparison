import Array._

object DoCopyMatrix {
   def main(args: Array[String]): Unit = {

       if (args.length == 0) {
          println("Need to provide matrix dimension")
       }

       //val n = 5000;
       //val n = 7000;
       // val n = 9000;
       val n = args(0).toInt;

       var elapsedTime: Long = 0

       val r = scala.util.Random;

       // Array declarations
       //-------------------
       var A = Array.ofDim[Float](n,n,3);

       var sum : Float = 0;

       var i = 1;
       var j = 1;
       var k = 1;

       // build a matrix 
       for (i <- 0 to n-1) { 
           for ( j <- 0 to n-1) { 
               for ( k <- 0 to 2) { 
                   A(i)(j)(k) = r.nextFloat; 
               }
           } 
       }

       println("-----------------------------") ;
       println("Perform Matrix Copy: "+n) ;
       println("-----------------------------") ;

       var startTime = System.currentTimeMillis

       for (i <- 0 to n-1) { 
           for ( j <- 0 to n-1) { 
               A(i)(j)(0) = A(i)(j)(1);
               A(i)(j)(2) = A(i)(j)(0);
               A(i)(j)(1) = A(i)(j)(2);
           } 
       }

       var stopTime = System.currentTimeMillis

       println("Elapsed time (s): " + (stopTime-startTime)/1000.0)
       println("-------------------------------") 
   }
}

