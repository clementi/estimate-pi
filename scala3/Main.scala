import math.sqrt
import scala.util.Random

@main def main: Unit =
  val limit = 1_000_000_000
  val pairCount = 1_000_000
  val estimateCount = 100

  val rng = new Random

  val estimates = LazyList.from(0)
    .take(estimateCount)
    .map(i => estimatePi(i, rng, limit, pairCount))

  println(s"Mean: ${estimates.sum / estimateCount}")
end main

private def estimatePi(i: Int, rng: Random, limit: Int, pairCount: Int): Double =
  val coprimeCount = countCoprime(rng, limit, pairCount)
  val probability = coprimeCount.toDouble / pairCount
  val estimate = sqrt(6 / probability)
  println(s"Estimate $i: $estimate")
  estimate

private def countCoprime(rng: Random, limit: Int, pairCount: Int): Int =
  if pairCount == 0 then
    0
  else if coprime(rng.nextInt(limit), rng.nextInt(limit)) then
    1 + countCoprime(rng, limit, pairCount - 1)
  else
    countCoprime(rng, limit, pairCount - 1)

private def coprime(a: Int, b: Int): Boolean = gcd(a, b) == 1

private def gcd: (Int, Int) => Int =
  case (a, 0) => a
  case (a, b) => gcd(b, a % b)
