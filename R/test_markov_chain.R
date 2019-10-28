#!/usr/bin/env Rscript

library(rbenchmark)


args = commandArgs(TRUE)

# Get the number of iterations n from the command line.
if (length(args) == 0) {
  stop("At least one argument must be supplied (num.iterations).n", call.=FALSE)
} else if (length(args) == 1) {
  n <- as.integer(args[1])
}

f <- function(x) {
  # Math function f(x) to use in the algorithm.
  #
  # Args:
  #   x: Matrix of values to plug in for the function's independent variable.
  # 
  # Returns:
  #   The input matrix after several operations.
  return (exp(sin(x[1]*5) - x[1]*x[1] - x[2]*x[2]))
}

MarkovChain <- function(x, N) {
  # Run the Markov Chain algorithm on the input matrix a given number of times.
  #
  # Args:
  #   x: Matrix of values to plug in for the independent variable.
  #   N: The number of iterations to run the algorithm.
  #
  # Returns:
  #   x: The input matrix after being modified by the algorithm a total of N times.
  p <- f(x)
  for (i in 1:N) {
    x2 <- x + 0.01*rnorm(length(x))
    p2 <- f(x2)
    if (runif(1) < (p2/p)) {
      x <- x2
      p <- p2
    }
  }
  return(x)
}

cat('---------------------------------------\n')
cat('     Markov Chain Calculations: ', n, '\n')
cat('---------------------------------------\n')

benchmark("Markov Calcs" = {
            x <- matrix(0.0, nrow=2, ncol=1)
            MarkovChain(x, n)
          },
          replications = 1,
          columns = c("test", "replications", "elapsed", "relative", "user.self", "sys.self"))
