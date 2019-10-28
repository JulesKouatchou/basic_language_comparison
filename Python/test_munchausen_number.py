#!/usr/bin/env python

from __future__ import print_function

import benchmark_decorator as dectimer

#---------------------------
# Function: raised_to_string
#---------------------------
def raised_to_string(x):
    """
        Convert to int, then raise the input to the power of itself.
    """
    x = int(x)
    if x == 0:
        return 0
    else:
        return x**x

#--------------------
# Function: raised_to
#--------------------
def raised_to(x):
    """
        Raise the input to the power of itself
    """
    if x == 0:
        return 0
    else:
        return x**x

power_of_digits = [raised_to(i) for i in range(10)]

#-------------------------------
# Function: is_munchausen_number
#-------------------------------
def is_munchausen_number(i):
    return i == sum(power_of_digits[int(x)] for x in str(i))

#----------------------------------
# Function: find_munchausen_numbers
#----------------------------------
@dectimer.bench_time(3)
def find_munchausen_numbers():
    """
        Find the 4 Munchausen numbers
    """
    number = 0
    i = 0
    while True:
        if is_munchausen_number(i):
            number += 1
            print("Munchausen number %d: %d" % (number, i))

        if (number == 4):
            break

        i += 1

#--------------------------------------
# Function: find_munchausen_numbers_map
#--------------------------------------
@dectimer.bench_time(3)
def find_munchausen_numbers_map():
    """
        Find the 4 Munchausen numbers using map()
    """
    num = 0
    i = 0
    while True:
        if i == sum(map(raised_to_string, str(i))):
            num += 1
            print("Munchausen number %d: %d" %(num, i))
        if (num == 4):
            break
        i += 1

find_munchausen_numbers()
#find_munchausen_numbers_map()
