module Main where

import Control.Monad ( liftM2 )
import System.Random ( Random(randomIO) )

main :: IO ()
main = do
  let pairCount = 1000000
  let estimateCount = 100
  estimate <- averageEstimate estimateCount pairCount
  putStrLn $ "Mean: " <> show estimate

averageEstimate :: Int -> Int -> IO Double
averageEstimate estimateCount pairCount = do
  estimates <- makeEstimates estimateCount pairCount
  return (sum estimates / fromIntegral (length estimates))

makeEstimates :: Int -> Int -> IO [Double]
makeEstimates 0 _ = return []
makeEstimates estimateCount pairCount = do
  estimate <- estimatePi pairCount
  putStrLn $ "Estimate: " <> show estimate
  fmap (estimate :) (makeEstimates (estimateCount - 1) pairCount)

estimatePi :: Int -> IO Double
estimatePi pairCount = do
  pairs <- makePairs pairCount
  let coprimeCount = length $ filter (uncurry coprime) pairs
      probability = fromIntegral coprimeCount / fromIntegral pairCount
      estimate = sqrt $ 6 / probability
  return estimate

makePairs :: Int -> IO [(Int, Int)]
makePairs 0 = return []
makePairs pairCount = do
  pair <- makePair
  fmap (pair :) (makePairs (pairCount - 1))

makePair :: IO (Int, Int)
makePair = pairSequence (randomIO, randomIO)
  where pairSequence = uncurry $ liftM2 (,)

coprime :: Int -> Int -> Bool
coprime a b = gcd a b == 1
