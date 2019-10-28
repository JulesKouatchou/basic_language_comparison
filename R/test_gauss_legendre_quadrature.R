#!/usr/bin/env Rscript

library(pracma)
library(rbenchmark)


args = commandArgs(TRUE)

# Get the number of iterations n from the command line.
if (length(args) == 0) {
  stop("At least one argument must be supplied (numIterations).n", call.=FALSE)
} else if (length(args) == 1) {
  n <- as.integer(args[1])
}

#Integrand f(x) to be numerically integrated.
f <- function(x) exp(x)

cat('---------------------------------------\n')
cat('     Gauss Legendre Quadrature: ', n, '\n')
cat('---------------------------------------\n')

#Use Gauss-Legendre quadrature over the interval [a, b] on f(x).
benchmark("Quadrature" = {
            a <- -3.0
            b <-  3.0
            i <- 1:n
            x <- a + (i-1)*(b-a)/(n-1)

            quadrature.values <- gaussLegendre(n, a, b)
            quadrature.result <- sum(quadrature.values$w*f(quadrature.values$x)) 
          },
          replications = 1,
          columns = c("test", "replications", "elapsed", "relative", "user.self", "sys.self"))

