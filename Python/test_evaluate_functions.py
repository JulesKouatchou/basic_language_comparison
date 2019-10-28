#!/usr/bin/env python

from __future__ import print_function

import numpy as np
import sys
import benchmark_decorator as dectimer

#-----------------------------
# Function: evaluate_functions
#-----------------------------
@dectimer.bench_time(3)
def evaluate_functions(n):
    """
        Evaluate the trigononmetric functions for n values evenly
        spaced over the interval [-1500.00, 1500.00]
    """
    vector1 = np.linspace(-1500.00, 1500.0, n)
    iterations = 10000
    for i in range(iterations):
        vector2 = np.sin(vector1)
        vector1 = np.arcsin(vector2)
        vector2 = np.cos(vector1)
        vector1 = np.arccos(vector2)
        vector2 = np.tan(vector1)
        vector1 = np.arctan(vector2)

n = int(sys.argv[1])

print('Evaluate Function: ', n)

evaluate_functions(n)

print(' ')
