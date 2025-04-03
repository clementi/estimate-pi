import random
from math import sqrt


def main():
    var pair_count = 1_000_000
    var estimate_count = 100

    var estimate_sum = 0.0

    for i in range(estimate_count):
        var coprime_count = 0

        for _ in range(pair_count):
            if coprime(random.random_ui64(1, UInt64.MAX), random.random_ui64(1, UInt64.MAX)):
                coprime_count += 1
        
        var proportion = coprime_count / pair_count
        var estimate = sqrt(6 / proportion)

        print("Estimate {}: {}".format(i, estimate))
        estimate_sum += estimate

    print("Mean: {}".format(estimate_sum / estimate_count))


def coprime(a: UInt64, b: UInt64) -> Bool:
    return gcd(a, b) == 1


def gcd(a: UInt64, b: UInt64) -> UInt64:
    if b == 0:
        return a
    return gcd(b, a % b)
