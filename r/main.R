gcd <- function(a, b) {
  while (any(b != 0L)) {
    nonzero <- b != 0L
    r <- a[nonzero] %% b[nonzero]
    a[nonzero] <- b[nonzero]
    b[nonzero] <- r
  }
  a
}

pair_count <- 1000000L
estimate_count <- 100L
estimate_sum <- 0

for (i in seq(0L, estimate_count - 1L)) {
  a <- sample.int(.Machine$integer.max, pair_count, replace = TRUE)
  b <- sample.int(.Machine$integer.max, pair_count, replace = TRUE)

  coprime_count <- sum(gcd(a, b) == 1L)
  probability <- coprime_count / pair_count
  estimate <- sqrt(6 / probability)

  cat(sprintf("Estimate %d: %.15f\n", i, estimate))
  estimate_sum <- estimate_sum + estimate
}

cat(sprintf("Mean: %.15f\n", estimate_sum / estimate_count))
