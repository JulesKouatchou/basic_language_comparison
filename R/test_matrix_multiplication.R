#!/usr/bin/env Rscript

library(rbenchmark)


args = commandArgs(TRUE)

# Get the matrix dimensions n from the command line.
if (length(args) == 0) {
  stop("At least one argument must be supplied (dimension).n", call.=FALSE)
} else if (length(args) == 1) {
  n <- as.integer(args[1])
}

cat('---------------------------------------\n')
cat('     Multiplication of matrices: ', n, '\n')
cat('---------------------------------------\n')

# Create randomly populated n by n matrices.
A <- matrix(rnorm(n*n), n)
B <- matrix(rnorm(n*n), n)

# Multiply the two matrices.
benchmark("MatMult" = { C <- A %*% B },
          replications = 1,
          columns = c("test", "replications", "elapsed", "relative", "user.self", "sys.self"))
