#include <sys/types.h>
#include <time.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

double** make_2d_array_double(int array_size_x, int array_size_y);

int main( int argc, char *argv[] ) {
    double **A, **B, **C;
    int i, j, k;
    int dim;
    clock_t start, finish; 

        dim = atoi(argv[1]);

        A = malloc(sizeof(double *) * dim);
        B = malloc(sizeof(double *) * dim);
        C = malloc(sizeof(double *) * dim);
        for (i = 0; i < dim; i++) {
            A[i] = malloc(sizeof(double) * dim);
            B[i] = malloc(sizeof(double) * dim);
            C[i] = malloc(sizeof(double) * dim);
        }

    double max_rand;

    srand(time(NULL));
    max_rand = (double)RAND_MAX;
    for (i = 0; i < dim; i++) {
        for (j = 0; j < dim; j++) {
            A[i][j] = rand()/max_rand;
            B[i][j] = rand()/max_rand;
        }
    }

    start = clock();

    for (i = 0; i < dim; i++) {
        for (j = 0; j < dim; j++) {
            C[i][j] = 0.;
        }
        for (k = 0; k < dim; k++) {
            for (j = 0; j < dim; j++) {
                C[i][j] += A[i][k]*B[k][j];
            }
        }
    }

    finish = clock();

    printf("time for C(%d,%d) = A(%d,%d) B(%d,%d) is %lf s\n", dim, dim, dim, dim, dim, dim,
           (double) (finish - start)/CLOCKS_PER_SEC);
    
    return 0;
}

double** make_2d_array_double(int array_size_x, int array_size_y) {
    double** array_double_2D;
    int i;
    array_double_2D = (double**) malloc(array_size_x*sizeof(double*));
    for (i = 0; i < array_size_x; i++) {
        array_double_2D[i] = (double*) malloc(array_size_y*sizeof(double));
    }
     return array_double_2D;
} 
