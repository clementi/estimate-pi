using System;
using System.Collections.Generic;
using System.Linq;

namespace csharp
{
    class Program
    {
        static void Main(string[] args)
        {
            int pairCount = 1_000_000;
            int estimateCount = 100;

            int coprimeCount = 0;

            double sum = 0.0;

            var rng = new Random();

            for (int i = 0; i < estimateCount; i++)
            {
                for (int j = 0; j < pairCount; j++)
                    if (Coprime((uint)rng.Next(), (uint)rng.Next()))
                        coprimeCount++;

                double probability = (double)coprimeCount / pairCount;
                double estimate = Math.Sqrt(6 / probability);
                Console.WriteLine("Estimate {0}: {1}", i, estimate);
                sum += estimate;
                coprimeCount = 0;
            }

            Console.WriteLine("Mean: {0}", sum / estimateCount);
        }

        private static bool Coprime(uint a, uint b) => Gcd(a, b) == 1;

        private static ulong Gcd(uint a, uint b)
        {
            if (b == 0)
                return a;
            return Gcd(b, a % b);
        }
    }
}
