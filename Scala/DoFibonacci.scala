
object DoFibonacci {
   def main(args: Array[String]): Unit = {

       if (args.length == 0) {
          println("Need to provide an integer.")
       }
       val n = args(0).toInt;

       /*
          http://rosettacode.org/wiki/Fibonacci_sequence#Scala
       */

       // Recursive

       def fibR(i:Int):Int = i match{
           case 0 => 0
           case 1 => 1
           case _ => fibR(i-1) + fibR(i-2)
       }
       
       def fibI( n : Int ) : Int = {
         var a = 0
         var b = 1
         var i = 0	  
        
         while( i < n ) {
           val c = a + b
           a = b
           b = c
           i = i + 1
         } 
         return a
       }

       println("-----------------------------") ;
       println("Iterative Fibonacci: "+n) ;
       println("-----------------------------") ;

       var startTime = System.currentTimeMillis

       var m1 = fibI(n);

       var stopTime = System.currentTimeMillis
       println("   Elapsed time (s): " + (stopTime-startTime)/1000.0 + " " + m1)

       println("-----------------------------") ;
       println("Recursive Fibonacci: "+n) ;
       println("-----------------------------") ;

       startTime = System.currentTimeMillis

       var m2 = fibR(n);

       stopTime = System.currentTimeMillis
       println("   Elapsed time (s): " + (stopTime-startTime)/1000.0 + " " + m2)
   }
}

