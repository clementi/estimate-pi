package main

import (
	"fmt"
	"math"
	"math/rand"
	"time"
)

func main() {
	pairCount := 1000000
	estimateCount := 100

	coprimeCount := 0

	estimateSum := 0.0

	rand.Seed(time.Now().UnixNano())

	for i := 0; i < estimateCount; i++ {
		for j := 0; j < pairCount; j++ {
			if coprime(rand.Uint64(), rand.Uint64()) {
				coprimeCount++
			}
		}

		probability := float64(coprimeCount) / float64(pairCount)
		estimate := math.Sqrt(6 / probability)
		fmt.Printf("Estimate %d: %.15f\n", i, estimate)
		estimateSum += estimate
		coprimeCount = 0
	}

	fmt.Printf("Mean: %.15f\n", estimateSum/float64(estimateCount))
}

func coprime(a, b uint64) bool {
	return gcd(a, b) == 1
}

func gcd(a, b uint64) uint64 {
	if b == 0 {
		return a
	}
	return gcd(b, a%b)
}
