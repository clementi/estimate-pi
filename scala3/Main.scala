import math.sqrt
import scala.util.Random

@main def main: Unit =
  val pairCount = 1_000_000
  val estimateCount = 100

  val rng = new Random

  val estimates = LazyList.from(0)
    .take(estimateCount)
    .map(i => estimatePi(i, rng, pairCount))

  println(s"Mean: ${estimates.sum / estimateCount}")

private def estimatePi(i: Int, rng: Random, pairCount: Int): Double =
  val coprimeCount = countCoprime(rng, pairCount)
  val probability = coprimeCount.toDouble / pairCount
  val estimate = sqrt(6 / probability)
  println(s"Estimate $i: $estimate")
  estimate

private def countCoprime(rng: Random, pairCount: Int): Int =
  LazyList.from(0)
    .take(pairCount)
    .map(_ => (rng.nextInt(Int.MaxValue), rng.nextInt(Int.MaxValue)))
    .filter(coprime)
    .size

private def coprime(a: Int, b: Int): Boolean = gcd(a, b) == 1

private def gcd: (Int, Int) => Int =
  case (a, 0) => a
  case (a, b) => gcd(b, a % b)
