module main

import std/num/float64
import std/num/random

fun gcd(a: int, b: int): div int
  if b == 0 then
    a
  else
    gcd(b, a % b)

fun coprime(a: int, b: int): div bool
  gcd(a, b) == 1

fun nextInt(a: int, c: int, m: int, seed: int): int
  (a * seed + c) % m

fun main()
  val pairCount = 1_000_000
  val estimateCount = 100
  
  var estimateSum := 0.0
  var coprimeCount := 0

  for(0, estimateCount - 1, fn (i) {
    for(0, pairCount - 1, fn (j) {
      val a = random-int()
      val b = random-int()
      if coprime(a, b) then
        coprimeCount := coprimeCount + 1
    })
    val proportion = (coprimeCount.float64 / pairCount.float64)
    val estimate = (6.0 / proportion).sqrt
    estimateSum := estimateSum + estimate
    coprimeCount := 0
    println("Estimate " ++ i.show ++ ": " ++ estimate.show)
  })

  println("Mean: " ++ (estimateSum / estimateCount.float64).show)
