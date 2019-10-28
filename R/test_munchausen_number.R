#!/usr/bin/env Rscript

library(rbenchmark)


raisedto <- function(n) {
  # Raise the input number to the power of itself.
  #
  # Args:
  #   n: Integer value
  # 
  # Returns:
  #   The resulting number of n raised to its own power. If n is 0, return 0.
  if (n == 0) {
    return(n)
  } else {
    return(n^n)
  }
}


MunchausenNumber <- function(m) {
  # Perform the Munchausen number algorithm.
  #
  # Args:
  #   m: The number to check.
  # 
  # Returns:
  #   The number resulting from the Munchausen number alorithm.
  #n <- m
  digits <- floor(m / 10^(0:(nchar(m) - 1))) %% 10 
  return(sum(raisedto(digits)))
}


FindMunchausenNumbers <- function() {
  # Find the four Munchausen numbers.
  i <- 0
  num <- 0
  while (num < 4) {
    if (i == MunchausenNumber(i)) {
      num <- num + 1
      cat("Munchausen Number ", num, ":", i, '\n')
    }
    i <- i + 1
  }
}

 
cat('---------------------------------------------\n')
cat(' Determine the first four Munchausen numbers \n')
cat('---------------------------------------------\n')

benchmark("FindMunchausenNumbers" = { FindMunchausenNumbers() },
          replications = 1,
          columns = c("test", "replications", "elapsed", "relative", "user.self", "sys.self"))
