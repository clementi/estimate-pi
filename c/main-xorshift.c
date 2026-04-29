#include <math.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct {
    uint32_t a;
} Xorshift32State;

uint32_t next_uint32_t(Xorshift32State* state) {
    uint32_t x = state->a;
    x ^= x << 13;
    x ^= x >> 17;
    x ^= x << 5;
    return state->a = x;
}

uint32_t gcd(uint32_t a, uint32_t b) {
    if (b == 0)
        return a;
    return gcd(b, a % b);
}

bool coprime(uint32_t a, uint32_t b) {
    return gcd(a, b) == 1u;
}

int main(const int argc, const char** argv) {
    Xorshift32State state = {
        .a = time(NULL)
    };

    int pair_count = 1000000;
    int estimate_count = 100;

    int coprime_count = 0;

    double estimate_sum = 0.0;

    for (int i = 0; i < estimate_count; i++) {
        for (int j = 0; j < pair_count; j++) {
            if (coprime(next_uint32_t(&state), next_uint32_t(&state))) {
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
