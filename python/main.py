import math
import random

limit = 1000000000

def pairs(count):
    return map(lambda _: (random.randint(1, limit), random.randint(1, limit)) , range(count))

coprime_count = 0

pair_count = 1000000
estimate_count = 100

estimate_sum = 0

for i in range(0, estimate_count):
    for (a, b) in pairs(pair_count):
        if math.gcd(a, b) == 1:
            coprime_count += 1

    coprime_probability = coprime_count / pair_count

    estimate = math.sqrt(6 / coprime_probability)
    estimate_sum += estimate
    coprime_count = 0

    print(f"Estimate {i}: {estimate}")

average_estimate = estimate_sum / estimate_count

print(f"Mean: {average_estimate}")
