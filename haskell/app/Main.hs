{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE NumericUnderscores #-}

module Main (main) where

import Data.Int (Int32)
import Data.Bits (shiftL, shiftR, xor)
import Random.Xorshift.Int32 (Xorshift32 (Xorshift32), newXorshift32)
import Text.Printf

main :: IO ()
main = do
  let pairCount = 1_000_000
      estimateCount = 100
  g0 <- newXorshift32
  estimateSum <- sumEstimates 0 estimateCount pairCount g0 0.0
  printf "Mean: %f\n" (estimateSum / fromIntegral estimateCount)
  
sumEstimates :: Int32 -> Int32 -> Int32 -> Xorshift32 -> Double -> IO Double
sumEstimates _ 0 _ _ !acc = return acc
sumEstimates i estimateCount pairCount g !acc = do
  let (estimate, g1) = estimatePi pairCount g
      !acc' = acc + estimate
  printf "Estimate %d: %f\n" i estimate
  sumEstimates (i + 1) (estimateCount - 1) pairCount g1 acc'

estimatePi :: Int32 -> Xorshift32 -> (Double, Xorshift32)
estimatePi pairCount g =
  let (coprimeCount, g1) = countCoprime pairCount 0 g
      proportion = fromIntegral coprimeCount / fromIntegral pairCount
   in (sqrt (6.0 / proportion), g1)

countCoprime :: Int32 -> Int32 -> Xorshift32 -> (Int32, Xorshift32)
countCoprime 0 !acc g = (acc, g)
countCoprime pairCount !acc g =
  let (n1, g1) = nextInt32 g
      (n2, g2) = nextInt32 g1
      !acc' = acc + if coprime n1 n2 then 1 else 0
   in countCoprime (pairCount - 1) acc' g2

nextInt32 :: Xorshift32 -> (Int32, Xorshift32)
nextInt32 (Xorshift32 x0) =
  let x1 = x0 `xor` (x0 `shiftL` 13)
      x2 = x1 `xor` (x1 `shiftR` 17)
      x3 = x2 `xor` (x2 `shiftL` 5)
   in (x3, Xorshift32 x3)

coprime :: Int32 -> Int32 -> Bool
coprime a b = gcd a b == 1
