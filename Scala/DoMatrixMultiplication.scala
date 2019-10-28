import Array._

object DoMatrixMultiplication {
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
       val dim1 = args(0).toInt;
       val dim2 = dim1
       val dim3 = dim1

       // val dim1 = 2000;
       // val dim2 = 2000;
       // val dim3 = 2000;

       var elapsedTime: Long = 0

       val r = scala.util.Random;

       // Array declarations
       //-------------------

       var A = ofDim[Float](dim1,dim2);
       var B = ofDim[Float](dim2,dim3);
       var C = ofDim[Float](dim1,dim3);

       var sum : Float = 0;

       var i = 1;
       var j = 1;
       var k = 1;

       // build a matrix 
       for (i <- 0 to dim1-1) { 
           for ( 0 <- 1 to dim2-1) { 
               A(i)(j) = r.nextFloat; 
           } 
       }

       for (i <- 0 to dim2-1) { 
           for ( j <- 0 to dim3-1) { 
               B(i)(j) = r.nextFloat;
           } 
       }


       println("-----------------------------") ;
       println("Perform Matrix Multiplication "+dim1) ;
       println("-----------------------------") ;

     
       // Perform the matrix multiplcation
       //---------------------------------
   
       var startTime = System.currentTimeMillis
       
       for (i <- 0 to dim1-1) {
           for (j <- 0 to dim3-1) {
               for (k <- 0 to dim2-1) {
                   sum = sum + A(i)(k)*B(k)(j);
               }
               C(i)(j) = sum;
               sum = 0;
           }
       }
       var stopTime = System.currentTimeMillis

       println("Elapsed time (s): " + (stopTime-startTime)/1000.0)
       println("Done with Matrix Multiplication") 
       println("-------------------------------") 
   }
}

