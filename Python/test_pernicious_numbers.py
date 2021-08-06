#!/usr/bin/env python
"""
 Determine the nth pernicious number.

 http://www.rosettacode.org/wiki/Pernicious_numbers

"""

from __future__ import print_function
import sys
import benchmark_decorator as dectimer

def is_prime_number(n):
    """
      Deterine if a positive integer is prime or not.
    """
    if n in (2, 3):
        return True
    if 2 > n or 0 == n % 2:
        return False
    if 9 > n:
        return True
    if 0 == n % 3:
        return False
 
    return not any(map(
        lambda x: 0 == n % x or 0 == n % (2 + x),
        range(5, 1 + int(n ** 0.5), 6)
    ))

def get_number_of_ones(n): 
    """
      Deterine the number of 1s ins the binary representation of
      and integer n.
    """
    return bin(n).count("1")


@dectimer.bench_time(3)
def find_pernicious_numbers(n):
    """
       Find the nth pernicious number.
    """
    i = 1
    counter = 0
    while counter < n:
        if is_prime_number(get_number_of_ones(i)):
            counter += 1 
            #print(n, counter, i, get_number_of_ones(i))
        i += 1
    #print(i-1)
    return i-1, counter

N = int(sys.argv[1])
find_pernicious_numbers(N)

#print(vals)
