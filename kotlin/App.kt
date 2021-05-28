import kotlin.math.sqrt
import kotlin.random.Random

fun main() {
    val limit = 1_000_000_000
    val pairCount = 1_000_000
    val estimateCount = 100

    var coprimeCount = 0

    var estimateSum = 0.0

    for (i in 0 until estimateCount) {
        for (j in 0 until pairCount) {
            if (coprime(Random.nextInt(limit), Random.nextInt(limit))) {
                coprimeCount++
            }
        }
        val probability = coprimeCount.toDouble() / pairCount
        val estimate = sqrt(6 / probability)
        println("Estimate $i: $estimate")
        estimateSum += estimate
        coprimeCount = 0
    }

    println("Mean: ${estimateSum / estimateCount}")
}

private fun coprime(a: Int, b: Int): Boolean = gcd(a, b) == 1

private fun gcd(a: Int, b: Int): Int {
    if (b == 0) {
        return a
    }
    return gcd(b, a % b)
}
