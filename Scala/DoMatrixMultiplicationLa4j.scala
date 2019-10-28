// Import library

import org.la4j.matrix._
import org.la4j.linear._

object DoMatrixMultiplicationLa4j {
   def main(args: Array[String]): Unit = {

       if (args.length == 0) {
          println("Need to provide matrix dimension")
       }
       val N = args(0).toInt;

       // val N = 1500

       // Create the matrix
       val A = DenseMatrix.zero(N, N)
       val B = DenseMatrix.zero(N, N)

       // Fill the matrix with random numbers
       val r = new scala.util.Random(0)

       for(i <- 0 until A.rows())
           for(j <- 0 until A.columns())
               A.set(i, j, r.nextDouble())

       for(i <- 0 until B.rows())
           for(j <- 0 until B.columns())
               B.set(i, j, r.nextDouble())

       println("-----------------------------") ;
       println("Perform Matrix Multiplication: "+N) ;
       println("-----------------------------") ;

       var startTime = System.currentTimeMillis

       // Matrix product C=A'B
       // val C = A.transpose().multiply(B)
       val C = A.transpose().multiply(B)

       var stopTime = System.currentTimeMillis

       println("Elapsed time (s): " + (stopTime-startTime)/1000.0)
       println("-----------------------------") ;
   }
}

