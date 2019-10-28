#!/usr/bin/env python

from __future__ import print_function

import numpy as np
import sys
import benchmark_decorator as dectimer

#--------------------------------
# Function: matrix_multiplication
#--------------------------------
@dectimer.bench_time(3)
def matrix_multiplication(A, B):
    """
        Evaluate the dot product of matrices A and B using numpy
    """
    C = np.dot(A, B)

if len(sys.argv) < 1:
    print('Usage:')
    print('     python ' + sys.argv[0] + ' N')
    print('Please specify matrix dimensions')
    sys.exit()

N = int(sys.argv[1])

print('Matrix multiplication: ', N)

A = np.random.rand(N, N)
B = np.random.rand(N, N)

matrix_multiplication(A, B)

print('  ')
