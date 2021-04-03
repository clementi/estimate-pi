using System;
using System.Collections.Generic;
using System.Linq;

namespace csharp
{
    class Program
    {
        static void Main(string[] args)
        {
            int pairCount = 1000000;
            int estimateCount = 100;

            double sum = 0.0;

            for (int i = 0; i < estimateCount; i++)
            {
                double estimate = EstimatePi(pairCount);
                Console.WriteLine("Estimate {0}: {1}", i, estimate);
                sum += estimate;
            }

            Console.WriteLine("Mean: {0}", sum / estimateCount);
        }

        private static double EstimatePi(int pairCount)
        {
            int coprimeCount = CreatePairs(pairCount)
                .Where(Coprime)
                .Count();

            double probability = (double) coprimeCount / pairCount;

            return Math.Sqrt(6 / probability);
        }

        private static bool Coprime((uint, uint) pair) => Gcd(pair.Item1, pair.Item2) == 1;

        private static ulong Gcd(uint a, uint b)
        {
            if (b == 0)
                return a;
            return Gcd(b, a % b);
        }

        private static IEnumerable<(uint, uint)> CreatePairs(int count)
        {
            var rng = new Random();

            for (int i = 0; i < count; i++)
                yield return ((uint) rng.Next(), (uint) rng.Next());
        }
    }
}
