use rand::prelude::*;

fn main() {
    let pair_count = 1_000_000;
    let estimate_count = 100;

    let mut coprime_count = 0;

    let mut estimate_sum = 0.0;

    let mut rng = rand::thread_rng();

    for i in 0..estimate_count {
        for _ in 0..pair_count {
            if coprime(rng.gen(), rng.gen()) {
                coprime_count += 1;
            }
        }
        let probability = coprime_count as f64 / pair_count as f64;
        let estimate = (6.0 / probability).sqrt();
        println!("Estimate {}: {}", i, estimate);
        estimate_sum += estimate;
        coprime_count = 0;
    }

    println!("Mean: {}", estimate_sum / estimate_count as f64)
}

fn coprime(a: u32, b: u32) -> bool {
    gcd(a, b) == 1
}

fn gcd(a: u32, b: u32) -> u32 {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}
