int gcd(int a, int b) {
    if (b == 0) a
    else gcd(b, a % b)
}

pairCount = 1000000
estimateCount = 100

coprimeCount = 0

estimateSum = 0.0

rng = new Random()

estimateCount.times {
    pairCount.times {
        if (gcd(rng.nextInt(Integer.MAX_VALUE), rng.nextInt(Integer.MAX_VALUE)) == 1)
            coprimeCount++
    }

    probability = coprimeCount / pairCount
    estimate = Math.sqrt(6.0 / probability)
    println("Estimate " + it + ": " + estimate)
    estimateSum += estimate
    coprimeCount = 0
}

println("Mean: " + estimateSum / estimateCount)
