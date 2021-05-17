import scala.util.Random

@main def main: Unit =
  val limit = 1_000_000_000
  val pairCount = 1_000_000
  val estimateCount = 100

  val rng = new Random

  val estimate = average(rng, estimateCount, limit, pairCount)
  println(s"Mean: $estimate")

private def average(rng: Random, estimateCount: Int, limit: Int, pairCount: Int): Double =
  val estimates = (0 until estimateCount).map { i =>
    val estimate = estimatePi(rng, limit, pairCount)
    println(s"Estimate $i: $estimate")
    estimate
  }
  estimates.sum / estimateCount

private def estimatePi(rng: Random, limit: Int, pairCount: Int): Double =
  val coprimeCount = createPairs(rng, pairCount, limit)
    .filter(coprime)
    .length

  val probability = coprimeCount.toDouble / pairCount

  math.sqrt(6 / probability)

private def coprime(pair: (Int, Int)): Boolean = pair match
  case (a, b) => gcd(a, b) == 1

private def gcd: (Int, Int) => Int = {
  case (a, 0) => a
  case (a, b) => gcd(b, a % b)
}

private def createPairs(rng: Random, count: Int, limit: Int): LazyList[(Int, Int)] =
  if count == 0 then LazyList.empty
  else createRandomPair(rng, limit) #:: createPairs(rng, count - 1, limit)

private def createRandomPair(rng: Random, limit: Int): (Int, Int) =
  (rng.nextInt(limit), rng.nextInt(limit))

