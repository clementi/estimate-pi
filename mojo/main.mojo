import random
from math import sqrt
from memory import UnsafePointer


def main():
    var pair_count = 1_000_000
    var estimate_count = 100

    var estimate_sum = 0.0

    for i in range(estimate_count):
        var coprime_count = 0
        var limit = 2 ** 31 - 1

        for _ in range(pair_count):
            var a_ptr = UnsafePointer[Int32].alloc(1)
            var b_ptr = UnsafePointer[Int32].alloc(1)

            random.randint(a_ptr, 1, 1, limit)
            random.randint(b_ptr, 1, 1, limit)

            if coprime(a_ptr[], b_ptr[]):
                coprime_count += 1
        
        var proportion = coprime_count / pair_count
        var estimate = sqrt(6 / proportion)

        print("Estimate {}: {}".format(i, estimate))
        estimate_sum += estimate

    print("Mean: {}".format(estimate_sum / estimate_count))


def coprime(a: Int32, b: Int32) -> Bool:
    return gcd(a, b) == 1


def gcd(a: Int32, b: Int32) -> Int32:
    if b == 0:
        return a
    return gcd(b, a % b)
