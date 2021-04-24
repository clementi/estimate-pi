let limit = 100_000_0000

var coprimeCount = 0
let pairCount = 1_000_000
let estimateCount = 100

var estimateSum = 0.0

func gcd(_ a: Int, _ b: Int) -> Int {
    if (b == 0) {
        return a
    } else {
        return gcd(b, a % b)
    }
}

for i in 1...estimateCount {
    for _ in 1...pairCount {
        if gcd(Int.random(in: 1...limit), Int.random(in: 1...limit)) == 1 {
            coprimeCount += 1
        }
    }

    let probability = Double (coprimeCount) / Double (pairCount)
    let estimate = (6.0 / probability).squareRoot()
    estimateSum += estimate
    coprimeCount = 0

    print("Estimate \(i): \(estimate)")
}

print("Mean: \(estimateSum / Double (estimateCount))")
