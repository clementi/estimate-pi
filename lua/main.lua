function gcd(a, b)
  if b == 0 then
    return a
  else
    return gcd(b, a % b)
  end
end

function coprime(a, b)
  return gcd(a, b) == 1
end

limit = 2^31 - 1

coprime_count = 0

pair_count = 1000000
estimate_count = 100

estimate_sum = 0

for i = 0,estimate_count-1,1 do
  for j = 0,pair_count-1,1 do
    if coprime(math.random(limit), math.random(limit)) then
      coprime_count = coprime_count + 1
    end
  end
  probability = coprime_count / pair_count

  estimate = math.sqrt(6 / probability)
  estimate_sum = estimate_sum + estimate

  coprime_count = 0

  print(string.format("Estimate %d: %.15f", i, estimate))
end

average_estimate = estimate_sum / estimate_count

print(string.format("Mean: %.15f", average_estimate))
