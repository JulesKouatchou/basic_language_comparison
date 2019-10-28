// Import library
import Jama._

object DoMatrixMultiplicationJama {
   def main(args: Array[String]): Unit = {

       if (args.length == 0) {
          println("Need to provide matrix dimension")
       }
       val N = args(0).toInt;

       // val N = 2000

       // Create the matrix
       val A = new Matrix(N, N)
       val B = new Matrix(N, N)

       // Fill the matrix with random numbers
       val r = new scala.util.Random(0)

       for(i <- 0 until A.getRowDimension())
           for(j <- 0 until A.getColumnDimension())
               A.set(i, j, r.nextDouble())

       for(i <- 0 until B.getRowDimension())
           for(j <- 0 until B.getColumnDimension())
               B.set(i, j, r.nextDouble())

       println("---------------------------------------") ;
       println("JAMA-Perform Matrix Multiplication: "+N) ;
       println("---------------------------------------") ;

       var startTime = System.currentTimeMillis

       // Matrix product C=A'B
       // val C = A.transpose().times(B)
       val C = A.times(B)

       var stopTime = System.currentTimeMillis

       println("Elapsed time (s): " + (stopTime-startTime)/1000.0)
       println("---------------------------------------") ;
   }
}

