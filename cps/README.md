### fibonacchi with manual CPS and Cont monad

It looks like Cont monad introduces performance penalty for OCaml, Racket and Chicken Scheme.
For fib 10 is 2-4 times.

But in Haskell the performance is the same. Does Haskell has a very smart inlining to optimize monads?

I'm using Intel(R) Core(TM) i7-4790K CPU @ 4.00GH

#### Haskell

```
benchmarking fib/direct
time                 2.412 μs   (2.394 μs .. 2.438 μs)
                     0.999 R²   (0.999 R² .. 1.000 R²)
mean                 2.412 μs   (2.393 μs .. 2.437 μs)
std dev              73.67 ns   (54.29 ns .. 92.41 ns)
variance introduced by outliers: 40% (moderately inflated)

benchmarking fib/cps
time                 2.663 μs   (2.635 μs .. 2.706 μs)
                     0.998 R²   (0.995 R² .. 0.999 R²)
mean                 2.698 μs   (2.664 μs .. 2.769 μs)
std dev              153.8 ns   (78.93 ns .. 304.1 ns)
variance introduced by outliers: 70% (severely inflated)

benchmarking fib/cps_m
time                 2.622 μs   (2.599 μs .. 2.657 μs)
                     0.998 R²   (0.994 R² .. 1.000 R²)
mean                 2.664 μs   (2.631 μs .. 2.759 μs)
std dev              167.3 ns   (75.06 ns .. 326.6 ns)
variance introduced by outliers: 74% (severely inflated)
```

#### OCaml

    OCAMLRUNPARAM='v=0x400,s=10M' dune exec ./bench_fib.exe --profile=release

```
Latencies for 10000 iterations of "fib manual cps", "fib monadic cps":
 fib manual cps:  0.03 WALL ( 0.01 usr +  0.01 sys =  0.03 CPU) @ 386458.49/s (n=10000)
                 (warning: too few iterations for a reliable count)
fib monadic cps:  0.04 WALL ( 0.04 usr +  0.00 sys =  0.04 CPU) @ 271946.05/s (n=10000)
                 (warning: too few iterations for a reliable count)
                    Rate fib monadic cps  fib manual cps
fib monadic cps 271946/s              --            -30%
 fib manual cps 386458/s             42%              --
```

#### Racket

```
fib_cps: 0.0022705078125
fib_monadic: 0.0031982421875
```

#### Chicken Scheme

((size . 1000) (max . 21.9690017700195) (min . 4.26900100708008) **(arithmetic-mean . 4.58267098999024)** (mean . 4.58267098999024) (standard-deviation . 1.10077385250428) (sd . 1.10077385250428) (sigma . 1.10077385250428))
((size . 1000) (max . 442.867000579834) (min . 13.0479965209961) **(arithmetic-mean . 14.930930103302)** (mean . 14.930930103302) (standard-deviation . 13.9019750329179) (sd . 13.9019750329179) (sigma . 13.9019750329179))
