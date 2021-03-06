#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

unsigned int gcd(unsigned int a, unsigned int b) {
    if (b == 0)
        return a;
    return gcd(b, a % b);
}

bool coprime(unsigned int a, unsigned int b) {
    return gcd(a, b) == 1u;
}

int main(const int argc, const char** argv) {
    srand(time(NULL));

    int pair_count = 1000000;
    int estimate_count = 100;

    int coprime_count = 0;

    double estimate_sum = 0.0;

    for (int i = 0; i < estimate_count; i++) {
        for (int j = 0; j < pair_count; j++) {
            if (coprime(rand(), rand())) {
                coprime_count++;
            }
        }
        double probability = (double) coprime_count / pair_count;
        double estimate = sqrt(6.0 / probability);
        printf("Estimate %d: %.15lf\n", i, estimate);
        estimate_sum += estimate;
        coprime_count = 0;
    }

    printf("Mean: %.15lf\n", estimate_sum / estimate_count);

    return EXIT_SUCCESS;
}
