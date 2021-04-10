let rec createPairs pairCount =
  match pairCount with
  | 0 -> []
  | _ -> (Random.int 1000000000, Random.int 1000000000) :: createPairs (pairCount - 1)

let rec gcd a b =
  match b with
  | 0 -> a
  | _ -> gcd b (a mod b)

let coprime (a, b) = gcd a b = 1

let estimatePi pairCount =
  let pairs = createPairs pairCount in
  let coprimeCount = List.length (List.filter coprime pairs) in
  let probability = (float coprimeCount) /. (float pairCount)
  in Float.sqrt (6.0 /. probability)

let estimateAndShow pairCount i =
  let estimate = estimatePi pairCount in
  let _ = Printf.printf ("Estimate %d: %f\n%!") i estimate
  in estimate

let rec makeEstimates estimateCount pairCount =
  match estimateCount with
  | 0 -> []
  | i -> estimateAndShow pairCount i :: makeEstimates (estimateCount - 1) pairCount

let averageEstimate estimateCount pairCount =
  let estimates = makeEstimates estimateCount pairCount
  in (List.fold_left (+.) 0.0 estimates) /. (float (List.length estimates))

let main () =
  let _ = Random.self_init in
  let pairCount = 1000000 in
  let estimateCount = 99 in
  let estimate = averageEstimate estimateCount pairCount
  in Printf.printf ("Mean: %f\n") estimate

let _ = main ()