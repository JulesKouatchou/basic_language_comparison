import scala.collection.mutable.HashSet
import scala.io.Source

object DoCountUniqueWords {
   def main(args: Array[String]): Unit = {

       if (args.length == 0) {
          println("Need to provide a file name.")
       }

       var uniqueWords = HashSet.empty[String]
       var words = Array.empty[String];

       val filename = args(0);

       println("-----------------------------") ;
       println("Count the uniques words in: "+filename) ;
       println("-----------------------------") ;

       var startTime = System.currentTimeMillis;

       val bufferedSource = Source.fromFile(filename);
   
       for (line <- bufferedSource.getLines) {
           words = line.split(" ")
           for (i <- 0 to words.length - 1) {
               uniqueWords.add(words(i).replaceAll("[^a-zA-Z]", "").toLowerCase())
           }
       }
       bufferedSource.close

       println("   Number of unique words: " + uniqueWords.size)

       var stopTime = System.currentTimeMillis
       println("   Elapsed time (s): " + (stopTime-startTime)/1000.0)

   }
}

