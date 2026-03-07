const limit = 1_000_000_000;
const pairCount = 1_000_000;
const estimateCount = 100;

function randomInt(max: i32): i32 {
  return <i32>(Math.random() * <f64>max) + 1;
}

function gcd(a: i32, b: i32): i32 {
  return b === 0 ? a : gcd(b, a % b);
}

function coprime(a: i32, b: i32): boolean {
  return gcd(a, b) === 1;
}

let estimateSum = 0.0;

Math.seedRandom(123456789);

for (let i = 0; i < estimateCount; i++) {
  let coprimeCount = 0;

  for (let j = 0; j < pairCount; j++) {
    if (coprime(randomInt(limit), randomInt(limit))) {
      coprimeCount++;
    }
  }

  const probability: f64 = <f64>coprimeCount / <f64>pairCount;
  const estimate = Math.sqrt(6 / probability);

  console.log(`Estimate ${i}: ${estimate}`);

  estimateSum += estimate;
}

console.log(`Mean: ${estimateSum / estimateCount}`);
