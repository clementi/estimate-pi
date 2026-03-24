package main

import "core:fmt"
import "core:math"
import "core:math/rand"

main :: proc() {
    pair_count: int : 1_000_000
    estimate_count: int : 100

    coprime_count := 0

    estimate_sum := 0.0

    for i := 0; i < estimate_count; i += 1 {
        for j := 0; j < pair_count; j += 1 {
            a := rand.uint32()
            b := rand.uint32()
            if coprime(a, b) {
                coprime_count += 1
            }
        }
        proportion := f64(coprime_count) / f64(pair_count)
        estimate := math.sqrt(6.0 / proportion)
        fmt.printf("Estimate %d: %.15f\n", i, estimate)
        estimate_sum += estimate
        coprime_count = 0
    }

    fmt.printf("Mean: %.15f\n", estimate_sum / f64(estimate_count))
}

coprime :: proc(a: u32, b: u32) -> bool {
    return gcd(a, b) == 1
}

gcd :: proc(a: u32, b: u32) -> u32 {
    if b == 0 {
        return a
    }
    return gcd(b, a % b)
}
