import math
import random
import strformat
from times import getTime, toUnix, nanosecond

proc coprime(a, b: int): bool =
  gcd(a, b) == 1

proc getNanos(): int64 =
  let now = getTime()
  now.toUnix * 1_000_000_000 + now.nanosecond

let limit = 1_000_000_000
let pairCount = 1_000_000
let estimateCount = 100
var coprimeCount = 0

var estimateSum: float64 = 0.0

var r = initRand(getNanos())

for i in 0 .. estimateCount - 1:
  for j in 0 .. pairCount - 1:
    if coprime(r.rand(limit) + 1, r.rand(limit) + 1):
      coprimeCount += 1

  var probability = coprimeCount / pairCount
  var estimate = sqrt(6.0 / probability)
  echo fmt"Estimate {i}: {estimate}"
  estimateSum += estimate
  coprimeCount = 0

echo fmt"Mean: {estimateSum / float64(estimateCount)}"
