open! Core
open Core_bench

let () = Random.self_init ()

external count_digits  : int -> int = "ml_count_digits"
external count_digits2 : int -> int = "ml_count_digits2"

let () =
  Printf.printf "%d\n%!" (count_digits  12345);
  Printf.printf "%d\n%!" (count_digits2 12345);
  ()


let generated =
  Random.self_init ();
  let powi = Base.Int_math.Private.int_pow 10 in
  let xs = List.init 9 ~f:(fun i ->
    (* make in between 10^i and 10^(i+1) *)
    let l = powi i in
    let r = powi (1+i) in
    let ans = Random.int_incl l (r-1) in
    assert (l <= ans && ans < r);
    ans
  ) in
  Format.printf "%a\n%!"
    (Format.pp_print_list ~pp_sep:(fun fmt () -> Format.fprintf fmt "; ")
      (fun fmt -> Format.fprintf fmt "%d"))
    xs;
  xs

let () =
  List.iter generated ~f:(fun n ->
    Command.run @@ Bench.make_command (
      [ Bench.Test.create ~name:"count_digits1" (fun () ->
          ignore (count_digits n))
      ; Bench.Test.create ~name:"count_digits2" (fun () ->
          ignore (count_digits2 n))
      ]
    )
  )
(*
let () =
  Random.self_init ();
  let x = Random.int 1000 in
  Command.run @@ Bench.make_command (
    List.init 9 ~f:(fun _i ->
      (*let max = exp 10.0 (float_of_int (i+1)) in*)
      let _x = Random.int 1000 in
      Bench.Test.create ~name:"count_digits 10^0" (fun () ->
        ignore (count_digits x));
    )
  )*)
