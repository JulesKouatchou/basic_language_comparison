#!/usr/bin/env python

from __future__ import print_function

import numpy as np
import sys
from numba import jit
import benchmark_decorator as dectimer

#--------------------------------
# Function: matrix_multiplication
#--------------------------------
@dectimer.bench_time(3)
@jit
def matrix_multiplication(A, B):
    """
        Multiply matrices A and B using a loop
    """
    n = len(A[0])
    C = np.zeros((n, n))
    for i in range(n):
        for j in range(n):
            for k in range(n):
                C[i, j] += A[i, k]*B[k, j]


if len(sys.argv) < 1:
    print('Usage:')
    print('     python ' + sys.argv[0] + ' N')
    print('Please specify matrix dimensions')
    sys.exit()

N = int(sys.argv[1])

print('Numba -- Matrix multiplication (loop): ', N)

A = np.random.rand(N, N)
B = np.random.rand(N, N)

matrix_multiplication(A, B)

print('  ')
