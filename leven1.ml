(* https://habr.com/ru/post/483864 *)
open! Core
open Core_bench

let s1,s2,s3 =
  Random.self_init ();
  let len = 15000 in
  let s1 = String.make len 'a' in
  let s2 = s1 in
  let s3 = String.make len 'b' in
  (s1,s2,s3)

let lev_dist (s1: string) (s2: string) =
  let m = String.length s1 in
  let n = String.length s2 in

  let v0Init = Array.init (1+n) ~f:(fun i -> i) in
  let v1Init = Array.init (1+n) ~f:(fun _ -> 0) in

  let rec loop i v0 v1 =
    if i=m then ()
    else
      let () = Array.unsafe_set v1 (i+1) 0 in
      let s1char = s1.[i] in

      let rec go j =
        if j=n then ()
        else
(*          let () = printf "j =  %d\n%!" j in*)
          let delCost  = Array.unsafe_get v0 (j+1) in
          let insConst = Array.unsafe_get v1 (j) in
          let substCostBase = Array.unsafe_get v0 (j) in
          let substCost = if Char.equal s1char (String.unsafe_get s2 j) then 0 else 1 in
          v1.(j+1) <- min (substCost + substCostBase) (1 + min delCost insConst);
          go (j+1)
      in
      go 0;
      loop (i+1) v1 v0
  in
  loop 0 v0Init v1Init;
  (if m mod 2 = 0 then v0Init else v1Init).(n)


let () =
  Printf.printf "%d\n%!" (lev_dist s1 s2);
  Printf.printf "%d\n%!" (lev_dist s1 s3)

let () =
  Command.run @@ Bench.make_command (
    [ Bench.Test.create ~name:"leven1" (fun () ->
        ignore (lev_dist s1 s2);
        ignore (lev_dist s1 s3)
      )
    ]
  )

