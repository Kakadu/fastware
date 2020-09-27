open Core
open Core_bench

let () = Random.init 648

let bound = 10000
let make_int () = Random.int bound
let pairs : _ list= Array.init 10000 ~f:(fun _ -> (make_int(), make_int()) ) |> Array.to_list

let loop1 xs =
  List.iter ~f:(fun (a,b) -> ignore @@ (Stdlib.compare a b)) xs

let loop2 xs =
  List.iter ~f:(fun (a,b) -> ignore @@ ((Stdlib.compare:int -> int -> int) a b)) xs

let loop3 xs =
  List.iter ~f:(fun (a,b) -> ignore @@ Sys.opaque_identity (-) a b) xs

let tests () =
  let test name f = Bench.Test.create f ~name in
  [ test "poly"  (fun () -> ignore (loop1 pairs) )
  ; test "mono"  (fun () -> ignore (loop2 pairs) )
  ; test "minus" (fun () -> ignore (loop3 pairs) )
  ]

let () =
  tests ()
  |> Bench.make_command
  |> Command.run


(*
  on Intel(R) Core(TM) i7-4790K CPU @ 4.00GHz

┌───────┬──────────┬────────────┐
│ Name  │ Time/Run │ Percentage │
├───────┼──────────┼────────────┤
│ poly  │  91.37us │    100.00% │
│ mono  │  28.53us │     31.22% │
│ minus │  30.02us │     32.86% │
└───────┴──────────┴────────────┘

*)
