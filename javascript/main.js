function getRandomInt(limit) {
  limit = Math.ceil(limit);
  return Math.floor(Math.random() * limit);
}

function gcd(a, b) {
  let t;
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

const limit = 1000000000;
const pairCount = 1000000;
const estimateCount = 100;

let coprimeCount = 0;

let estimateSum = 0;

for (let i = 0; i < estimateCount; i++) {
  for (let j = 0; j < pairCount; j++) {
    if (coprime(getRandomInt(limit), getRandomInt(limit))) {
      coprimeCount++;
    }
  }

  let probability = coprimeCount / pairCount;
  let estimate = Math.sqrt(6 / probability);

  console.log(`Estimate ${i}: ${estimate}`);

  estimateSum += estimate;

  coprimeCount = 0;
}

let averageEstimate = estimateSum / estimateCount;
console.log(`Mean: ${averageEstimate}`);

