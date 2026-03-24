import "random" for Random

var pairCount = 1000000
var estimateCount = 100

var estimateSum = 0.0

var gcd = null
gcd = Fn.new {|a, b|
    if (b == 0) {
        return a
    }
    return gcd.call(b, a % b)
}

var coprime = Fn.new {|a, b| gcd.call(a, b) == 1}

var rng = Random.new()

for (i in 0...estimateCount) {
    var coprimeCount = 0
    for (j in 0...pairCount) {
        if (coprime.call(rng.int(), rng.int())) {
            coprimeCount = coprimeCount + 1
        }
    }
    var proportion = coprimeCount / pairCount
    var estimate = (6.0 / proportion).sqrt
    System.print("Estimate: %(i): %(estimate)")
    estimateSum = estimateSum + estimate
}

System.print("Mean: %(estimateSum / estimateCount)")

