open System

let rec gcd a b =
    match b with
    | 0 -> a
    | c -> gcd c (a % c)

let coprime a b = gcd a b = 1

let estimatePi i (rng: Random) pairCount =
    let coprimeCount = seq { 0 .. pairCount - 1 } |> Seq.map (fun _ -> if coprime (rng.Next ()) (rng.Next ()) then 1 else 0) |> Seq.sum
    let probability = float coprimeCount / float pairCount
    let estimate = Math.Sqrt (6.0 / probability)
    printfn "Estimate %d: %f" i estimate
    estimate

[<EntryPoint>]
let main _ =
    let pairCount = 1_000_000
    let estimateCount = 100

    let rng = new Random ()
    let estimates = seq { 0 .. estimateCount - 1 } |> Seq.map (fun i -> estimatePi i rng pairCount)

    printfn "Mean: %f" ((Seq.sum estimates) / float estimateCount)
    0
