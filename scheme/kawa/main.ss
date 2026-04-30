(define rng (java.util.Random:new))

(define random rng:nextInt)

(define (random-int32)
  (random java.lang.Integer:MAX_VALUE))

(define (estimate-pi pair-count)
  (let loop ((remaining pair-count)
             (coprime-count 0))
    (if (zero? remaining)
        (let* ((probability (/ coprime-count pair-count))
               (estimate (sqrt (/ 6 probability))))
          (display "Estimate: ")
          (display estimate)
          (newline)
          estimate)
        (loop (- remaining 1)
              (+ coprime-count
                 (if (coprime? (random-int32) (random-int32)) 1 0))))))

(define (coprime? a b)
  (= (gcd a b) 1))

(define (average-estimates estimate-count pair-count)
  (let loop ((remaining estimate-count)
             (sum 0.0))
    (if (zero? remaining)
        (/ sum estimate-count)
        (loop (- remaining 1)
              (+ sum (estimate-pi pair-count))))))

(let ((mean (average-estimates 100 1000000)))
  (display "Mean: ")
  (display mean)
  (newline))
