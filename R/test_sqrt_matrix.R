#!/usr/bin/env Rscript

library(rbenchmark)


args = commandArgs(TRUE)

# Get the dimension n of the matrix.
if (length(args) == 0) {
  stop("At least one argument must be supplied (dimension).n", call.=FALSE)
} else if (length(args) == 1) {
  n <- as.integer(args[1])
}

"%^%" <- function(S, power)
  # Raise the matrix to the given power.
  #
  # Args:
  #   S: Matrix to raise to a power.
  #   power: The power to which the matrix is raised.
  #
  # Returns:
  #   The matrix after being raised to the power.   
  with(eigen(S), vectors %*% (values^power*t(vectors)))


cat('-----------------------------------------\n')
cat('           Square root of matrix: ', n,         '\n')
cat('-----------------------------------------\n')

#A <- matrix(1, n, n)
A <- array(1, dim=c(n,n))
for (i in 1:n) {
  A[i,i] <- 6
}

benchmark("sqrtMat" = { B <- A%^%(0.5) },
          replications = 1,
          columns = c("test", "replications", "elapsed", "relative", "user.self", "sys.self"))
