import math
import random
import itertools

limit: int = 2 ** 31 - 1

def pairs():
    while True:
        yield (random.randint(1, limit), random.randint(1, limit))

coprime_count: int = 0

pair_count: int = 1_000_000
estimate_count: int = 100

estimate_sum: float = 0

for i in range(0, estimate_count):
    coprime_count = sum(1 for (a, b) in itertools.islice(pairs(), pair_count) if math.gcd(a, b) == 1)
    coprime_probability = coprime_count / pair_count

    estimate = math.sqrt(6 / coprime_probability)
    estimate_sum += estimate
    coprime_count = 0

    print(f"Estimate {i}: {estimate}")

average_estimate = estimate_sum / estimate_count

print(f"Mean: {average_estimate}")
