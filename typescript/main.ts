const limit = 1_000_000_000;
const pairCount = 1_000_000;
const estimateCount = 100;

function randomInt(max: number): number {
  return Math.floor(Math.random() * max);
}

function gcd(a: number, b: number): number {
  return b === 0 ? a : gcd(b, a % b);
}

function coprime(a: number, b: number): boolean {
  return gcd(a, b) === 1;
}

let estimateSum = 0;

for (let i = 0; i < estimateCount; i++) {
  let coprimeCount = 0;

  for (let j = 0; j < pairCount; j++) {
    if (coprime(randomInt(limit), randomInt(limit))) {
      coprimeCount++;
    }
  }

  const probability = coprimeCount / pairCount;
  const estimate = Math.sqrt(6 / probability);

  console.log(`Estimate ${i}: ${estimate}`);

  estimateSum += estimate;
}

console.log(`Mean: ${estimateSum / estimateCount}`);
