(defun coprime-p (a b)
  "Check if A and B are coprime."
  (= (gcd a b) 1))

(defun estimate-pi ()
  "Estimate the value of Pi using the probability of two numbers being coprime."
  (let* ((pair-count 1000000)
         (estimate-count 100)
         (estimate-sum 0.0))
    (dotimes (i estimate-count)
      (let ((coprime-count 0)
            (limit (- (expt 2 31) 1)))
        (dotimes (j pair-count)
          (let ((a (random limit))
                (b (random limit)))
            (when (coprime-p a b)
              (incf coprime-count))))
        (let* ((probability (/ (float coprime-count) pair-count))
               (estimate (sqrt (/ 6 probability))))
          (format t "Estimate ~D: ~15,10F~%" i estimate)
          (setf estimate-sum (+ estimate-sum estimate)))))
    (format t "Mean: ~15,10F~%" (/ estimate-sum estimate-count))))

(funcall #'estimate-pi)
