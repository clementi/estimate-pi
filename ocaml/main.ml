let rec gcd a b =
  match b with
  | 0 -> a
  | _ -> gcd b (a mod b)

let coprime a b = gcd a b = 1

let randInt () = Random.int 1000000000

let rec countCoprime pairCount acc =
  match pairCount with
  | 0 -> acc
  | _ -> let count = if coprime (randInt ()) (randInt ()) then 1 else 0
         in countCoprime (pairCount - 1) (count + acc)

let rec estimatePi pairCount =
  let coprimeCount = countCoprime pairCount 0 in
  let proportion = (float coprimeCount) /. (float pairCount) in
  Float.sqrt (6.0 /. proportion)

let rec sumEstimates i estimateCount pairCount acc =
  match estimateCount with
  | 0 -> acc
  | _ -> let estimate = estimatePi pairCount in
         let _ = Printf.printf "Estimate %d: %.15f\n%!" i estimate in
         sumEstimates (i + 1) (estimateCount - 1) pairCount (estimate +. acc)

let _ =
  let _ = Random.self_init in
  let pairCount = 1000000 in
  let estimateCount = 100 in
  let estimateSum = sumEstimates 0 estimateCount pairCount 0.0
  in Printf.printf "Mean: %.15f\n%!" (estimateSum /. float estimateCount)
