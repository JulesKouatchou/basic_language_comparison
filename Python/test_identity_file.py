#!/usr/bin/env python


from __future__ import print_function

import sys
import os
import benchmark_decorator as dectimer

def reverse_list_strings(lines):
    """
      Reverse a list of strings:

        - First, reverse entries of the list.
        - Second, reverse each entry of the reversed list.
    """
    return [line[::-1] for line in lines[::-1]]

#--------------------------
# Function: identity_function_file
#--------------------------
@dectimer.bench_time(3)
def identity_function_file(file_name):
    """
       Read an entire file, complete reverse its content and reverse it back to
       obtain the original file content.
    """
    # Read the file to get its content as a list of lines.
    with open(file_name, "r") as file_id:
        lines = file_id.read().splitlines()

    return lines == reverse_list_strings(reverse_list_strings(lines))

    #rev_file_name = "rev_" + os.path.basename(file_name)
    #with open(rev_file_name, "w") as rev_file_id:
    #     rev_file_id.writelines("%s\n" % line[::-1] for line in lines[::-1])
         #lines = reverse_collection(lines)
         #for line in lines:
         #    rev_file_id.writelines(reverse_collection(line)+"\n")

if len(sys.argv) < 1:
    print('Usage:')
    print('     python ' + sys.argv[0] + ' file_name')
    print('Please specify the file name')
    sys.exit()

file_name = sys.argv[1]

identity_function_file(file_name)
