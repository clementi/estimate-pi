module estimate_pi;

import std::io;
import std::math;
import std::math::random;

fn void main()
{
    uint pairCount = 1_000_000;
    uint estimateCount = 100;

    uint limit = pow(2, 31);

    double estimateSum = 0.0;

    for (int i = 0; i < estimateCount; i++)
    {
        uint coprimeCount = 0;
        for (int j = 0; j < pairCount; j++)
        {
            if (coprime(rand(limit), rand(limit)))
            {
                coprimeCount += 1;
            }
        }
        double proportion = (double) coprimeCount / (double) pairCount;
        double estimate = math::sqrt(6.0 / proportion);
        io::printfn("Estimate %d: %.15f", i, estimate);
        estimateSum += estimate;
    }

    io::printfn("Mean: %.15f", estimateSum / estimateCount);
}

fn uint pow(uint base, uint expo)
{
    uint result = 1;
    for (int i = 0; i < expo; i++)
    {
        result *= base;
    }
    return result;
}

fn bool coprime(uint a, uint b)
{
    return math::gcd(a, b) == 1;
}
