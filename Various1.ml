(* https://www.youtube.com/watch?v=BP6NxVxDQIs *)
let row_major arr n =
  for i = 0 to n - 1 do
    for j = 0 to n - 1 do
      arr.(i).(j) <- j
    done
  done

let col_major arr n =
  for i = 0 to n - 1 do
    for j = 0 to n - 1 do
      arr.(j).(i) <- j
    done
  done

let () =
  let repeat = 1 in
  let timeout = 1 in

  ListLabels.iter [ 10; 100; 1000; 10000 ] ~f:(fun n ->
      let arr = Array.init n (fun _ -> Array.init n (fun _ -> 0)) in
      Benchmark.throughputN ~style:Nil ~repeat timeout
        [
          (Printf.sprintf "row_major size=%d" n, (fun () -> row_major arr n), ());
          (Printf.sprintf "col_major size=%d" n, (fun () -> col_major arr n), ());
        ]
      |> Benchmark.tabulate)
