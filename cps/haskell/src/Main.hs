module Main where

import Criterion.Main
import Control.Monad.Trans.Cont

fib m | m < 0     = error "negative!"
      | otherwise = go m
  where go 0 = 0
        go 1 = 1
        go n = go (n-1) + go (n-2)

fib_cps n = helper n id
  where
    helper n k | n <= 1 = k 1
    helper n k          = helper (n - 1) (\ p1 -> helper (n - 2) (\ p2 -> k (p1 + p2)))

fib_m n = runCont (helper n) id
  where
    helper n | n <= 1 = return 1
    helper n          = do
      p1 <- helper (n - 1)
      p2 <- helper (n - 2)
      return (p1 + p2)


main = defaultMain [
  bgroup "fib"
    [ bench "direct" $ whnf fib 10
    , bench "cps" $ whnf fib_cps 10
    , bench "cps_m" $ whnf fib_m 10
    --  , bench "11" $ whnf fib 11
    ]
  ]
