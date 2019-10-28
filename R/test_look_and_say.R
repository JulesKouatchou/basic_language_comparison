#!/usr/bin/env Rscript

library(rbenchmark)

args = commandArgs(TRUE)

# Get the order n of the look and say sequence from the command line.
if (length(args) == 0) {
   stop("At least one argument must be supplied (dimension).n", call.=FALSE)
} else if (length(args) == 1) {
   n <- as.integer(args[1])
}

LookAndSaySequence <- function(start.sequence.integer, return.an.int=FALSE) {
  # Determine the look and say sequence of a given order, starting with the string x.
  #
  # Args:
  #   start.sequence.integer: The initial sequence of integers used to find the nth look and say sequence.
  #   return.an.int: If TRUE, convert the result to an integer. Otherwise, the result is a string.
  #
  # Returns:
  #   new.string: The completed look and say sequence of order n as a string or an integer, given return.an.int.
  sequence.string <- unlist(strsplit(as.character(start.sequence.integer), ""))  
  rle.sequence.string <- rle(sequence.string)  # Get run length encoding. 

  #Form new string.
  odds <- as.character(rle.sequence.string$lengths)
  evens <- rle.sequence.string$values
  new.string <- as.vector(rbind(odds, evens))

  new.string <- paste(new.string, collapse="")  # Collapse to scalar.
  if (return.an.int) as.integer(new.string) else new.string  # Convert to number, if desired.
}


cat('-----------------------------------------\n')
cat('  Look and say sequence of order: ', n,         '\n')
cat('-----------------------------------------\n')

benchmark("Look_and_Say" = {
            x <- 1223334444
            if (n > 1) {
              for (i in 2:n) {
                x <- LookAndSaySequence(x)
                #print(x)
              }
            }
          },
          replications = 1,
          columns = c("test", "replications", "elapsed", "relative", "user.self", "sys.self"))
