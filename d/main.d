ulong gcd(ulong a, ulong b) {
    if (b == 0)
        return a;
    return gcd(b, a % b);
}

void main()
{
    import std.stdio : writefln;
    import std.random : Mt19937_64, unpredictableSeed;
    import std.math : sqrt;
    import std.conv : to;

    Mt19937_64 gen;
    gen.seed(unpredictableSeed!ulong);

    int pairCount = 1_000_000;
    int estimateCount = 100;
    int coprimeCount = 0;

    double estimateSum = 0.0;

    ulong a;
    ulong b;

    for (int i = 0; i < estimateCount; i++) {
        for (int j = 0; j < pairCount; j++) {
            a = gen.front;
            gen.popFront();

            b = gen.front;
            gen.popFront();

            if (gcd(a, b) == 1) {
                coprimeCount++;
            }
        }
        double probability = coprimeCount.to!double / pairCount.to!double;
        double estimate = sqrt(6.0 / probability);
        writefln("Estimate %d: %.15f", i, estimate);
        estimateSum += estimate;
        coprimeCount = 0;
    }

    writefln("Mean: %.15f", estimateSum / estimateCount);
}
