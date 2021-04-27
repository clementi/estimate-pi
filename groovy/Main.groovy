int gcd(int a, int b) {
    if (b == 0) a
    else gcd(b, a % b)
}

limit = 1000000000
pairCount = 1000000
estimateCount = 100

coprimeCount = 0

estimateSum = 0.0

rng = new Random()

estimateCount.times {
    i = it
    pairCount.times {
        if (gcd(rng.nextInt(limit), rng.nextInt(limit)) == 1)
            coprimeCount++
    }

    probability = coprimeCount / pairCount
    estimate = Math.sqrt(6.0 / probability)
    println("Estimate " + i + ": " + estimate)
    estimateSum += estimate
    coprimeCount = 0
}

println("Mean: " + estimateSum / estimateCount)
