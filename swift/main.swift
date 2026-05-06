struct Xorshift64: RandomNumberGenerator {
    var state: UInt64
    init(seed: UInt64 = 12345) { state = seed }
    mutating func next() -> UInt64 {
        state ^= state << 13
        state ^= state >> 7
        state ^= state << 17
        return state
    }
}

func gcd(_ a: Int, _ b: Int) -> Int {
    var a = a, b = b
    while b != 0 {
        let t = b
        b = a % b
        a = t
    }
    return a
}

let limit = 1_000_000_000
let pairCount = 1_000_000
let estimateCount = 100
var estimateSum = 0.0

for i in 1...estimateCount {
    var rng = Xorshift64(seed: UInt64(i) &* 6364136223846793005)
    var coprimeCount = 0
    for _ in 1...pairCount {
        let a = Int(rng.next() % UInt64(limit)) + 1
        let b = Int(rng.next() % UInt64(limit)) + 1
        if gcd(a, b) == 1 {
            coprimeCount += 1
        }
    }

    let proportion = Double (coprimeCount) / Double (pairCount)
    let estimate = (6.0 / proportion).squareRoot()
    estimateSum += estimate
    coprimeCount = 0

    print("Estimate \(i): \(estimate)")
}

print("Mean: \(estimateSum / Double (estimateCount))")
