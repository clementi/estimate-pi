(ns cloj.core
  (:gen-class))

(defn incif [n predicate]
  (if predicate
    (inc n)
    n))

(defn gcd [a b]
  (if (zero? b)
    a
    (gcd b (mod a b))))

(defn coprime? [a b]
  (= (gcd a b) 1))

(defn rand-int32 []
  (rand-int Integer/MAX_VALUE))

(defn count-coprime [pair-count acc]
  (if (zero? pair-count)
    acc
    (let [acc' (incif acc (coprime? (rand-int32) (rand-int32)))]
      (count-coprime (dec pair-count) acc'))))

(defn estimate-pi [pair-count]
  (let [coprime-count (count-coprime pair-count 0)
        proportion (/ coprime-count pair-count)]
    (Math/sqrt (/ 6 proportion))))

(defn sum-estimates [i estimate-count pair-count acc]
  (if (zero? estimate-count)
    acc
    (let [estimate (estimate-pi pair-count)]
      (printf "Estimate %d: %.15f\n" i estimate)
      (flush)
      (sum-estimates (inc i) (dec estimate-count) pair-count (+ estimate acc)))))

(defn -main []
  (let [pair-count 1000000
        estimate-count 100
        estimate-sum (sum-estimates 0 estimate-count pair-count 0.0)]
    (println "Mean:" (/ estimate-sum estimate-count))))
