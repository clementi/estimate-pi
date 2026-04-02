#lang racket

;; This implementation makes use of for/fold instead of recursion and lists.

(define (coprime? a b)
  (= (gcd a b) 1))

(define (count-coprime pair-count limit)
  (for/fold ([coprime-count 0])
            ([i (range 0 pair-count)])
    (if (coprime? (random limit) (random limit))
        (add1 coprime-count)
        coprime-count)))

(define (estimate-pi trial pair-count limit)
  (let* ([proportion (/ (count-coprime pair-count limit) pair-count)]
         [estimate (sqrt (/ 6 proportion))])
    (printf "Estimate ~a: ~a\n" trial estimate)
    estimate))

(define (sum-estimates estimate-count pair-count limit)
  (for/fold ([estimate-sum 0])
            ([trial (range 0 estimate-count)])
    (+ estimate-sum (estimate-pi trial pair-count limit))))

(define (make-mean-estimate estimate-count pair-count limit)
  (let* ([estimate-sum (sum-estimates estimate-count pair-count limit)]
         [mean-estimate (/ estimate-sum estimate-count)])
    (printf "Mean: ~a\n" mean-estimate)))

(make-mean-estimate 100 1000000 (- (expt 2 31) 1))