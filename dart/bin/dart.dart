import 'dart:math';

void main(List<String> arguments) {
  var limit = pow(2, 31).toInt() - 1;
  var random = Random();

  var pairCount = 1_000_000;
  var estimateCount = 100;

  var coprimeCount = 0;

  var estimateSum = 0.0;

  for (var i = 0; i < estimateCount; i++) {
    for (var j = 0; j < pairCount; j++) {
      if (coprime(random.nextInt(limit), random.nextInt(limit))) {
        coprimeCount++;
      }
    }
    var proportion = coprimeCount / pairCount;
    var estimate = sqrt(6 / proportion);
    print("Estimate $i: $estimate");
    estimateSum += estimate;
    coprimeCount = 0;
  }

  print("Mean: ${estimateSum / estimateCount}");
}

bool coprime(int a, int b) {
  return gcd(a, b) == 1;
}

int gcd(int a, int b) {
  if (b == 0) return a;
  return gcd(b, a % b);
}
