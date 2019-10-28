
#include <sys/types.h>
#include <time.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int raisedto(int n);

int main(int argc, char* argv[]) {
    int n, i, number;
    int power_of_digits[10];
    clock_t start, finish;

    srand(time(NULL));

    // Find the four Munchausen numbers
    start = clock();

    for (i=0; i<10; i++) {
        power_of_digits[i] = raisedto(i);
        // printf("%d %d \n", i, power_of_digits[i]);
    }

    n = 0;
    i = 0;

    while(n < 4) {
        int sum = 0;
        for (number = i; number > 0; number /= 10) {
            int digit = number % 10;
            // find the sum of the digits raised to themselves 
            sum += power_of_digits[digit];
        }
        if (sum == i) {
            n++;
            // the sum is equal to the number itself; 
            // thus it is a munchausen number
            printf("Munchausen number %i: %i\n", n, i);
        } 
        i++;
    }
    finish = clock();
    printf("Munchausen numbers: %lf s \n", (double) (finish - start)/CLOCKS_PER_SEC);
    
    return 0;
}

int raisedto(int n) {
    if(n == 0) {
        return(0);
    }
        else {
        return((int) pow(n, n));
    }
}
