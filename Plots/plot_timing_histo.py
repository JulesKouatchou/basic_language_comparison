#!/usr/bin/env python

from __future__ import print_function

import numpy as np
import sys
import matplotlib.pyplot as plt
import matplotlib.pylab as pylab

params = {'legend.fontsize': 'x-large',
          'figure.figsize': (13, 6),
          'figure.autolayout': True,
         'axes.labelsize': 'x-large',
         'axes.titlesize':'x-large',
         'xtick.labelsize':'x-large',
         'ytick.labelsize':'x-large'}
pylab.rcParams.update(params)

month="Aug2021"

def get_timing(lang, test):
    result = None
    with open("../Results/timing_results_"+month+".txt", "r") as fid:
         lines = fid.readlines()
         for line in lines:
             if (lang in line) and (test in line):
                a, b, result = line.split(",")
                break
    return result

languages = ["C", "Fortran", "Python", "Numba", "Julia", "IDL", "Matlab", "R", "Java"]
#languages = ["C", "Fortran", "Python", "Numba", "Julia", "IDL", "Matlab", "R", "Java", "Scala"]

test_cases = ["copy_matrix", "look_and_say", "iterative_fibonacci", "recursive_fibonacci", "matrix_multiplication", "evaluate_functions", "belief_propagation", "markov_chain", "laplace_equation", "munchauser_number", "pernicious_number"]

num_lang = len(languages)
num_test = len(test_cases)

A = np.empty((num_lang,num_test,))
B = np.zeros((num_lang,num_test,))
A[:] = np.nan

i = 0
for lang in languages:
    j = 0
    for test in test_cases:
        result = get_timing(lang, test)
        if result:
           A[i,j] = float(result)
        j += 1
    i += 1

A = np.ma.masked_invalid(A)

for j in range(num_test):
    if A[0,j] == 0.0:
       A[:,j] = np.exp(A[:,j])
    else:
       coef = A[0,j]
       A[:,j] = A[:,j] / coef


data_sets = [A[j,:] for j in range(num_lang)]

colors = ["blue", "orange", "green", "yellow", "purple", "red", "pink", "olive", "brown", "gray", "lime"]
fig, ax = plt.subplots(figsize=(15.0, 7.0))
pos = np.arange(num_test)
bar_width = 0.085
i = 0
for a in data_sets:
    ax.bar(pos + (i+1)*bar_width, a, bar_width, color=colors[i])
    i += 1

plt.yscale('log')#, nonposy='clip')

ax.yaxis.grid()
#plt.legend(loc='best')
# Shrink current axis by 20%
box = ax.get_position()
ax.set_position([box.x0, box.y0, box.width * 0.8, box.height])

# Put a legend to the right of the current axis
ax.legend(languages, loc='center left', bbox_to_anchor=(1, 0.5))

#plt.legend(languages, loc='upper center')
ax.set_xticks(pos)
ax.set_xticklabels(test_cases, rotation=45)

plt.savefig("fig_languages_histo_"+month+".png", bbox_inches = "tight")
plt.show()
