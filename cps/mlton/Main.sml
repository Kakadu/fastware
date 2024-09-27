open Benchmark

fun fib n = if n<2 then 1 else (fib (n-1)) + (fib (n-2))
fun fib_cps n k =
    if n<2 then k 1 else fib_cps (n-1) (fn x => fib_cps (n-2) (fn y => k(x+y)))

fun test func = (
    Benchmark.restart ();
    print (Int.toString (func 42));
    Benchmark.stop ();
    Benchmark.show())
val _ =
    (Benchmark.start(); Benchmark.stop())
val _ = test fib
val _ = test fib
val _ = test (fn n => fib_cps n (fn x => x))
val _ = test (fn n => fib_cps n (fn x => x))
val _ = test (fn n => fib_cps n (fn x => x))
val _ = test (fn n => fib_cps n (fn x => x))
val _ = test (fn n => fib_cps n (fn x => x))

