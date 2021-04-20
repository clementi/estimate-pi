# estimate-pi

## Introduction

This repository contains implementations in several programming languages of an algorithm to estimate the value of pi by using pseudorandom numbers. The algorithm is based on the process given by [Matt Parker of Standup Maths](https://www.youtube.com/watch?v=RZBhSi_PwHU).

[![Matt Parker](https://raw.githubusercontent.com/clementi/estimate-pi/master/matt-parker.png)](https://www.youtube.com/watch?v=RZBhSi_PwHU)

[![Performance stats](https://docs.google.com/spreadsheets/d/e/2PACX-1vR1SyRMrdmPEf6gXgfvdEXJqs6-sqIgpq3z3R6HXxoS10OLPprLmWWx8HZwLTrqLURx6pnthEDD45HB/pubchart?oid=1935298427&format=image)](https://docs.google.com/spreadsheets/d/1xdHP06eoPLs7hgXIyKkfdL_ETco1unpjLdVDoXO3nuY/edit?usp=sharing)

## The Algorithm

At a high level, the algorithm computes the average of 100 estimates of pi. The estimation algorithm is as follows:

```
* Generate 1000000 pairs of random "large" integers.
* Count how many of these pairs are coprime.
* Calculate the proportion of the pairs of random integers that are coprime. This will be an estimate of the probability that two randomly selected "large" integers are coprime.
* Use the theorem pi = sqrt(6 / probability) to estimate pi.
```
