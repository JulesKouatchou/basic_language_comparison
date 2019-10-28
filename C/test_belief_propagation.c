
#include <sys/types.h>
#include <time.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

const int Dim = 1000;

void belief_propagation(double A[Dim][Dim], double x[Dim], int N);

int main(int argc, char* argv[]) {
    double A[Dim][Dim];
    double x[Dim];
    double max_rand;
    int N, i, j, Dim;
    clock_t start, finish;

    // Get the number of iterations from the command line
    N = atoi(argv[1]);

    srand(time(NULL));
    start = clock();

    max_rand = (double)RAND_MAX;
    for (i = 0; i < Dim; i++) {
            x[i] = 1.0;
            for (j = 0; j < Dim; j++)
                A[i][j] = rand()/max_rand;
    }

    // Perform the belief operations
    belief_propagation( A, x, N);
    finish = clock();

    printf("Time for Belief Propagation (%d): %lf s\n", N, (double) (finish - start)/CLOCKS_PER_SEC);  
    return 0;
}

void belief_propagation(double A[Dim][Dim], double x[Dim], int N) {
    int i, k, j;
    double x2[Dim];
    for (k=0; k<N; k++) {
        for (i=0; i<Dim; i++) {
            x2[i]=0;
            for (j=0; j<Dim; j++) {
                x2[i] += A[i][j]*exp(x[j]);
            }
        }
        for (i=0; i<Dim; i++) {
            x[i]=log(x2[i]);
        }
        double mysum = 0;
        for (i=0; i<Dim; i++) {
            mysum += exp(x[i]);
        }
        double mynorm = log(mysum);
        for (i=0; i<Dim; i++) {
            x[i] -= mynorm;
        }
    }
    return;
}
