open System

let rec gcd a b =
    match b with
    | 0 -> a
    | c -> gcd c (a % c)

let coprime a b = gcd a b = 1

let countCoprime (rng: Random) =
    if coprime (rng.Next ()) (rng.Next ()) then
        1
    else
        0

let estimatePi (rng: Random) pairCount i =
    let coprimeCount = seq { 0 .. pairCount - 1 } |> Seq.map (fun _ -> countCoprime rng) |> Seq.sum
    let probability = double coprimeCount / double pairCount
    let estimate = Math.Sqrt (6.0 / probability)
    printfn "Estimate %d: %0.15f" i estimate
    estimate

[<EntryPoint>]
let main _ =
    let pairCount = 1_000_000
    let estimateCount = 100

    let rng = new Random ()
    let estimates = seq { 0 .. estimateCount - 1 } |> Seq.map (estimatePi rng pairCount)

    printfn "Mean: %0.15f" ((Seq.sum estimates) / double estimateCount)
    0
