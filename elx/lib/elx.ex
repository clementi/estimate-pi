defmodule Elx do
  def main(_args \\ []) do
    limit = 1000000000
    pairCount = 1000000
    estimateCount = 100

    estimate = average(estimateCount, limit, pairCount)

    IO.puts "Mean: #{estimate}"
  end

  def estimatePi(limit, pairCount) do
    coprimeCount = createPairs(pairCount, limit)
                   |> Enum.filter(&(coprime(&1)))
                   |> Enum.count
    probability = coprimeCount / pairCount
    :math.sqrt(6 / probability)
  end

  def average(estimateCount, limit, pairCount) do
    estimates = (1..estimateCount) |> Enum.map(fn _i ->
      estimate = estimatePi(limit, pairCount)
      IO.puts "Estimate: #{estimate}"
      estimate
    end)
    (estimates |> Enum.sum) / (estimates |> Enum.count)
  end

  def createPairs(count, limit) do
    if count == 0 do
      []
    else
      [{ :rand.uniform(limit), :rand.uniform(limit) } | createPairs(count - 1, limit)]
    end
  end

  def coprime({a, b}) do
    gcd(a, b) == 1
  end

  def gcd(a, b) do
    if b == 0 do
      a
    else
      gcd(b, rem(a, b))
    end
  end
end
