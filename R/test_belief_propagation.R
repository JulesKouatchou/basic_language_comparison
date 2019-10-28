#!/usr/bin/env Rscript

library(rbenchmark)


arguments = commandArgs(TRUE)


# Get the number of iterations n from the command line.
if (length(arguments) == 0) {
  stop("At least one argument must be supplied (numIterations).n", call.=FALSE)
} else if (length(arguments) == 1) {
  n <- as.integer(arguments[1])
}

BeliefPropagation <- function(A, x, N) {
  # Run the belief propagation algorithm for a given number of iterations.
  #
  # Args:
  #   A: An m by m matrix of random values.
  #   x: An m by 1 matrix of 1.0 values.
  #   N: Integer number of iterations.
  # 
  # Returns:
  #   x: m by 1 matrix after operating the belief propagation algorithm.
  for (i in 1:N) {
    x2 <- log(A %*% exp(x))
    x <- x - log(sum(exp(x2)))
  }
  return(x)
}


cat('---------------------------------------\n')
cat('     Belief Calculations: ', n, '\n')
cat('---------------------------------------\n')

benchmark("Belief" = {
             m <- 5000
             A <- matrix(runif(m*m), m)
             x <- matrix(1.0, nrow=m, ncol=1)
             y <- BeliefPropagation(A, x, n)
             },
         replications = 1,
         columns = c("test", "replications", "elapsed", "relative", "user.self", "sys.self"))
