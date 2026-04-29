# estimate-pi

This repository contains implementations in several programming languages of a Monte Carlo algorithm to estimate the value of $\pi$ by using pseudorandom numbers. The algorithm is based on the process given by [Matt Parker of Standup Maths](https://www.youtube.com/watch?v=RZBhSi_PwHU).

[![Matt Parker](https://raw.githubusercontent.com/clementi/estimate-pi/master/matt-parker.png)](https://www.youtube.com/watch?v=RZBhSi_PwHU)

The formula for approximating $\pi$ that is used here is

```math
\pi = \sqrt{\frac{6}{p}} \: ,
```

where $p$ is the probability that two randomly selected large integers are coprime. (Our estimate is approximate because we are limited to finite-length integers (32 bits) and we make a finite sample of integer pairs.) Thus the probability of two randomly selected large integers being coprime is the [constant](https://oeis.org/A059956)

```math
\frac{6}{\pi^2} = 0.6079271019\dots.
```
Matt Parker explains the formula and gives a proof for it in the video above.

## The Algorithm

Each example computes the average of 100 estimates of $\pi$. The estimation algorithm comes in two forms: an iterative form and a recursive form (for languages like Haskell and Gleam).

### Iterative Version

```pseudocode
procedure main() do
    let pair_count = 1000000
    let estimate_count = 100
    let estimate_sum = 0.0

    for i = 0 to estimate_count do
        let coprime_count = 0
        for j = 0 to pair_count do
            if coprime(rand_int32(), rand_int32()) then
                coprime_count = coprime_count + 1
            end
            let proportion = coprime_count / estimate_count
            let estimate = sqrt(6.0 / proportion)
            print_newline("Estimate {i}: {estimate}")
            estimate_sum = estimate_sum + estimate
        end
    end

    let mean = estimate_sum / estimate_count
    print_newline("Mean: {mean})
end
```

### Recursive Version

```pseudocode
procedure main() do
    let pair_count = 1000000
    let estimate_count = 100
    let estimate_sum = sum_estimates(pair_count, estimate_count, 0.0)
    let mean = estimate_sum / estimate)count
    print_newline("Mean: {mean}")
end

function sum_estimates(pair_count, estimate_count, acc) do
    if estimate_count == 0 then
        return acc
    else
        let estimate = estimate_pi(pair_count)
        return sum_estimates(pair_count, estimate_count - 1, estimate + acc)
    end
end

function estimate_pi(pair_count) do
    let coprime_count = count_coprime(pair_count, acc)
    let proportion = coprime_count / pair_count
    return sqrt(6.0 / proportion)
end

function count_coprime(pair_count, acc) do
    if pair_count == 0 then
        return acc
    else
        let acc' = if coprime(rand_int32(), rand_int32()) then acc + 1 else acc
        return count_coprime(pair_count - 1, acc')
    end
end
```

To determine coprimality, I used the language's standard library `gcd` function if it existed and I was aware of it; otherwise I supplied a simple recursive implementation, shown here in pseudocode:

```pseudocode
function gcd(a, b) do
    if b == 0
        return a
    else
        return gcd(b, a mod b)
    end
end
```

To prevent stack overflow for certain languages, such as JavaScript and Nu, I used this iterative version:

```pseudocode
function gcd(a, b) do
    while b != 0
        t = b
        b = a mod b
        a = t
    end
    return a
end
```

## Random Integers

This exercise does not have terribly strict randomness requirements; a simple LCG or Xorshift are suitable. In many languages, I used the built-in random number generator, which is, in most cases, an LCG. I have also begun creating separate implementations that make use of Xorshift, and I may eventually convert all of them to use Xorshift for consistency.

The `rand_int32` function in the pseudocode above returns either a 32-bit signed or unsigned integer, depending on the language.

## Performance

As would be expected, there is a wide variance of performance with different languages. The chart below illustrates performance stats that I've gathered.

[![Performance stats](https://docs.google.com/spreadsheets/d/e/2PACX-1vR1SyRMrdmPEf6gXgfvdEXJqs6-sqIgpq3z3R6HXxoS10OLPprLmWWx8HZwLTrqLURx6pnthEDD45HB/pubchart?oid=1935298427&format=image)](https://docs.google.com/spreadsheets/d/1xdHP06eoPLs7hgXIyKkfdL_ETco1unpjLdVDoXO3nuY/edit?usp=sharing)

## AI Note

The vast majority of these implementations were done by me without the assistance of any LLM. Some of them&mdash;namely, Ada, Factor, Forth, Common Lisp, TypeScript, and Janet&mdash;were done by [Claude Code](https://claude.com/product/claude-code) as an exercise in using AI-assisted tools. Claude's implementations in Factor, Forth and Janet were faulty.
