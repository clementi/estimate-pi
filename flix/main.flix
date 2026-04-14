use List.range
use Math.Random;

def main(): Unit \ IO + Random =
    let pairCount = 1_000_000;
    let estimateCount = 100;
    let estimateSum = sumEstimates(0, estimateCount, pairCount, 0.0);
    println("Mean: " ++ Float64.toString(estimateSum / Int32.toFloat64(estimateCount)))

def sumEstimates(i: Int32, estimateCount: Int32, pairCount: Int32, acc: Float64): Float64 \ IO + Random =
    if (estimateCount == 0)
        acc
    else {
        let estimate = estimatePi(pairCount);
        println("Estimate " ++ Int32.toString(i) ++ ": " ++ Float64.toString(estimate));
        sumEstimates(i + 1, estimateCount - 1, pairCount, estimate + acc)
    }

def estimatePi(pairCount: Int32): Float64 \ Random =
    let coprimeCount = countCoprime(pairCount, 0);
    let proportion = Int32.toFloat64(coprimeCount) / Int32.toFloat64(pairCount);
    sqrt(6.0 / proportion)

def countCoprime(pairCount: Int32, acc: Int32): Int32 \ Random =
    let limit = 1_000_000_000;
    if (pairCount == 0)
        acc
    else {
        let toAdd = if (coprime(randInt32(limit), randInt32(limit))) 1
        else 0;
        countCoprime(pairCount - 1, toAdd + acc)
    }

def randInt32(limit: Int32): Int32 \ Random =
    Int64.truncateToInt32(Random.randomInt64()) `Int32.modulo` limit

def sqrt(x: Float64): Float64 = Float64.pow(base = x, 0.5)

def coprime(a: Int32, b: Int32): Bool = 
    gcd(a, b) == 1

def gcd(a: Int32, b: Int32): Int32 =
    if (b == 0) a
    else gcd(b, a `Int32.modulo` b)
