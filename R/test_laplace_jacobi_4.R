#!/usr/bin/env Rscript

library(rbenchmark)


source("solver_order_4.R")

args = commandArgs(TRUE)

# Get the number of grid points from the command line.
if (length(args) == 0) {
  cat("Usage: Rscript test_laplace_jacobi_4.R num.points \n")
  stop("       --->      Please specify the number of grid points.", call.=FALSE)
}
num.points <- as.integer(args[1])

pi <- 4.0*atan(1.0)

#cat("--------------------------------------------------\n")
#cat("Regular Solver (ij loop) for Fourth-Order Scheme: ", num.points, "\n")
#cat("--------------------------------------------------\n")
#cat(" \n")
#
#u <- array(0.0, dim=c(num.points, num.points))
#
#i <- 1:num.points
#x <- (i-1)*pi/(num.points-1)
#
#u[1, ] <- sin(x)
#u[num.points, ] <- sin(x)*exp(-pi)
#
#RegularSolverij <- function(u) {
## Find the desired numerical solution u using loops through all j values for each i.
##
## Args:
##   u: Numerical values of the approximated solution.
## 
## Returns:
##   output: The full numerical solution values, error values, and iteration numbers.
#  iteration <- 0
#  error  <- 2
#  while (iteration < 100000 && error > 1e-6) {
#    A <- RegularTimeStepij(u)
#    u <- A$u
#    error <- A$error
#    iteration <- iteration + 1
#  }
#  output = list("u"=u, "error"=error, "iteration"=iteration)
#  return (output)
#}
#
#
#btm <- proc.time()
#A <- RegularSolverij(u)
#etm <- proc.time()
#
#etm - btm
#
#cat(" \n")
#cat("   ij  Number of iterations: ", A$iteration, "\n")
#cat("       Error:", A$error, "\n")
#cat(" \n")

cat("--------------------------------------------------\n")
cat("Solver for Fourth-Order Scheme: ", num.points, "\n")
cat("--------------------------------------------------\n")
cat(" \n")


i <- 1:num.points
x <- (i-1)*pi/(num.points-1)

u <- array(0.0, dim=c(num.points, num.points))
u[1, ] <- sin(x)
u[num.points, ] <- sin(x)*exp(-pi)

RegularSolverji <- function(u) {
  # Find the desired numerical solution u using loops through all i values for each j.
  #
  # Args:
  #   u: Numerical values of the approximated solution.
  # 
  # Returns:
  #   output: The full numerical solution values, error values, and iteration numbers.
  iteration <- 0
  error  <- 2
  while (iteration < 100000 && error > 1e-6) {
    A <- RegularTimeStepji(u)
    u <- A$u
    error <- A$error
    iteration <- iteration + 1
  }
  output = list("u"=u, "error"=error, "iteration"=iteration)
  return (output)
}


v <- array(0.0, dim=c(num.points, num.points))
v[1, ] <- sin(x)
v[num.points, ] <- sin(x)*exp(-pi)

VectorizedSolver <- function(v){
  # Find the desired numerical solution v using vectorization.
  #
  # Args:
  #   v: Array for numerical values of the approximated solution.
  #
  # Returns:
  #   output: The full numerical solution values, error values, and iteration numbers.
  iteration <- 0
  error  <- 2.0
  while (iteration < 100000 && error > 1e-6) {
    A <- VectorizedTimeStep(v)
    v <- A$u
    error <- A$error
    iteration <- iteration + 1
  }
  output = list("u"=v, "error"=error, "iteration"=iteration)
  return (output)
}


benchmark("Loop(ji)" = { A <- RegularSolverji(u) },
          "Vectorization" = { B <- VectorizedSolver(v) },
          replications = 1,
          columns = c("test", "replications", "elapsed", "relative", "user.self", "sys.self"))

