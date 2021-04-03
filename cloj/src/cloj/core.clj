(ns cloj.core
  (:gen-class))

(defn make-pair [rng limit]
  (list (.nextInt rng limit)
        (.nextInt rng limit)))

(defn make-pairs [rng pair-count limit]
  (if (zero? pair-count)
    '()
    (cons (make-pair rng limit)
          (make-pairs rng (dec pair-count) limit))))

(defn gcd [a b]
  (if (zero? b)
    a
    (gcd b (mod a b))))

(defn coprime? [pair]
  (let [a (first pair)
        b (last pair)]
    (= (gcd a b) 1)))

(defn estimate-pi [rng pair-count limit]
  (let [pairs (make-pairs rng pair-count limit)
        coprime-count (count (filter coprime? pairs))
        probability (/ coprime-count pair-count)
        estimate (Math/sqrt (/ 6 probability))]
    (println "Estimate:" estimate)
    estimate))

(defn make-estimates [rng estimate-count pair-count limit]
  (if (zero? estimate-count)
    '()
    (cons (estimate-pi rng pair-count limit)
          (make-estimates rng (dec estimate-count) pair-count limit))))

(defn average-estimate [rng estimate-count pair-count limit]
  (let [estimates (make-estimates rng estimate-count pair-count limit)]
    (/ (apply + estimates) (count estimates))))

(defn -main []
  (let [rng (new java.util.Random)]
    (println "Mean:" (average-estimate rng 100 1000000 1000000000))))

