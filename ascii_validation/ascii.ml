let validate0 str =
  let ( .%[] ) = String.unsafe_get in
  let l = String.length str in
  let exception Exit in
  try
    for i = 0 to l - 1 do
      if Char.code str.%[i] > 0x7F then raise_notrace Exit
    done;
    true
  with Exit -> false

let validate1 str =
  let ( .%[] ) = String.unsafe_get in

  let rec loop1 str i l =
    if i >= l then true
    else if Char.code str.%[i] > 0x7F then false
    else loop1 str (i + 1) l
  in
  loop1 str 0 (String.length str)

let validate2 str =
  let ( .%[] ) = String.unsafe_get in
  let rec loop2 str acc i l =
    if i >= l then acc else loop2 str (acc lor Char.code str.%[i]) (i + 1) l
  in
  let ans = loop2 str 0 0 (String.length str) in
  ans <= 0x7F

external validate_c : string -> bool = "validate_ascii_c"

let good1 = String.make 128 'a'
let bad1 = String.make 128 (Char.chr 200)

let () =
  assert (validate0 good1);
  assert (validate1 good1);
  assert (validate2 good1);
  assert (validate_c good1);
  ()

let measure arg =
  let info =
    Benchmark.throughputN 3 ~style:Nil
      [
        ("100as 0", (fun s -> ignore (validate0 s)), arg);
        ("100as 1", (fun s -> ignore (validate1 s)), arg);
        ("100as 2", (fun s -> ignore (validate2 s)), arg);
        ("100as C", (fun s -> ignore (validate_c s)), arg);
      ]
  in
  Benchmark.tabulate info

let () = measure good1
let () = measure bad1
