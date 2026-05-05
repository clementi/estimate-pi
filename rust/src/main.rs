use num_integer;

struct Xorshift32 {
    a: u32,
}

impl Xorshift32 {
    fn next(&mut self) -> u32 {
        let mut x = self.a;
        x ^= x << 13;
        x ^= x >> 17;
        x ^= x << 5;
        self.a = x;
        x
    }
}

fn main() {
    let pair_count = 1_000_000;
    let estimate_count = 100;

    let mut coprime_count = 0;
    let mut estimate_sum = 0.0;

    let mut rng = Xorshift32 { a: 1701 };

    for i in 0..estimate_count {
        for _ in 0..pair_count {
            if coprime(rng.next(), rng.next()) {
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
    num_integer::gcd(a, b) == 1
}
