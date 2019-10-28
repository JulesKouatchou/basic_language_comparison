#!/usr/bin/env Rscript

library(rbenchmark)


arguments = commandArgs(TRUE)

# Get the matrix dimensions n from the command line.
if (length(arguments) == 0) {
  stop("At least one argument must be supplied (dimension).n", call.=FALSE)
} else if (length(arguments) == 1) {
  n <- as.integer(arguments[1])
}

cat('-----------------------------------------\n')
cat('           Copy Matrix: ', n,         '\n')
cat('-----------------------------------------\n')

A <- array(rnorm(n*n*3), dim=c(n, n, 3))
B <- array(rnorm(n*n*3), dim=c(n, n, 3))

# Determine the time to perform several copy operations on the matrices.
benchmark("Loop" = {
              for (j in 1:n) {
                  for (i in 1:n){
                      A[i, j, 1] <- A[i, j, 2]
                      A[i, j, 3] <- A[i, j, 1]
                      A[i, j, 2] <- A[i, j, 3]
                  }
              }
           },
           "Vectorization" = {
               B[, , 1] <- B[, , 2]
               B[, , 3] <- B[, , 1]
               B[, , 2] <- B[, , 3]
           },
          replications = 1,
          columns = c("test", "replications", "elapsed", "relative", "user.self", "sys.self"))
