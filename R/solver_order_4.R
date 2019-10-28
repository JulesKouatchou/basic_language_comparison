#!/usr/bin/env Rscript


RegularTimeStepij <- function(u) {
  # Take a time step in the desired numerical solution u found using loops over j for each i.
  #
  # Args:
  #   u: Numerical values of the approximated solution.
  # 
  # Returns:
  #   output: The numerical solution value and error value.
  n <- dim(u)[1] - 1
  m <- dim(u)[2] - 1
  error <- 0.0
  for (i in 2:n) { 
    for (j in 2:m) {
      temp <- u[i,j]
      u[i,j] <- ( ((u[i-1,j] + u[i+1,j] + u[i,j-1] + u[i,j+1])*4.0 +
                 u[i-1,j-1] + u[i-1,j+1] + u[i+1,j-1] + u[i+1,j+1])/20.0 )
        
      difference <- u[i,j] - temp
      error <- error + difference*difference
    }
  }
  output <- list("u"=u, "error"=sqrt(error))
  return(output)
}


RegularTimeStepji <- function(u) {
  # Take a time step in the desired numerical solution u found using loops over i for each j.
  #
  # Args:
  #   u: Numerical values of the approximated solution.
  # 
  # Returns:
  #   output: The numerical solution value and error value.
  n <- dim(u)[1] - 1
  m <- dim(u)[2] - 1
  error <- 0.0
  for (j in 2:m){
    for (i in 2:n){
      temp <- u[i,j]
      u[i,j] <- (((u[i-1,j] + u[i+1,j] + u[i,j-1] + u[i,j+1])*4.0 +
                 u[i-1,j-1] + u[i-1,j+1] + u[i+1,j-1] + u[i+1,j+1])/20.0 )

      difference <- u[i,j] - temp
      error <- error + difference*difference
    }
  }
  output <- list("u"=u, "error"=sqrt(error))
  return(output)
}


VectorizedTimeStep <- function(u) {
  # Take a time step in the desired numerical solution u found using vectorization.
  #
  # Args:
  #   u: Numerical values of the approximated solution.
  # 
  # Returns:
  #   output: The numerical solution value and error value.
  n <- dim(u)[1]
  m <- dim(u)[2]
  u.old <- u

  n1 <- n-1
  n3 <- n-2

  m1 <- m-1
  m3 <- m-2

  u[2:n1, 2:m1] <- (((u[1:n3, 2:m1] + u[3:n,  2:m1] +
                      u[2:n1, 1:m3] + u[2:n1, 3:m])*4.0 +
                      u[1:n3, 1:m3] + u[1:n3, 3:m] +
                      u[3:n,  1:m3] + u[3:n,  3:m])/20.0 )

  v <- as.vector(u - u.old)
  error = v%*%v
  output <- list("u"=u, "error"=sqrt(error[1]))

  return(output)
}

