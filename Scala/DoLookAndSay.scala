
object DoLookAndSay {
   def main(args: Array[String]): Unit = {

       if (args.length == 0) {
          println("Need to provide an integer.")
       }
       val n = args(0).toInt;

    def lookandsayseq(number : String) : String = {
        val result = StringBuilder.newBuilder;
     
        var repeat = number.charAt(0);
        val l = number.length;
        var newnumber = number.substring(1, l) + " ";
        var cnt = 1;
     
        for (actual <- newnumber.toArray)
        {
           if (actual != repeat)
           {
              result.append(cnt + "" + repeat);
              cnt= 1;
              repeat= actual;
           }
           else
           {
              cnt = cnt + 1;
           }
        }
        return result.toString();
    }

       println("-----------------------------") ;
       println("Look and say sequence: "+n) ;
       println("-----------------------------") ;

       var startTime = System.currentTimeMillis
 
        var num = "1223334444";

        var i = 2;
	for (i <- 2 to n) {
		num = lookandsayseq(num);             
	}
	// println(num);

       var stopTime = System.currentTimeMillis
       println("   Elapsed time (s): " + (stopTime-startTime)/1000.0 )

    }

}
