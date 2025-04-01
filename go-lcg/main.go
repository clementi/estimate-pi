package main

import (
	"fmt"
	"math"
	"time"
)

type LCG struct {
	state uint32
}

const (
	multiplier uint32 = 1664525    //6364136223846793005
	increment  uint32 = 1013904223 //1442695040888963407
)

func (lcg *LCG) Next() uint32 {
	lcg.state = (multiplier*lcg.state + increment) % math.MaxInt32
	return lcg.state
}

func NewLCG(seed uint32) *LCG {
	return &LCG{state: seed}
}

func main() {
	pairCount := 1000000
	estimateCount := 100

	coprimeCount := 0

	estimateSum := 0.0

	lcg := NewLCG(uint32(time.Now().UnixNano()))

	for i := range estimateCount {
		for range pairCount {
			if coprime(lcg.Next(), lcg.Next()) {
				coprimeCount++
			}
		}

		probability := float64(coprimeCount) / float64(pairCount)
		estimate := math.Sqrt(6.0 / probability)
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
