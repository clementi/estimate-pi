using System;
using System.Collections.Generic;
using System.Linq;

var pairCount = 1_000_000;
var estimateCount = 100;

var coprimeCount = 0;

var estimateSum = 0.0;

var rng = new Random();

for (var i = 0; i < estimateCount; i++)
{
    coprimeCount = RandomPairs(rng).Take(pairCount).Where(Coprime).Count();
    var proportion = (double)coprimeCount / pairCount;
    var estimate = Math.Sqrt(6 / proportion);
    Console.WriteLine($"Estimate {i}: {estimate}");
    estimateSum += estimate;
    coprimeCount = 0;
}

Console.WriteLine($"Mean: {estimateSum / estimateCount}");

static IEnumerable<(uint, uint)> RandomPairs(Random rng)
{
    while (true)
        yield return ((uint)rng.Next(), (uint)rng.Next());
}

static bool Coprime((uint, uint) pair)
{
    var (a, b) = pair;
    return Gcd(a, b) == 1;
}

static uint Gcd(uint a, uint b)
{
    if (b == 0)
        return a;
    return Gcd(b, a % b);
}