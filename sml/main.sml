structure Xorshift32 = struct
  val seed = ref (0w42 : Word.word)

  fun scrubSeed s =
    if s = 0w0 then 0w1 else s

  fun next () : Word.word =
    let
      val x0 = !seed
      val x1 = Word.xorb (x0, Word.<< (x0, 0w13))
      val x2 = Word.xorb (x1, Word.>> (x1, 0w17))
      val x3 = Word.xorb (x2, Word.<< (x2, 0w5))
      val nextVal = scrubSeed x3
    in
      seed := nextVal;
      nextVal
    end

  fun setSeed n =
    seed := scrubSeed (Word.fromInt n)
end

fun gcd (a : Word.word, 0w0) = a
  | gcd (a : Word.word, b : Word.word) = gcd (b, Word.mod (a, b))

fun coprime (a : Word.word, b : Word.word) =
  gcd (a, b) = 0w1

fun babsqrt (x, guess) =
  if Real.abs (x - guess * guess) < x / 1000000.0 then
    guess
  else
    babsqrt (x, (guess + x / guess) / 2.0)

fun countCoprime (pairCount, acc) =
  if pairCount = 0 then
    acc
  else
    let
      val count = if coprime (Xorshift32.next (), Xorshift32.next ()) then 1 else 0
    in
      countCoprime (pairCount - 1, acc + count)
    end

fun estimatePi pairCount =
  let
    val coprimeCount = countCoprime (pairCount, 0)
    val proportion = Real.fromInt coprimeCount / Real.fromInt pairCount
  in
    babsqrt (6.0 / proportion, 0.608)
  end

fun sumEstimates (i, estimateCount, pairCount, acc) =
  if estimateCount = 0 then
    acc
  else
    let
      val estimate = estimatePi pairCount
      val _ = print ("Estimate " ^ Int.toString i ^ ": " ^ Real.toString estimate ^ "\n")
    in
      sumEstimates (i + 1, estimateCount - 1, pairCount, estimate + acc)
    end

val estimateCount = 100
val pairCount = 1000000

val estimateSum = sumEstimates (0, estimateCount, pairCount, 0.0)
val _ = print ("Mean: " ^ Real.toString (estimateSum / Real.fromInt estimateCount) ^ "\n")
