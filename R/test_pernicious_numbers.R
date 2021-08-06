#!/usr/bin/env Rscript

library(rbenchmark)
library(binaryLogic)
library(stringr)

args = commandArgs(TRUE)

# Get the number num of the Pernicious numbers to find from the command line.
if (length(args) == 0) {
  stop("At least one argument must be supplied n", call.=FALSE)
} else if (length(args) == 1) {
  num <- as.integer(args[1])
}


get_number_of_ones <- function(n) {
  # Find the number of ones in the binary representation of a number.
  #
  # Args:
  #   n: Integer value
  # 
  # Returns:
  #   The number of ones.
  n_bin <- as.binary(n)
  n_str <- toString(n_bin)
  count_ones <- sum(str_count(n_str, "1"))
  return(count_ones)
}


is_prime_number <- function(m) {
  # Determine if a number is a prime.
  #
  # Args:
  #   m: The number to check.
  # 
  # Returns:
  #   True/False
   flag = FALSE
   if (m < 2) {
      flag = FALSE
   } else if (m == 2) {
      flag = TRUE
   } else if (any(m %% 2:(m-1) == 0)) {
      flag = FALSE
   } else { 
      flag = TRUE
   }

  return(flag)
}


find_pernicious_numbers <- function(n) {
  # Find the first n pernicoius numbers.
  i <- 1
  counter <- 0
  while (counter < n) {
    if (is_prime_number(get_number_of_ones(i))) {
      counter <- counter + 1
      #cat("Pernicious ", n, ":", counter, i, get_number_of_ones(i), '\n')
    }
    i <- i + 1
  }
  return(i-1)
}

 
cat('---------------------------------------------\n')
cat(' Determine the Pernicious numbers \n')
cat('---------------------------------------------\n')

benchmark("find_pernicious_numbers" = { find_pernicious_numbers(num) },
          replications = 1,
          columns = c("test", "replications", "elapsed", "relative", "user.self", "sys.self"))
