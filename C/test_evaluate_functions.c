
#include <sys/types.h>
#include <time.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>


int main(int argc, char* argv[]) {
    double *x;
    double *y;
    double h;
    double a_min = -1500.0;
    double a_max =  1500.0;
    int num_iterations = 10000;
    int n, i, j, k;
    clock_t start, finish; 
    double max_rand;

    // Get the dimension from the command line
    n = atoi(argv[1]);

    start = clock();

    // Allocate the array and fill it
    x = (double *) malloc(n * sizeof(double));
    y = (double *) malloc(n * sizeof(double));

    h = (a_max - a_min)/(n-1);
    for (i = 0; i < n; i++) {
        x[i] = a_min + i*h;
    }

    for (i = 0; i < num_iterations; i++) {
        for (j = 0; j < n; j++) {
            y[j] = sin(x[j]);
            x[j] = asin(y[j]);
            y[j] = cos(x[j]);
            x[j] = acos(y[j]);
            y[j] = tan(x[j]);
            x[j] = atan(y[j]);
        }
    }

    finish = clock();

    printf("Time Evaluate Function (%d): %lf s\n", n, (double) (finish - start)/CLOCKS_PER_SEC);	
    return 0;
}

