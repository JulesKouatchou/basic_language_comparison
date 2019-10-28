
import Array._
import scala.math.pow

object DoMunchausenNumber {
  def main(args: Array[String]): Unit = {

      def raisedto(n:Int): Double = {
          if (n == 0) {
             return 0
          }
          else {
             return pow(n,n)
          }
      }

      println("-----------------------------") ;
      println("Looking for the Munchausen Numbers") ;
      println("-----------------------------") ;

      var startTime = System.currentTimeMillis

      var power_of_digits = Array.ofDim[Double](10)
      for (k <- 0 to 9) {
          power_of_digits(k) = raisedto(k)
      }

      var i = 0
      var n = 0

      while (n < 4) {
            if (i == (i.toString.toCharArray.map(d => power_of_digits(d.asDigit))).sum) {
               n = n + 1
               println(s"Munchausen Number $n: $i ")
            }
            i = i + 1
      }

      var stopTime = System.currentTimeMillis
      println("   Munchausen Elapsed time (s): " + (stopTime-startTime)/1000.0 )

  }
}
