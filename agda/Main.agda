module Main where

open import IO
open import Data.Nat using (ℕ; zero; suc; _+_; _%_; _==_)
open import Data.Nat.GCD using (gcd)
open import Data.Float using (Float; _÷_; _+_; show)
open import Data.Float.Extra using (sqrt)
open import System.Random using (randomRIO)
open import Data.String using (_++_)
open import Agda.Builtin.IO using (IO)

pairCount : ℕ
pairCount = 1000000

estimateCount : ℕ
estimateCount = 100

limit : ℕ
limit = 2147483647

coprime : ℕ → ℕ → Bool
coprime a b = gcd a b == 1

countCoprime : ℕ → IO ℕ
countCoprime zero    = return 0
countCoprime (suc n) = do
  a ← randomRIO (1 , limit)
  b ← randomRIO (1 , limit)
  rest ← countCoprime n
  if coprime a b then return (1 + rest) else return rest

estimatePi : ℕ → IO Float
estimatePi i = do
  k ← countCoprime pairCount
  let p = Data.Float.fromℕ k ÷ Data.Float.fromℕ pairCount
      e = sqrt (6.0 ÷ p)
  putStrLn ("Estimate " ++ show (Data.Float.fromℕ i) ++ ": " ++ show e)
  return e

sumEstimates : ℕ → IO Float
sumEstimates zero    = return 0.0
sumEstimates (suc n) = do
  e    ← estimatePi (estimateCount - suc n)
  rest ← sumEstimates n
  return (e Data.Float.+ rest)

main : Main
main = run do
  total ← sumEstimates estimateCount
  putStrLn ("Mean: " ++ show (total ÷ Data.Float.fromℕ estimateCount))
