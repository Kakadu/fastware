(* inspired by https://discuss.ocaml.org/t/jsoo-rescript-primes-benchmark/7270 *)
let is_prime1 num =
  if num = 2 then true
  else if num mod 2 = 0 then false
  else
    let lim = truncate (sqrt (float_of_int num) +. 0.5) in
    let rec lp curr =
      if curr > lim then true
      else if num mod curr = 0 then false
      else lp (curr + 2)
    in
    lp 3

let is_prime2 num =
  if num = 2 then true
  else if num mod 2 = 0 then false
  else
    (* let lim = truncate (sqrt (float_of_int num) +. 0.5) in *)
    let rec lp curr =
      if curr * curr > num then true
      else if num mod curr = 0 then false
      else lp (curr + 2)
    in
    lp 3

let run is_prime =
  let next_prime num =
    let rec lp next = if is_prime next then next else lp (next + 1) in
    lp num
  in

  let rec lp curr count =
    if count > 99_999 then curr else lp (next_prime (curr + 1)) (count + 1)
  in
  lp 1 0

let bench impl =
  let ans = run impl in
  assert (ans = 1_299_709);
  ans

let () =
  let info =
    Benchmark.throughputN 10
      [ ("impl1", bench, is_prime1); ("impl2", bench, is_prime2) ]
  in
  Benchmark.tabulate info

(*
  on Intel(R) Core(TM) i7-4790K CPU @ 4.00GHz

Throughputs for "impl1", "impl2" each running for at least 10 CPU seconds:
impl1: 10.34 WALL (10.31 usr +  0.01 sys = 10.32 CPU) @  2.81/s (n=29)
impl2: 10.38 WALL (10.36 usr +  0.00 sys = 10.36 CPU) @  2.61/s (n=27)
        Rate impl2 impl1
impl2 2.61/s    --   -7%
impl1 2.81/s    8%    --

*)
