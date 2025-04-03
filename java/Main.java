import java.util.Random;

public class Main {
    public static void main(String[] args) {
        var pairCount = 1_000_000;
        var estimateCount = 100;

        var estimateSum = 0.0;

        var rng = new Random();

        for (var i = 0; i < estimateCount; i++) {
            var coprimeCount = 0;
            for (var j = 0; j < pairCount; j++) {
                if (coprime(rng.nextInt(Integer.MAX_VALUE), rng.nextInt(Integer.MAX_VALUE))) {
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
