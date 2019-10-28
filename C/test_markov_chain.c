#include <sys/types.h>
#include <time.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double f(double *x);

void mcmc(double *x, int N);

int main(int argc, char* argv[]) {
    double x[2];
    int N;
    int i, j, dim;
    clock_t start, finish;

    // Get the number of iterations from the command line
    N = atoi(argv[1]);

    srand(time(NULL));

    // Perform the Markov Chain operations
    start = clock();
    x[0] = 0.0;
    x[1] = 0.0;
    mcmc(x, N);
    finish = clock();

    printf("Time for belief calculations (%d): %lf s\n", N, (double) (finish - start)/CLOCKS_PER_SEC);
    return 0;
}

double f(double *x) {
    return exp(sin(x[0]*5) - x[0]*x[0] - x[1]*x[1]);
}

#define pi 3.141592653589793
void mcmc(double *x,int N){
    double p = f(x);
    int n;
    double x2[2];
    for(n=0; n<N; n++) {
        // run Box_Muller to get 2 normal random variables
        double U1 = ((double)rand())/RAND_MAX;
        double U2 = ((double)rand())/RAND_MAX;
        double R1 = sqrt(-2*log(U1))*cos(2*pi*U2);
        double R2 = sqrt(-2*log(U1))*sin(2*pi*U2);
        x2[0] = x[0] + .01*R1;
        x2[1] = x[1] + .01*R2;
        double p2 = f(x2);
        if(((double)rand())/RAND_MAX < p2/p) {
            x[0] = x2[0];
            x[1] = x2[1];
            p = p2;
        }
    }
}
