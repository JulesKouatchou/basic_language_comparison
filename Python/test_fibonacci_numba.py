#!/usr/bin/env python

from __future__ import print_function

from numba import njit
import sys
import benchmark_decorator as dectimer

#------------------------------
# Function: iterative_fibonacci
#------------------------------
@dectimer.bench_time(3)
@njit
def iterative_fibonacci(n):
    """
        Find the Fibonacci number of order n by iteration
    """
    if n < 2:
        return n
    previous_fibonacci = 1
    current_fibonacci = 1
    for num in range(2, n):
        previous_fibonacci, current_fibonacci = current_fibonacci, \
            current_fibonacci + previous_fibonacci
    return current_fibonacci

#------------------------------
# Function: recursive_fibonacci
#------------------------------
@dectimer.bench_time_recursive(3)
@njit
def recursive_fibonacci(n):
    """
        Find the Fibonacci number of order n by recursion
    """
    if n < 2:
        return n
    else:
        return recursive_fibonacci(n-1) + recursive_fibonacci(n-2)


if len(sys.argv) < 1:
    print('Usage:')
    print('     python ' + sys.argv[0] + ' N')
    print('Please specify the number of iterations.')
    sys.exit()

N = int(sys.argv[1])

print('Numba -- Fibonacci sequence of size: ', N)

n1 = iterative_fibonacci(N)

#n2 = recursive_fibonacci(N)

print(' ')
