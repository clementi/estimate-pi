module Main where

import Control.Monad ( liftM2 )
import Data.Time.Clock.POSIX ( getPOSIXTime )

import Foreign
import Foreign.C.Types

foreign import ccall unsafe "stdlib.h srand" c_srand :: Int -> IO ()
foreign import ccall unsafe "stdlib.h rand" c_rand :: IO Int

main :: IO ()
main = do
  let pairCount = 1000000
  let estimateCount = 100
  millis <- fmap round getPOSIXTime
  _ <- c_srand millis
  estimate <- averageEstimate estimateCount pairCount
  putStrLn $ "Mean: " <> show estimate

averageEstimate :: Int -> Int -> IO Double
averageEstimate estimateCount pairCount = do
  estimates <- makeEstimates estimateCount pairCount
  return (sum estimates / fromIntegral estimateCount)

makeEstimates :: Int -> Int -> IO [Double]
makeEstimates 0 _ = return []
makeEstimates estimateCount pairCount =
  sequence (take estimateCount (repeat $ do
    estimate <- estimatePi pairCount
    putStrLn $ "Estimate: " <> show estimate
    return estimate))

estimatePi :: Int -> IO Double
estimatePi pairCount = do
  pairs <- makePairs pairCount
  let coprimeCount = length $ filter (uncurry coprime) pairs
      probability = fromIntegral coprimeCount / fromIntegral pairCount
      estimate = sqrt $ 6 / probability
  return estimate

makePairs :: Int -> IO [(Int, Int)]
makePairs pairCount = sequence (take pairCount (repeat makePair))

makePair :: IO (Int, Int)
makePair = pairSequence (c_rand, c_rand)
  where pairSequence = uncurry $ liftM2 (,)

coprime :: Int -> Int -> Bool
coprime a b = gcd a b == 1

