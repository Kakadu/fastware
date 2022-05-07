open Lib1

let run_despace, run_branchless =
  let len = 20 in
  let run_despace () =
    let input = Bytes.init len (fun i -> if i mod 2 = 0 then 'a' else ' ') in
    (* Printf.printf "input = %S\n%!" (String.of_bytes input); *)
    let ans = despace input ~len in
    (* Printf.printf "ans = %d\n%!" ans; *)
    assert (ans = len / 2)
  in
  let run_branchless () =
    let input = Bytes.init len (fun i -> if i mod 2 = 0 then 'a' else ' ') in
    (* Printf.printf "input = %S\n%!" (String.of_bytes input); *)
    let ans = despace_branchless input ~len ~src:0 in
    (* Printf.printf "ans = %d\n%!" ans; *)
    assert (ans = len / 2)
  in
  (run_despace, run_branchless)

let bench impl =
  let ans = impl () in
  (* assert (ans = 1_299_709); *)
  ans

let () =
  let info =
    Benchmark.throughputN 3
      [ ("impl1", bench, run_despace); ("impl2", bench, run_branchless) ]
  in
  Benchmark.tabulate info

(*


*)
