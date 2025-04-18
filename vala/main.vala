class Program {
    public static void main(string[] args) {
        var pair_count = 1000000;
        var estimate_count = 100;

        var estimate_sum = 0.0;

        var random = new GLib.Rand();

        for (var i = 0; i < estimate_count; i++) {
            var coprime_count = 0;

            for (var j = 0; j < pair_count; j++) {
                if (coprime(random.next_int(), random.next_int())) {
                    coprime_count++;
                }
            }
            var proportion = (double)coprime_count / pair_count;
            var estimate = Math.sqrt(6.0 / proportion);

            stdout.printf("Estimate %d: %.15f\n", i, estimate);

            estimate_sum += estimate;
        }

        stdout.printf("Mean: %.15f\n", estimate_sum / estimate_count);
    }

    private static bool coprime(uint32 a, uint32 b) {
        return gcd(a, b) == 1;
    }

    private static uint32 gcd(uint32 a, uint32 b) {
        if (b == 0)
            return a;
        return gcd(b, a % b);
    }
}
