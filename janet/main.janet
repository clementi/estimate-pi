(defn gcd [a b]
  (if (= b 0)
    a
    (gcd b (% a b))))

(defn coprime? [a b]
  (= (gcd a b) 1))

(def pair-count 1000000)
(def estimate-count 100)
(def limit 1000000000)

(def rng (math/rng (os/time)))

(defn count-coprime []
  (var count 0)
  (for _ 0 pair-count
    (let [a (math/rng-int rng limit)
          b (math/rng-int rng limit)]
      (when (coprime? a b)
        (set count (+ count 1)))))
  count)

(var estimate-sum 0)

(for i 0 estimate-count
  (let [coprime-count (count-coprime)
        probability (/ (float coprime-count) pair-count)
        estimate (math/sqrt (/ 6 probability))]
    (print (string "Estimate " i ": " estimate))
    (set estimate-sum (+ estimate-sum estimate))))

(print (string "Mean: " (/ estimate-sum estimate-count)))
