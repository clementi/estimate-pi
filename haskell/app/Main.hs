module Main where

import Control.Monad ( liftM2 )
import System.Random.MWC
import Data.Word ( Word64 )
import GHC.Exts ( RealWorld )

main :: IO ()
main = do
  let pairCount = 1000000
  let estimateCount = 100
  g <- createSystemRandom
  estimate <- averageEstimate g estimateCount pairCount
  putStrLn $ "Mean: " <> show estimate

averageEstimate :: Gen RealWorld -> Int -> Int -> IO Double
averageEstimate g estimateCount pairCount = do
  estimates <- makeEstimates g estimateCount pairCount
  return (sum estimates / fromIntegral (length estimates))

makeEstimates :: Gen RealWorld -> Int -> Int -> IO [Double]
makeEstimates _ 0 _ = return []
makeEstimates g estimateCount pairCount = do
  estimate <- estimatePi g pairCount
  putStrLn $ "Estimate: " <> show estimate
  fmap (estimate :) (makeEstimates g (estimateCount - 1) pairCount)

estimatePi :: Gen RealWorld -> Int -> IO Double
estimatePi g pairCount = do
  pairs <- makePairs g pairCount
  let coprimeCount = length $ filter (uncurry coprime) pairs
      probability = fromIntegral coprimeCount / fromIntegral pairCount
      estimate = sqrt $ 6 / probability
  return estimate

makePairs :: Gen RealWorld -> Int -> IO [(Word64, Word64)]
makePairs _ 0 = return []
makePairs g pairCount = do
  pair <- makePair g
  fmap (pair :) (makePairs g (pairCount - 1))

makePair :: Gen RealWorld -> IO (Word64, Word64)
makePair g = pairSequence (uniform g, uniform g)
  where pairSequence = uncurry $ liftM2 (,)

coprime :: Word64 -> Word64 -> Bool
coprime a b = gcd a b == 1
