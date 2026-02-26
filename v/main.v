import math
import rand

fn gcd(a u32, b u32) u32 {
	if b == 0 {
		return a
	}
	return gcd(b, a % b)
}

fn coprime(a u32, b u32) bool {
	return gcd(a, b) == 1
}

fn main() {
	pair_count := 1_000_000
	estimate_count := 100

	mut coprime_count := 0
	mut estimate_sum := 0.0

	for i in 0 .. estimate_count {
		coprime_count = 0

		for _ in 0 .. pair_count {
			if coprime(rand.u32(), rand.u32()) {
				coprime_count++
			}
		}

		probability := f64(coprime_count) / f64(pair_count)
		estimate := math.sqrt(6.0 / probability)
		println('Estimate ${i}: ${estimate}')
		estimate_sum += estimate
	}

	println('Mean: ${estimate_sum / f64(estimate_count)}')
}
