import math.sqrt
import scala.util.Random

object Main extends App {
  val pairCount = 1_000_000
  val estimateCount = 100

  val rng = new Random

  val estimates = LazyList.from(0)
    .take(estimateCount)
    .map(i => estimatePi(i, rng, pairCount))

  println(s"Mean: ${estimates.sum / estimateCount}")

  private def estimatePi(i: Int, rng: Random, pairCount: Int): Double = {
    val coprimeCount = countCoprime(rng, pairCount)
    val probability = coprimeCount.toDouble / pairCount
    val estimate = sqrt(6 / probability)
    println(s"Estimate $i: $estimate")
    estimate
  }

  private def countCoprime(rng: Random, pairCount: Int): Int = {
    if (pairCount == 0)
      0
    else if (coprime(rng.nextInt, rng.nextInt))
      1 + countCoprime(rng, pairCount - 1)
    else
      countCoprime(rng, pairCount - 1)
  }

  private def coprime(a: Int, b: Int): Boolean = gcd(a, b) == 1

  private def gcd: (Int, Int) => Int = {
    case (a, 0) => a
    case (a, b) => gcd(b, a % b)
  }
}
