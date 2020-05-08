open! Core
open Core_bench

let () = Random.self_init ()



let () =
  List.iter [100; 1000; 10000; 100000]
    ~f:(fun length ->
      Command.run @@ Bench.make_command (
        let arr = Array.init length ~f:(fun x  -> x) in
        let lst = Array.to_list arr in
        let f _ = () in
        [ Bench.Test.create ~name:(Printf.sprintf "iterating list of length %d" length)
            (fun () -> ignore (List.iter ~f lst))
        ; Bench.Test.create ~name:(Printf.sprintf "iterating array of length %d" length)
            (fun () -> ignore (Array.iter ~f arr))
        ]
      )
    )
