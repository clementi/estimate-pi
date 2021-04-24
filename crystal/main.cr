def gcd(a, b)
  if b == 0
    a
  else
    gcd(b, a % b)
  end
end

pair_count = 1000000
estimate_count = 100

coprime_count = 0
estimate_sum = 0

limit = 1000000000

rng = Random.new

estimate_count.times do |i|
  pair_count.times do |j|
    if gcd(rng.rand(limit), rng.rand(limit)) == 1
      coprime_count += 1
    end
  end

  probability = coprime_count.to_f / pair_count.to_f
  estimate = Math.sqrt(6.0 / probability)
  puts "Estimate #{i}: #{estimate}\n"
  estimate_sum += estimate
  coprime_count = 0
end

puts "Mean: #{estimate_sum / estimate_count}"

