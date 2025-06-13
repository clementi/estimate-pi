(import :gerbil/gambit/random)

(export main)

(define (make-pairs pair-count limit)
  (if (zero? pair-count)
      '()
      (cons (make-pair limit)
            (make-pairs (- pair-count 1) limit))))

(define (make-pair limit)
  (cons (random-integer limit) (random-integer limit)))

(define (estimate-pi pair-count limit)
  (let* ((pairs (make-pairs pair-count limit))
           (coprime-count (length (filter coprime? pairs)))
           (probability (/ coprime-count pair-count))
           (estimate (sqrt (/ 6 probability))))
    (display "Estimate: ")
    (display estimate)
    (newline)
    estimate))

(define (coprime? pair)
  (let ((a (car pair))
        (b (cdr pair)))
    (= (gcd a b) 1)))

(define (average-estimates estimate-count pair-count limit)
  (let ((estimates (make-estimates estimate-count pair-count limit)))
    (/ (apply + estimates) (length estimates))))

(define (make-estimates estimate-count pair-count limit)
  (if (zero? estimate-count)
      '()
      (cons (estimate-pi pair-count limit)
            (make-estimates (- estimate-count 1) pair-count limit))))

(def (main . args)
  (let ((mean (average-estimates 100 1000000 (- (expt 2 31) 1))))
    (display "Mean: ")
    (display mean)
    (newline)))
