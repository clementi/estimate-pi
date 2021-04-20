# estimate-pi

## Introduction

This repository contains implementations in several programming languages of an algorithm to estimate the value of pi by using pseudorandom numbers. The algorithm is based on the process given by [Matt Parker of Standup Maths](https://www.youtube.com/watch?v=RZBhSi_PwHU).

[![Matt Parker](https://raw.githubusercontent.com/clementi/estimate-pi/master/matt-parker.png)](https://www.youtube.com/watch?v=RZBhSi_PwHU)

## The Algorithm

At a high level, the algorithm computes the average of 100 estimates of pi. The estimation algorithm is as follows:

```
* Generate 1000000 pairs of random "large" integers.
* Count how many of these pairs are coprime.
* Calculate the proportion of the pairs of random integers that are coprime.
  This is an estimate of the probability that two randomly selected "large"
  integers are coprime.
* Use the formula pi = sqrt(6 / probability) to calculate an estimate of pi.
```

In the implementations in this repository, the algorithm above comes in two general forms. First, there is the straightforward form that is best exemplified in the C example. This form utilizes mutable state, and it maps most directly to the algorithm described above. The other form is one that does not use mutable state, either because the language doesn't easily support it, such as the Haskell example, or the best practices of the language discourage the use of mutable state, or that the algorithm could be more naturally expressed in the language without using mutable state. I may produce versions in these languages that make use of mutable state, and I may make versions that are optimized for tail recursion, and see how the performance changes.

To determine coprimality, I used the language's built-in gcd function if it had one and I was aware of it; otherwise I supplied a simple recursive implementation, shown here in pseudocode:

```
function gcd(a, b)
    if b = 0
        return a
    else
        return gcd(b, a mod b)
```

For Javascript, I used this iterative version:

```
function gcd(a, b)
    while b ≠ 0
        t := b
        b := a mod b
        a := t
    return a
```

## Performance

As would be expected, there is a wide variance of performance with different languages. The chart below illustrates performance stats that I've gathered.

[![Performance stats](https://docs.google.com/spreadsheets/d/e/2PACX-1vR1SyRMrdmPEf6gXgfvdEXJqs6-sqIgpq3z3R6HXxoS10OLPprLmWWx8HZwLTrqLURx6pnthEDD45HB/pubchart?oid=1935298427&format=image)](https://docs.google.com/spreadsheets/d/1xdHP06eoPLs7hgXIyKkfdL_ETco1unpjLdVDoXO3nuY/edit?usp=sharing)

