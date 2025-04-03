using System;
using System.Collections.Generic;
using System.Linq;

var pairCount = 1_000_000;
var estimateCount = 100;

var estimateSum = 0.0;

var rng = new Random();

for (var i = 0; i < estimateCount; i++)
{
    var coprimeCount = RandomPairs(rng)
        .Take(pairCount)
        .Where(pair => Coprime(pair.Item1, pair.Item2))
        .Count();
    var proportion = (double)coprimeCount / pairCount;
    var estimate = Math.Sqrt(6 / proportion);

    Console.WriteLine($"Estimate {i}: {estimate}");

    estimateSum += estimate;
}

Console.WriteLine($"Mean: {estimateSum / estimateCount}");

static IEnumerable<(uint, uint)> RandomPairs(Random rng)
{
    while (true)
        yield return ((uint)rng.Next(), (uint)rng.Next());
}

static bool Coprime(uint a, uint b) => Gcd(a, b) == 1;

static uint Gcd(uint a, uint b)
{
    if (b == 0)
        return a;
    return Gcd(b, a % b);
}