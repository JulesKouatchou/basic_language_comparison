#!/usr/bin/env python

from __future__ import print_function

import numpy as np
import sys
import benchmark_decorator as dectimer


@dectimer.bench_time(3)
def serial_copy(A):
    """
        Perform copies of elements in matrix A iteratively
    """
    N = A.shape[0]
    for i in range(N):
        for j in range(N):
            A[i, j, 0] = A[i, j, 1]
            A[i, j, 2] = A[i, j, 0]
            A[i, j, 1] = A[i, j, 2]


@dectimer.bench_time(3)
def vector_copy(A):
    """
        Perform copies of of elements in matrix A
        with vectorization
    """
    A[:, :, 0] = A[:, :, 1]
    A[:, :, 2] = A[:, :, 0]
    A[:, :, 1] = A[:, :, 2]


if len(sys.argv) < 1:
    print('Usage:')
    print('     python ' + sys.argv[0] + ' dimension')
    print('Please specify matrix dimensions')
    sys.exit()

dimension = int(sys.argv[1])

print("Copy of a matrix: ", dimension)

A = np.random.rand(dimension, dimension, 3)
serial_copy(A)

A = np.random.randn(dimension, dimension, 3)
vector_copy(A)

print(' ')
