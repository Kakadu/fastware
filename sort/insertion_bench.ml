open Insertion

let test_increasing ~init msg size =
  Gc.major ();
  Gc.compact ();
  let arr = Array.init size Fun.id in
  let init arr = Array.iteri (fun i _ -> arr.(i) <- i) arr in

  let run_insertion1_for_int () =
    init arr;
    Naive_for_int.sort arr
  in
  let run_insertion1_alexandrescu () =
    init arr;
    A_la_Alexandrescu.sort arr
  in
  let run_insertion1_for_int_unsafe () =
    init arr;
    Naive_for_int_unsafe.sort arr
  in
  let run_insertion1 () =
    init arr;
    insertion1 Int.compare arr
  in
  let run_standard () =
    init arr;
    Array.sort Int.compare arr
  in
  let run_copy_of_standard () =
    init arr;
    Insertion.Copy_of_standart.sort Int.compare arr
  in

  let info =
    Benchmark.throughputN 5 ~style:Benchmark.Nil
      [
        (Printf.sprintf "insertion1_for_int: %s" msg, run_insertion1_for_int, ());
        ( Printf.sprintf "insertion1_for_int_unsafe: %s" msg,
          run_insertion1_for_int_unsafe,
          () );
        ( Printf.sprintf "insertion1_alexandrescu: %s" msg,
          run_insertion1_alexandrescu,
          () );
        (* (Printf.sprintf "insertion1: %s" msg, run_insertion1, ()); *)
        (* (Printf.sprintf "standard: %s" msg, run_standard, ()); *)
        (* (Printf.sprintf "copy_of_standard: %s" msg, run_copy_of_standard, ()); *)
      ]
  in

  Benchmark.tabulate info

let init_increasing arr = Array.iteri (fun i _ -> arr.(i) <- i) arr

let init_decreasing arr =
  let l = Array.length arr in
  Array.iteri (fun i _ -> arr.(i) <- l - 1 - i) arr

let init_random size =
  let start = Array.init size Fun.id in
  for i = 1 to size do
    let l = Random.int size in
    let r = Random.int size in
    if l <> r then (
      let temp = start.(l) in
      start.(l) <- start.(r);
      start.(r) <- temp)
  done;

  fun arr -> Array.iteri (fun i _ -> arr.(i) <- start.(i)) arr

let () =
  let size = 100 in
  test_increasing "RO" ~init:(init_random size) size

let () =
  let size = 500 in
  test_increasing "RO" ~init:(init_random size) size

let () = test_increasing "IO" ~init:init_increasing 100
let () = test_increasing "IO" ~init:init_increasing 500
let () = test_increasing "DO" ~init:init_decreasing 100
let () = test_increasing "DO" ~init:init_decreasing 500
