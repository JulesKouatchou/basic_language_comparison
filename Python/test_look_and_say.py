#!/usr/bin/env python

from __future__ import print_function

import sys
import benchmark_decorator as dectimer

#--------------------------------
# Function: look_and_say_sequence
#--------------------------------
@dectimer.bench_time(3)
def look_and_say_sequence(starting_sequence, n):
    """
      Construct the look and say sequence of order n and starting 
      sequence starting_sequence (string)
    """
    i = 0

    while i < n:
        if i == 0:
            current_sequence = starting_sequence
        else:
            count = 1
            temp_sequence = ""
            for j in range(1, len(current_sequence)):
                if current_sequence[j] == current_sequence[j-1]:
                    count += 1
                else:
                    temp_sequence = temp_sequence + str(count) \
                                    + current_sequence[j-1]
                    count = 1
            temp_sequence = temp_sequence + str(count)\
                + current_sequence[len(current_sequence) - 1]

            current_sequence = temp_sequence
        i += 1
    return current_sequence


if len(sys.argv) < 2:
    print('Usage:')
    print('     python ' + sys.argv[0] + ' N')
    print('Please specify a number.')
    sys.exit()

N = int(sys.argv[1])

print('Look of say sequence of order: ', N)

seq = look_and_say_sequence("1223334444", N)

#print('Sequence of order ', N, ': ', seq)
print(' ')
