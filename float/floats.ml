(* https://github.com/Kakadu/fast_float *)

external fast_parse_double : string -> int -> float option = "parse_double_caml"

(* external fast_parse_float : string -> int -> float option = "parse_float_caml" *)

let () = Random.init 648

let () =
  let s1 =
    "3.141592653589793238462643383279502884197169399375105820974944592307816406"
  in
  Format.printf "%a\n"
    (Format.pp_print_option Format.pp_print_float)
    (fast_parse_double s1 (String.length s1))
(* let bound = 10000

let make_int () = Random.int bound

let pairs : _ list =
  Array.init 10000 ~f:(fun _ -> (make_int (), make_int ())) |> Array.to_list

let loop1 xs = List.iter ~f:(fun (a, b) -> ignore @@ Stdlib.compare a b) xs

let loop2 xs =
  List.iter
    ~f:(fun (a, b) -> ignore @@ (Stdlib.compare : int -> int -> int) a b)
    xs

let loop3 xs =
  List.iter ~f:(fun (a, b) -> ignore @@ Sys.opaque_identity ( - ) a b) xs

let tests () =
  let test name f arg = (name, f, arg) in

  Benchmark.throughputN 1
    [
      test "poly" (fun () -> ignore (loop1 pairs)) ();
      test "mono" (fun () -> ignore (loop2 pairs)) ();
      test "minus" (fun () -> ignore (loop3 pairs)) ();
    ]
  |> Benchmark.tabulate
 *)
