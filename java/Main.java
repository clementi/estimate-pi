import java.util.Random;
import java.util.stream.Stream;

public class Main {
    public static void main(String[] args) {
        int limit = 1_000_000_000;

        int pairCount = 1_000_000;
        int estimateCount = 100;

        int coprimeCount = 0;

        double estimateSum = 0;

        Random rng = new Random();

        for (int i = 0; i < estimateCount; i++) {
            for (int j = 0; j < pairCount; j++) {
                if (coprime(rng.nextInt(limit), rng.nextInt(limit))) {
                    coprimeCount++;
                }
            }
            double probability = (double) coprimeCount / pairCount;
            double estimate = Math.sqrt(6 / probability);

            System.out.printf("Estimate %d: %.15f%n", i, estimate);
            estimateSum += estimate;

            coprimeCount = 0;
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
