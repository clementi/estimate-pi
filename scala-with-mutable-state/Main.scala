import scala.util.Random

object Main extends App {
  val limit = 1_000_000_000
  val pairCount = 1_000_000
  val estimateCount = 100

  var coprimeCount = 0

  var estimateSum = 0.0

  val rng = new Random

  for (i <- 0 until estimateCount) {
    for (j <- 0 until pairCount) {
      if (coprime(rng.nextInt(limit), rng.nextInt(limit))) {
        coprimeCount += 1
      }
    }
    val probability = coprimeCount.toDouble / pairCount
    val estimate = math.sqrt(6 / probability)
    println(s"Estimate $i: $estimate")
    estimateSum += estimate
    coprimeCount = 0
  }

  println(s"Mean: ${estimateSum / estimateCount}")


  private def coprime(pair: (Int, Int)): Boolean = pair match {
    case (a, b) => gcd(a, b) == 1
  }

  private def gcd: (Int, Int) => Int = {
    case (a, 0) => a
    case (a, b) => gcd(b, a % b)
  }
}
