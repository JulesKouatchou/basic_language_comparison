
// **********************************************************
// Given a nxnx3 matrix A, we want to perform the operations:
//
//       A[i][j][0] = A[i][j][1]
//       A[i][j][2] = A[i][j][0]
//       A[i][j][1] = A[i][j][2]
// **********************************************************

#include <sys/types.h>
#include <time.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

double*** make_3D_double_arr(int arr_size_x, int arr_size_y, int arr_size_z);

int main(int argc, char* argv[]) {
    double ***A;
    int dim, i, j, k;
    clock_t start, finish; 
    double max_rand;

    // Get the dimension from the command line
    dim = atoi(argv[1]);

    // Allocate the array and fill it
    A = (double ***) malloc(dim * sizeof(double **));
    for (i = 0; i < dim; i++) {
        A[i] = (double **) malloc(dim * sizeof(double *));
        for (j = 0; j < dim; j++) {
            A[i][j] = (double *) malloc(3 * sizeof(double));
        }
    }

    srand(time(NULL));
    max_rand = (double)RAND_MAX;
    for (i = 0; i < dim; i++) {
        for (j = 0; j < dim; j++) {
            for (k = 0; k < 3; k++) {
                A[i][j][k] = rand()/max_rand;
            }
        }
    }


    // Perform the copy operations
    start = clock();
    for (i = 0; i < dim; i++) {
        for (j = 0; j < dim; j++) {
                A[i][j][0] = A[i][j][1];
                A[i][j][2] = A[i][j][0];
                A[i][j][1] = A[i][j][2];
        }
    }
    finish = clock();

    printf("Time for matrix copy (%d): %lf s\n", dim, (double) (finish - start)/CLOCKS_PER_SEC);	
    return 0;
}

double*** make_3D_double_arr(int arr_size_x, int arr_size_y, int arr_size_z) {
    double*** double_array;
    int i, j;
    double_array = (double***) malloc(arr_size_x*sizeof(double**));
    for (i = 0; i < arr_size_x; i++) {
        double_array[i] = (double**) malloc(arr_size_y*sizeof(double*));
        for (j = 0; j < arr_size_y; i++) {
            double_array[i][j] = (double*) malloc(arr_size_z*sizeof(double));
        }
    }
     return double_array;
}
