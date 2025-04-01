const std = @import("std");

pub fn main() !void {
    const pair_count: u32 = 1_000_000;
    const estimate_count: u32 = 100;

    var coprime_count: u32 = 0;
    var estimate_sum: f64 = 0.0;

    var rng = std.rand.DefaultPrng.init(std.time.nanoTimestamp());

    for (0..estimate_count) |i| {
        for (0..pair_count) |_| {
            if (coprime(rng.random(), rng.random())) {
                coprime_count += 1;
            }
        }
        const probability = @intToFloat(f64, coprime_count) / @intToFloat(f64, pair_count);
        const estimate = @sqrt(6.0 / probability);
        std.debug.print("Estimate {}: {}\n", .{i, estimate});
        estimate_sum += estimate;
        coprime_count = 0;
    }

    std.debug.print("Mean: {}\n", .{estimate_sum / @intToFloat(f64, estimate_count)});
}

fn coprime(a: u32, b: u32) bool {
    return gcd(a, b) == 1;
}

fn gcd(a: u32, b: u32) u32 {
    if (b == 0) {
        return a;
    } else {
        return gcd(b, a % b);
    }
}