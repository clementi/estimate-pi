(define rng (java.util.Random:new))

(define random rng:nextInt)

(define (make-pair limit)
  (cons (random limit) (random limit)))

(define (estimate-pi pair-count limit)
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
                 (if (coprime? (make-pair limit)) 1 0))))))

(define (coprime? pair)
  (let ((a (car pair))
        (b (cdr pair)))
    (= (gcd a b) 1)))

(define (average-estimates estimate-count pair-count limit)
  (let loop ((remaining estimate-count)
             (sum 0.0))
    (if (zero? remaining)
        (/ sum estimate-count)
        (loop (- remaining 1)
              (+ sum (estimate-pi pair-count limit))))))

(let ((mean (average-estimates 100 1000000 1000000000)))
  (display "Mean: ")
  (display mean)
  (newline))
