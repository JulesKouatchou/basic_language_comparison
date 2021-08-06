// **********************************************************
// Find the nth pernicious number.
//
// **********************************************************

#include <stdio.h>
#include <time.h>
 
typedef unsigned uint;
uint is_pernicious(uint n)
{
        uint c = 2693408940u; // int with all prime-th bits set
        while (n) c >>= 1, n &= (n - 1); // take out lowerest set bit one by one
        return c & 1;
}
 
int main(int argc, char* argv[]) {
    uint i, c;
    int n;
    clock_t start, finish;

    // Get a positive integer from the command line
    n = atoi(argv[1]);

    start = clock();
    for (i = c = 0; c < n; i++) {
        if (is_pernicious(i)) {
           ++c;
        }
    }
    finish = clock();
    printf("Pernicious number (%u): %lf s\n", i-1, (double) (finish - start)/CLOCKS_PER_SEC);

    return 0;
}
