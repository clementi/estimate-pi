module Main where

import Control.Monad ( liftM2 )
import System.Random.MWC
import Data.Word ( Word64 )
import GHC.Exts ( RealWorld )

type RNG = Gen RealWorld

main :: IO ()
main = do
  let pairCount = 1000000
  let estimateCount = 100
  g <- createSystemRandom
  estimate <- averageEstimate g estimateCount pairCount
  putStrLn $ "Mean: " <> show estimate

averageEstimate :: RNG -> Int -> Int -> IO Double
averageEstimate g estimateCount pairCount = do
  estimates <- makeEstimates g estimateCount pairCount
  return (sum estimates / fromIntegral (length estimates))

makeEstimates :: RNG -> Int -> Int -> IO [Double]
makeEstimates _ 0 _ = return []
makeEstimates g estimateCount pairCount =
  sequence (take estimateCount (repeat $ do
    estimate <- estimatePi g pairCount
    putStrLn $ "Estimate: " <> show estimate
    return estimate))

estimatePi :: RNG -> Int -> IO Double
estimatePi g pairCount = do
  pairs <- makePairs g pairCount
  let coprimeCount = length $ filter (uncurry coprime) pairs
      probability = fromIntegral coprimeCount / fromIntegral pairCount
      estimate = sqrt $ 6 / probability
  return estimate

makePairs :: RNG -> Int -> IO [(Word64, Word64)]
makePairs g pairCount = sequence (take pairCount (repeat (makePair g)))

makePair :: RNG -> IO (Word64, Word64)
makePair g = pairSequence (uniform g, uniform g)
  where pairSequence = uncurry $ liftM2 (,)

coprime :: Word64 -> Word64 -> Bool
coprime a b = gcd a b == 1

