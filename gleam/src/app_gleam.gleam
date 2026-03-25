import gleam/float
import gleam/int
import gleam/io
import gleam/result

pub fn main() -> Nil {
  let pair_count = 1_000_000
  let estimate_count = 3
  let limit = 1_000_000_000

  let estimate_sum = sum_estimates(estimate_count, pair_count, limit)

  io.println(
    "Mean: " <> float.to_string(estimate_sum /. int.to_float(estimate_count)),
  )
}

fn sum_estimates(estimate_count: Int, pair_count: Int, limit: Int) -> Float {
  case estimate_count {
    0 -> 0.0
    _ -> {
      let estimate = estimate_pi(pair_count, limit)
      io.println("Estimate: " <> float.to_string(estimate))
      estimate +. sum_estimates(estimate_count - 1, pair_count, limit)
    }
  }
}

fn estimate_pi(estimate_count: Int, limit: Int) -> Float {
  let coprime_count = count_coprime(estimate_count, limit)
  let proportion = int.to_float(coprime_count) /. int.to_float(estimate_count)
  float.square_root(6.0 /. proportion) |> result.unwrap(0.0)
}

fn count_coprime(count: Int, limit: Int) -> Int {
  case count {
    0 -> 0
    _ -> {
      case coprime(int.random(limit) + 1, int.random(limit) + 1) {
        True -> 1
        False -> 0
      }
      + count_coprime(count - 1, limit)
    }
  }
}

fn coprime(a: Int, b: Int) -> Bool {
  gcd(a, b) == 1
}

fn gcd(a: Int, b: Int) -> Int {
  case b {
    0 -> a
    c -> gcd(c, a % c)
  }
}
