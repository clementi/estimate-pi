open Random

val rng = Random.rand (1701, 1371)

val limit = 1000000000

fun gcd(a, 0) = a
  | gcd(a, b) = gcd (b, a mod b)

fun coprime(a, b) =
  gcd(a, b) = 1

fun babsqrt(x, guess) =
  if Real.abs(x - guess * guess) < x / 1000000.0 then
    guess
  else
    babsqrt(x, (guess + x / guess) / 2.0)

fun countCoprime(pairCount, acc) =
  if pairCount = 0 then acc
  else let val count = if coprime((Random.randInt rng) mod limit, (Random.randInt rng) mod limit) then 1 else 0
    in
      countCoprime(pairCount - 1, acc + count)
    end

fun estimatePi pairCount =
  let
    val coprimeCount = countCoprime(pairCount, 0)
    val proportion = (Real.fromInt coprimeCount) / (Real.fromInt pairCount)
  in
    babsqrt(6.0 / proportion, 0.608)
  end

fun sumEstimates(i, estimateCount, pairCount, acc) =
  if estimateCount = 0 then acc
  else let
    val estimate = estimatePi(pairCount)
    val _ = print("Estimate " ^ Int.toString(i) ^ ": " ^ Real.toString(estimate) ^ "\n")
      in sumEstimates(i + 1, estimateCount - 1, pairCount, estimate + acc)
    end

val estimateCount = 100
val pairCount = 1000000

val estimateSum = sumEstimates(0, estimateCount, pairCount, 0.0)
val _ = print("Mean: " ^ Real.toString (estimateSum / (Real.fromInt estimateCount)) ^ "\n")
