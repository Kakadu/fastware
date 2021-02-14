open Base

(* let () = Random.self_init () *)

let () =
  List.iter [ 100; 1000; 10000; 100000 ] ~f:(fun length ->
      let arr = Array.init length ~f:(fun x -> x) in
      let lst = Array.to_list arr in
      let f _ = () in

      Benchmark.throughputN 3
        [
          ( Printf.sprintf "iterating list of length %d" length,
            (fun () -> List.iter ~f lst),
            () );
          ( Printf.sprintf "iterating array of length %d" length,
            (fun () -> Array.iter ~f arr),
            () );
        ]
      |> Benchmark.tabulate)
