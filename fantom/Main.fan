class Main {
  static Void main() {
    pairCount := 1_000_000
    estimateCount := 100
    limit := 2.pow(31) - 1

    estimateSum := 0.0d

    for (i := 0; i < estimateCount; i++) {
      coprimeCount := 0
      for (j := 0; j < pairCount; j++) {
        if (coprime(Int.random(1..limit), Int.random(1..limit))) {
          coprimeCount++
        }
      }
      probability := coprimeCount.toFloat / pairCount
      estimate := (6 / probability).sqrt

      echo("Estimate $i: ${estimate}")
      estimateSum += estimate
    }

    echo("Mean: ${(estimateSum / estimateCount)}")
  }

  private static Bool coprime(Int a, Int b) {
    return gcd(a, b) == 1
  }

  private static Int gcd(Int a, Int b) {
    if (b == 0) return a
    return gcd(b, a % b)
  }
}