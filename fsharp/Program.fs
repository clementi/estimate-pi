open System

let createRandomPair (rng: Random) =
    (rng.Next (), rng.Next ())

let rec createPairs pairCount rng =
    seq { 0 .. pairCount - 1 } |> Seq.map (fun _ -> createRandomPair rng) |> Seq.toList

let rec gcd a b =
    match b with
    | 0 -> a
    | c -> gcd c (a % c)

let coprime (a, b) = gcd a b = 1

let estimatePi pairCount =
    let rng = new Random ()
    let pairs = createPairs pairCount rng
    let coprimeCount = pairs |> List.filter coprime |> List.length
    let probability = float coprimeCount / float pairCount
    Math.Sqrt (6.0 / probability)

let estimateAndShow pairCount i =
    let estimate = estimatePi pairCount
    printfn "Estimate %d: %f" i estimate
    estimate

let averageEstimate estimateCount pairCount =
    let estimates = seq { 0 .. estimateCount - 1 } |> Seq.toList |> List.map (estimateAndShow pairCount)
    float (List.sum estimates) / float estimateCount

[<EntryPoint>]
let main _ =
    let pairCount = 1000000
    let estimateCount = 100
    let estimate = averageEstimate estimateCount pairCount
    printfn "Mean: %f" estimate
    0
