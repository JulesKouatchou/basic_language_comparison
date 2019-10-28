#!/usr/bin/env Rscript

library(rbenchmark)


args = commandArgs(TRUE)

# Get the order n of the Fibonacci number to find from the command line.
if (length(args) == 0) {
  stop("At least one argument must be supplied (dimension).n", call.=FALSE)
} else if (length(args) == 1) {
  n <- as.integer(args[1])
}

# Recursive function
#RecursiveFibonacci <- function(n) {
#  if ( n < 2 ) n
#  else recursiveFobonacci(n-1) + recursiveFobonacci(n-2)
#  #else Recall(n-1) + Recall(n-2)
#}


RecursiveFibonacci <- function(n) {
  # Recursively calculate the Fibonacci number by calling LowerFibonacci.
  #
  # Args:
  #   n: The order of Fibonacci number to be found.
  LowerOrder <- function(n, minus.1, minus.2) {
    # Find Fibonacci numbers of lower orders n-1 and n-2 recursively.
    #
    # Args:
    #  n: The order of the desired Fibonacci number.
    #  minus.1: Fibonacci number of order n-1. Has a minimum of 1.
    #  minus.2: Fibonacci number of order n-2. Has a minimum of 0.
    ifelse(n <= 1, minus.2,
      ifelse(n == 2, minus.1,
        Recall(n-1, minus.1+minus.2, minus.1)  
    ))
  }
  LowerOrder(n, 1, 0)
}


IterativeFibonacci <- function(n) {
  # Iteratively calculate the desired Fibonacci number by adding up from 0 and 1.
  #
  # Args:
  #   n: The order of Fibonacci number to be found.
  if (n < 2)
    n
  else {
    fibonacci.number <- c(0, 1)
    for (i in 2:n) {
      temp <- fibonacci.number[2]
      fibonacci.number[2] <- sum(fibonacci.number)
      fibonacci.number[1] <- temp
    }
    fibonacci.number[2]
  }
}

cat('-----------------------------------------\n')
cat('           Fibonacci: ', n,         '\n')
cat('-----------------------------------------\n')

benchmark("Iterative" = {IterativeFibonacci(n)},
          "Recursive" = {RecursiveFibonacci(n)},
          replications = 1,
          columns = c("test", "replications", "elapsed", "relative", "user.self", "sys.self"))
