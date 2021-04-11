function getRandomInt(limit) {
  limit = Math.ceil(limit);
  return Math.floor(Math.random() * limit);
}

function gcd(a, b) {
  var t;
  while (b != 0) {
    t = b;
    b = a % b;
    a = t;
  };
  return a;
}

function coprime(a, b) {
  return gcd(a, b) == 1;
}

var limit = 1000000000;
var pairCount = 1000000;
var estimateCount = 100;

var coprimeCount = 0;

var estimateSum = 0;

for (var i = 0; i < estimateCount; i++) {
  for (var j = 0; j < pairCount; j++) {
    if (coprime(getRandomInt(limit), getRandomInt(limit))) {
      coprimeCount++;
    }
  }

  var probability = coprimeCount / pairCount;
  var estimate = Math.sqrt(6 / probability);

  print("Estimate " + i + ": " + estimate);

  estimateSum += estimate;

  coprimeCount = 0;
}

var averageEstimate = estimateSum / estimateCount;
print("Mean: " + averageEstimate);

