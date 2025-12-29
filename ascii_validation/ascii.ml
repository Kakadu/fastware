let validate0 str =
  let l = String.length str in
  let exception Exit in
  try
    for i = 0 to l - 1 do
      if Char.code str.[i] > 0x7F then raise Exit
    done;
    true
  with Exit -> false

let validate1 str =
  let l = String.length str in
  let rec loop i =
    if i >= l then true
    else if Char.code str.[i] > 0x7F then false
    else loop (i + 1)
  in
  loop 0

let validate2 str =
  let l = String.length str in
  let rec loop acc i =
    if i >= l then acc else loop (acc lor Char.code str.[i]) (i + 1)
  in
  let ans = loop 0 0 in
  ans <= 0x7F

let good1 = String.make 128 'a'
let bad1 = String.make 128 (Char.chr 200)

let () =
  assert (validate0 good1);
  assert (validate1 good1);
  assert (validate2 good1);
  ()

let measure arg =
  let info =
    Benchmark.throughputN 3 ~style:Nil
      [
        ("100as 0", (fun s -> ignore (validate0 s)), arg);
        ("100as 1", (fun s -> ignore (validate0 s)), arg);
        ("100as 2", (fun s -> ignore (validate0 s)), arg);
      ]
  in
  Benchmark.tabulate info

let () = measure good1
let () = measure bad1
