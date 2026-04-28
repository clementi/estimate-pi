package main

import (
	"fmt"
	"math"
	"time"
)

type Xorshift32State struct {
	a uint32
}

func xorshift32(state *Xorshift32State) uint32 {
	x := state.a
	x ^= x >> 13
	x ^= x << 17
	x ^= x >> 5
	state.a = x
	return x
}

func main() {
	pairCount := 1000000
	estimateCount := 100

	coprimeCount := 0

	estimateSum := 0.0

	state := Xorshift32State{
		a: uint32(time.Now().UnixNano()),
	}

	for i := 0; i < estimateCount; i++ {
		for j := 0; j < pairCount; j++ {
			if coprime(xorshift32(&state), xorshift32(&state)) {
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

func coprime(a, b uint32) bool {
	return gcd(a, b) == 1
}

func gcd(a, b uint32) uint32 {
	if b == 0 {
		return a
	}
	return gcd(b, a%b)
}
