#lang racket

(define (coprime? a b)
  (= (gcd a b) 1))

(define estimate-count 100)
(define pair-count 1000000)

(define limit (- (expt 2 31) 1))

(define (count-coprime trials)
  (for/fold ([coprime-count 0])
            ([i (range 0 trials)])
    (if (coprime? (random limit) (random limit))
        (add1 coprime-count)
        coprime-count)))

(define (estimate-pi trial)
  (let* ([proportion (/ (count-coprime pair-count) pair-count)]
         [estimate (sqrt (/ 6 proportion))])
    (printf "Estimate ~a: ~a\n" trial estimate)
    estimate))

(define (sum-estimates)
  (for/fold ([estimate-sum 0])
            ([trial (range 0 estimate-count)])
    (+ estimate-sum (estimate-pi trial))))

(define (make-estimates)
  (let* ([estimate-sum (sum-estimates)]
         [mean-estimate (/ estimate-sum estimate-count)])
    (printf "Mean: ~a\n" mean-estimate)))

(make-estimates)