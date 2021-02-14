open Base

let () = Random.init 648

let rec pp_bin ppf x =
  if x < 2 then Format.fprintf ppf "%d" x
  else
    let () = pp_bin ppf (x / 2) in
    Format.fprintf ppf "%d" (x % 2)

let check msg prog m expected =
  let rez = prog m in
  if rez <> expected then
    failwith
      (Format.asprintf "Testing `%s` failed. returned %a <> expected %a" msg
         pp_bin rez pp_bin expected)

(* Returns value which contains only largest 1 *)
let keepHighestBit n =
  let n = n lor (n lsr 1) in
  let n = n lor (n lsr 2) in
  let n = n lor (n lsr 4) in
  let n = n lor (n lsr 8) in
  let n = n lor (n lsr 16) in
  let n = n lor (n lsr 32) in
  n - (n lsr 1)

let () =
  check "" keepHighestBit 0b0010 0b0010;
  check "" keepHighestBit 0b0011 0b0010;
  check "" keepHighestBit 0b1111 0b1000;
  ()

(* returns logarithm base 2 of MSB *)
let log_2_msb n =
  assert (0 < n && n < 16);
  let rec helper acc x =
    let y = x lsr 1 in
    if y > 0 then helper (acc + 1) y else acc
  in
  helper 0 n

let log_2_msb_unrolled n =
  assert (0 < n && n < 16);
  let acc = 0 in
  let acc = if n lsr 0b0001 > 0 then acc + 1 else acc in
  let acc = if n lsr 0b0010 > 0 then acc + 1 else acc in
  let acc = if n lsr 0b0011 > 0 then acc + 1 else acc in
  let acc = if n lsr 0b0100 > 0 then acc + 1 else acc in
  acc

let smearing n =
  let n = n lor (n lsr 1) in
  let n = n lor (n lsr 2) in
  let n = n lor (n lsr 4) in
  n lxor (n lsr 1)

(* https://stackoverflow.com/a/365068/1065436 *)
let pow2roundup x =
  assert (0 < x && x < 16);
  let x = x - 1 in
  let x = x lor (x lsr 1) in
  let x = x lor (x lsr 2) in
  let x = x lor (x lsr 4) in
  let x = x lor (x lsr 8) in
  x + 1

let () =
  check (Printf.sprintf "%d" __LINE__) log_2_msb 0b0010 0b0001;
  check (Printf.sprintf "%d" __LINE__) log_2_msb 0b0011 0b0001;
  check (Printf.sprintf "%d" __LINE__) log_2_msb 0b0111 0b0010;
  check (Printf.sprintf "%d" __LINE__) log_2_msb 0b0100 0b0010;
  check (Printf.sprintf "%d" __LINE__) log_2_msb 0b1111 0b0011;

  check (Printf.sprintf "%d" __LINE__) log_2_msb_unrolled 0b0010 0b0001;
  check (Printf.sprintf "%d" __LINE__) log_2_msb_unrolled 0b0011 0b0001;
  check (Printf.sprintf "%d" __LINE__) log_2_msb_unrolled 0b0100 0b0010;
  check (Printf.sprintf "%d" __LINE__) log_2_msb_unrolled 0b1111 0b0011;

  check (Printf.sprintf "%d" __LINE__) smearing 0b0010 0b0010;
  check (Printf.sprintf "%d" __LINE__) smearing 0b0011 0b0010;
  check (Printf.sprintf "%d" __LINE__) smearing 0b0100 0b0100;
  check (Printf.sprintf "%d" __LINE__) smearing 0b1111 0b1000;

  check (Printf.sprintf "%d" __LINE__) pow2roundup 0b0010 0b0010;
  check (Printf.sprintf "%d" __LINE__) pow2roundup 0b0011 0b0100;
  check (Printf.sprintf "%d" __LINE__) pow2roundup 0b0100 0b0100;
  check (Printf.sprintf "%d" __LINE__) pow2roundup 0b1111 0b10000;

  ()

(*
let bound = 10000
let make_int () = Random.int bound
let pairs : _ list= Array.init 10000 ~f:(fun _ -> (make_int(), make_int()) ) |> Array.to_list

let loop1 xs =
  List.iter ~f:(fun (a,b) -> ignore @@ (Stdlib.compare a b)) xs

let loop2 xs =
  List.iter ~f:(fun (a,b) -> ignore @@ ((Stdlib.compare:int -> int -> int) a b)) xs

let loop3 xs =
  List.iter ~f:(fun (a,b) -> ignore @@ Sys.opaque_identity (-) a b) xs

let tests () =
  let test name f = Bench.Test.create f ~name in
  [ test "poly"  (fun () -> ignore (loop1 pairs) )
  ; test "mono"  (fun () -> ignore (loop2 pairs) )
  ; test "minus" (fun () -> ignore (loop3 pairs) )
  ]

let () =
  tests ()
  |> Bench.make_command
  |> Command.run


(*
  on Intel(R) Core(TM) i7-4790K CPU @ 4.00GHz

┌───────┬──────────┬────────────┐
│ Name  │ Time/Run │ Percentage │
├───────┼──────────┼────────────┤
│ poly  │  91.37us │    100.00% │
│ mono  │  28.53us │     31.22% │
│ minus │  30.02us │     32.86% │
└───────┴──────────┴────────────┘

*) *)
