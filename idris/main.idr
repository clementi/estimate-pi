module Main

import System.Random
import Data.String

pairCount : Nat
pairCount = 1000000

estimateCount : Nat
estimateCount = 100

limit : Int
limit = 2147483647

gcd : Int -> Int -> Int
gcd a 0 = a
gcd a b = gcd b (a `mod` b)

coprime : Int -> Int -> Bool
coprime a b = gcd a b == 1

countCoprime : Nat -> IO Int
countCoprime 0 = pure 0
countCoprime (S n) = do
  a <- randomRIO (1, limit)
  b <- randomRIO (1, limit)
  rest <- countCoprime n
  pure $ if coprime a b then rest + 1 else rest

estimatePi : Nat -> IO Double
estimatePi i = do
  k <- countCoprime pairCount
  let p = cast k / cast pairCount
      e = sqrt (6.0 / p)
  putStrLn $ "Estimate " ++ show i ++ ": " ++ show e
  pure e

sumEstimates : Nat -> IO Double
sumEstimates 0 = pure 0.0
sumEstimates (S n) = do
  e    <- estimatePi (estimateCount `minus` S n)
  rest <- sumEstimates n
  pure (e + rest)

main : IO ()
main = do
  total <- sumEstimates estimateCount
  putStrLn $ "Mean: " ++ show (total / cast estimateCount)
