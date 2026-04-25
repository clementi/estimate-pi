open System

let rec gcd a b =
    match b with
    | 0 -> a
    | c -> gcd c (a % c)

let coprime a b = gcd a b = 1

let rec countCoprime (rng: Random) pairCount acc =
    if pairCount = 0 then
        acc
    else
        let acc' = if coprime (rng.Next ()) (rng.Next ()) then acc + 1 else acc
        countCoprime rng (pairCount - 1) acc'

let estimatePi rng pairCount i =
    let coprimeCount = countCoprime rng pairCount 0
    let probability = double coprimeCount / double pairCount
    Math.Sqrt (6.0 / probability)

let rec sumEstimates rng i estimateCount pairCount acc =
    if estimateCount = 0 then
        acc
    else
        let estimate = estimatePi rng pairCount i
        printfn "Estimate %d: %0.15f" i estimate
        sumEstimates rng (i + 1) (estimateCount - 1) pairCount (acc + estimate)

[<EntryPoint>]
let main _ =
    let pairCount = 1_000_000
    let estimateCount = 100

    let rng = new Random ()
    let estimateSum = sumEstimates rng 0 estimateCount pairCount 0.0

    printfn "Mean: %0.15f" (estimateSum / double estimateCount)
    0
