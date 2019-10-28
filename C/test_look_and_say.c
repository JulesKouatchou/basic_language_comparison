#include <sys/types.h>
#include <time.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {
    char *a = malloc(2), *b = 0, *x, c;
    int count, n, iter = 1, len = 1;
    clock_t start, finish;

    n = atoi(argv[1]); // 10;
    iter = 0;

    srand(time(NULL));
    start = clock();
 
    for (sprintf(a, "1223334444"); (b = realloc(b, len * 2 + 1)); a = b, b = x) {
        iter++;
        x = a;
        for (len = 0, count = 1; (c = *a); ) {
            if (c == *++a) {
                count++;
            }
            else if (c) {
                len += sprintf(b + len, "%d%c", count, c);
                count = 1;
            }
        }
        if (iter == n)
              break;
    }

    finish = clock();
    // printf("sequence %s \n", x);

    printf("Time for look and say sequence (%d): %lf s\n", n, (double) (finish - start)/CLOCKS_PER_SEC);

    return 0;
}
