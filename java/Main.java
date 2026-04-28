import java.util.Random;

class Xorshift32 {
    private int state;

    public Xorshift32(int state) {
        this.state = state;
    }

    public Xorshift32() {
        this((int) System.currentTimeMillis());
    }

    public int next() {
        var x = this.state;
        x ^= x >> 13;
        x ^= x << 17;
        x ^= x >> 5;
        return this.state = x;
    }
}

public class Main {
    public static void main(String[] args) {
        var pairCount = 1_000_000;
        var estimateCount = 100;

        var estimateSum = 0.0;

        var rng = new Xorshift32();

        for (var i = 0; i < estimateCount; i++) {
            var coprimeCount = 0;
            for (var j = 0; j < pairCount; j++) {
                if (coprime(rng.next(), rng.next())) {
                    coprimeCount++;
                }
            }
            var probability = (double) coprimeCount / pairCount;
            var estimate = Math.sqrt(6 / probability);

            System.out.printf("Estimate %d: %.15f%n", i, estimate);
            estimateSum += estimate;
        }

        System.out.printf("Mean: %.15f%n", estimateSum / estimateCount);
    }

    private static boolean coprime(int a, int b) {
        return gcd(a, b) == 1;
    }

    private static int gcd(int a, int b) {
        if (b == 0)
            return a;
        return gcd(b, a % b);
    }
}
