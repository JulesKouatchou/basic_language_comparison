#!/usr/bin/env python

from __future__ import print_function

import numpy as np
import sys
import numba as nb
from numba import njit
from numba import prange
import benchmark_decorator as dectimer

#--------------------------------
# Function: matrix_multiplication
#--------------------------------
@dectimer.bench_time(3)
@njit(parallel=True)
def matrix_multiplication(A, B):
    """
        Multiply matrices A and B using a loop
    """
    m, n = A.shape
    p = B.shape[1]
    C = np.zeros((m, p))
    for i in prange(m):
        for j in prange(p):
            for k in prange(n):
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
