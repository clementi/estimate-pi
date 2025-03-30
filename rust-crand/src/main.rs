use std::ffi::c_long;

extern "C" {
    fn rand() -> c_long;
    fn srand(seed: c_long);
    fn time(t: *mut c_long) -> c_long;
}

fn main() {
    let pair_count = 1_000_000;
    let estimate_count = 100;

    let mut coprime_count = 0;

    let mut estimate_sum = 0.0;

    unsafe {
        srand(time(std::ptr::null_mut()));

        for i in 0..estimate_count {
            for _ in 0..pair_count {
                if coprime(rand(), rand()) {
                    coprime_count += 1;
                }
            }
            let probability = coprime_count as f64 / pair_count as f64;
            let estimate = (6.0 / probability).sqrt();
            println!("Estimate {}: {}", i, estimate);
            estimate_sum += estimate;
            coprime_count = 0;
        }
    }
    println!("Mean: {}", estimate_sum / estimate_count as f64)
}

fn coprime(a: i64, b: i64) -> bool {
    gcd(a, b) == 1
}

fn gcd(a: i64, b: i64) -> i64 {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}
