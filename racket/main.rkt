#lang racket

(define (make-pairs pair-count limit)
  (if (zero? pair-count)
      '()
      (cons (make-pair limit)
            (make-pairs (- pair-count 1) limit))))

(define (make-pair limit)
  (cons (random limit) (random limit)))

(define (estimate-pi pair-count limit)
  (letrec [(pairs (make-pairs pair-count limit))
           (coprime-count (length (filter coprime? pairs)))
           (probability (/ coprime-count pair-count))
           (estimate (sqrt (/ 6 probability)))]
    (printf "Estimate: ~a\n" estimate)
    estimate))

(define (coprime? pair)
  (let [(a (car pair))
        (b (cdr pair))]
    (= (gcd a b) 1)))

(define (average-estimates estimate-count pair-count limit)
  (let [(estimates (make-estimates estimate-count pair-count limit))]
    (/ (apply + estimates) estimate-count)))

(define (make-estimates estimate-count pair-count limit)
  (if (zero? estimate-count)
      '()
      (cons (estimate-pi pair-count limit)
            (make-estimates (- estimate-count 1) pair-count limit))))

(printf "Mean: ~a\n" (average-estimates 100 1000000 1000000000))
