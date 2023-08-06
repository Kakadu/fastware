#### fibonacchi with manual CPS and Cont monad

It looks like Cont monad introduces performance penalty for OCaml, Racket and Chicken Scheme.
For fib 10 is 2-4 times.

But in Haskell the performance is the same. Does Haskell has a very smart inlining to optimize monads?
