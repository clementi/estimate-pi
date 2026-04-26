void main()
{
    import std.stdio : writefln;
    import std.random : Xorshift, unpredictableSeed;
    import std.math : sqrt;
    import std.numeric : gcd;
    import std.conv : to;

    Xorshift gen;
    gen.seed(unpredictableSeed!uint);

    int pairCount = 1_000_000;
    int estimateCount = 100;
    int coprimeCount = 0;

    double estimateSum = 0.0;

    uint a;
    uint b;

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
