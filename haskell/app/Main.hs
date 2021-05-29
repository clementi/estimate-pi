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
      estimateCount = 100
  millis <- fmap round getPOSIXTime
  _ <- c_srand millis
  estimatesSum <- sumEstimates estimateCount pairCount
  putStrLn $ "Mean: " <> show (estimatesSum / fromIntegral estimateCount)

sumEstimates :: Int -> Int -> IO Double
sumEstimates 0 _ = return 0.0
sumEstimates estimateCount pairCount = do
  estimate <- estimatePi pairCount
  fmap (+ estimate) (sumEstimates (estimateCount - 1) pairCount)

estimatePi :: Int -> IO Double
estimatePi pairCount = do
  coprimeCount <- countCoprime pairCount
  let probability = fromIntegral coprimeCount / fromIntegral pairCount
      estimate = sqrt $ 6 / probability
  putStrLn $ "Estimate: " <> show estimate
  return estimate

countCoprime :: Int -> IO Int
countCoprime 0 = return 0
countCoprime pairCount = do
  isCoprime <- liftM2 coprime c_rand c_rand
  if isCoprime then fmap (+1) (countCoprime (pairCount - 1))
               else countCoprime (pairCount - 1)

coprime :: Int -> Int -> Bool
coprime a b = gcd a b == 1

