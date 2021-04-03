import scala.annotation.tailrec
import scala.util.Random

object Main extends App {
  val limit = 1000000000
  val pairCount = 1000000
  val estimateCount = 100

  val estimate = average(estimateCount, limit, pairCount)

  println(s"Mean: $estimate")

  private def estimatePi(limit: Int, pairCount: Int): Double = {
    val rng = new Random
    val coprimeCount = createPairs(pairCount, limit, rng)
      .filter(coprime)
      .length

    val probability = coprimeCount.toDouble / pairCount

    math.sqrt(6 / probability)
  }

  private def average(estimateCount: Int, limit: Int, pairCount: Int): Double = {
    val estimates = (0 until estimateCount).map { i =>
      val estimate = estimatePi(limit, pairCount)
      println(s"Estimate $i: $estimate")
      estimate
    }
    estimates.sum / estimates.length
  }

  private def coprime(pair: (Int, Int)): Boolean =
    gcd(pair._1, pair._2) == 1

  @tailrec
  private def gcd(a: Int, b: Int): Int = {
    if (b == 0) a
    else gcd(b, a % b)
  }

  private def createPairs(count: Int, limit: Int, rng: Random): LazyList[(Int, Int)] = {
    if (count == 0) LazyList.empty
    else createRandomPair(limit, rng) #:: createPairs(count - 1, limit, rng)
  }

  private def createRandomPair(limit: Int, rng: Random): (Int, Int) =
    (rng.nextInt(limit), rng.nextInt(limit))
}
