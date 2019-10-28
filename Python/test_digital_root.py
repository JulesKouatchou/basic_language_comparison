#!/usr/bin/env python

from __future__ import print_function

import sys
import benchmark_decorator as dectimer


@dectimer.bench_time(3)
def compute_digital_root(n):
    """
      Compute the digital root of the number n
    """
    # If num is 0.
    if (n == "0"):
        return 0

    # Count sum of digits under mod 9
    answer = 0
    for i in range(0, len(n)):
        answer = (answer + int(n[i])) % 9

    # If digit sum is multiple of 9, answer
    # 9, else remainder with 9.
    if(answer == 0):
        return 9
    else:
        return answer % 9


if len(sys.argv) < 2:
    print('Usage:')
    print('     python ' + sys.argv[0] + ' N')
    print('Please specify a number.')
    sys.exit()

# N = int(sys.argv[1])
N = sys.argv[1]

print('Digital root of : ', N)

compute_digital_root(N)

print(' ')
