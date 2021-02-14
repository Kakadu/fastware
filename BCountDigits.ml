open Base

let () = Random.self_init ()

external count_digits : int -> int = "ml_count_digits"

external count_digits2 : int -> int = "ml_count_digits2"

let () =
  Stdlib.Format.printf "%d\n%!" (count_digits 12345);
  Stdlib.Format.printf "%d\n%!" (count_digits2 12345);
  ()

let generated =
  Random.self_init ();
  let powi = Base.Int_math.Private.int_pow 10 in
  let xs =
    List.init 9 ~f:(fun i ->
        (* make in between 10^i and 10^(i+1) *)
        let l = powi i in
        let r = powi (1 + i) in
        let ans = Random.int_incl l (r - 1) in
        assert (l <= ans && ans < r);
        ans)
  in
  Stdlib.Format.printf "%a\n%!"
    (Stdlib.Format.pp_print_list
       ~pp_sep:(fun fmt () -> Stdlib.Format.fprintf fmt "; ")
       (fun fmt -> Stdlib.Format.fprintf fmt "%d"))
    xs;
  xs

let () =
  List.iter generated ~f:(fun n ->
      let ans =
        Benchmark.throughputN 3
          [
            ("count_digits1", count_digits, n);
            ("count_digits2", count_digits2, n);
          ]
      in
      Benchmark.tabulate ans)

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
