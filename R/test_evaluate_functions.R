#!/usr/bin/env Rscript

library(rbenchmark)


args = commandArgs(TRUE)

# Get the number n of evenly-spaced matrix elements from the command line.
if (length(args) == 0) {
  stop("At least one argument must be supplied (dimension).n", call.=FALSE)
} else if (length(args) == 1) {
  n <- as.integer(args[1])
}

cat('-----------------------------------------\n')
cat('           Evaluate Functions: ', n,         '\n')
cat('-----------------------------------------\n')

# Evaluate the trigonometric functions a total of M times each on the matrix of
# n values spaced evenly from -1500.0 to 1500.0.
benchmark("Evaluate" = {
            M <- 10000
            x <- seq(from=-1500.0, to=1500.0, length.out=n)
            for (i in 1:M) {
              y <-  sin(x)
              x <- asin(y)
              y <-  cos(x)
              x <- acos(y)
              y <-  tan(x)
              x <- atan(y)
            }
          },
          replications = 1,
          columns = c("test", "replications", "elapsed", "relative", "user.self", "sys.self"))
