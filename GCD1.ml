let rec naive_gcd u v = if u mod v = 0 then v else naive_gcd v (u / v)

external c_naive_gcd : int -> int -> int = "caml_naive_gcd" [@@noalloc]
external c_binary_gcd : int -> int -> int = "caml_binary_gcd" [@@noalloc]

external c_hybrid_binary_gcd : int -> int -> int = "caml_hybrid_binary_gcd"
[@@noalloc]

let test ~name f = (name, f 1100087778366101931, 679891637638612258)

let () =
  Benchmark.tabulate
  @@ Benchmark.throughputN ~style:Nil ~repeat:1 1
       [
         test ~name:"OCaml naive_gcd" naive_gcd;
         test ~name:"C naive_gcd" c_naive_gcd;
         test ~name:"C binary_gcd" c_binary_gcd;
         test ~name:"C hybrid_binary_gcd" c_hybrid_binary_gcd;
       ]

let () =
  Benchmark.tabulate
  @@ Benchmark.latencyN ~style:Nil ~repeat:10 4L
       [
         test ~name:"OCaml naive_gcd" naive_gcd;
         test ~name:"C naive_gcd" c_naive_gcd;
         test ~name:"C binary_gcd" c_binary_gcd;
         test ~name:"C hybrid_binary_gcd" c_hybrid_binary_gcd;
       ]
(* It looks like core_bench should be better *)
