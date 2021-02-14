open Base

(* https://habr.com/ru/post/482766/#comment_21088158 *)
module C = struct
  (* [call m w f] set flags m in w when f>0 and usets flags m in w otherwise *)
  external i1 : int -> int -> int -> int = "caml_1naive" [@@noalloc]

  external i2 : int -> int -> int -> int = "caml_2" [@@noalloc]

  external i3 : int -> int -> int -> int = "caml_3" [@@noalloc]
end

module ML = struct
  let i1 m w f = if f <> 0 then w lor m else w land lnot m

  let i2 m w f = w lxor (-f lxor w land m)

  let i3 m w f = w land lnot m lor (-f land m)
end

let rec pp_bin ppf x =
  if x < 2 then Stdlib.Format.fprintf ppf "%d" x
  else
    let () = pp_bin ppf (x / 2) in
    Stdlib.Format.fprintf ppf "%d" (x % 2)

let () =
  (* tests *)
  let inputs =
    [
      (0, 0b111111, 1, 0b111111);
      (0b1010, 0b1111, 1, 0b1111);
      (0b1010, 0b111111, 0, 0b110101);
      (1, 0, 1, 1);
      (2, 0, 1, 0b10);
      (2, 1, 1, 0b11);
      (Int.max_value / 2, 0b0, 1, Int.max_value / 2)
      (* TODO: something bad happens here *);
    ]
  in
  let check msg prog m w f expected =
    let rez = prog m w f in
    if rez <> expected then
      failwith
        (Stdlib.Format.asprintf
           "Testing '%s' failed. returned %a <> expected %a" msg pp_bin rez
           pp_bin expected)
  in
  List.iteri inputs ~f:(fun i (m, w, f, a) ->
      check (Printf.sprintf "test1 C  %d" i) C.i1 m w f a;
      check (Printf.sprintf "test1 ML %d" i) ML.i1 m w f a;
      check (Printf.sprintf "test2 ML %d" i) ML.i2 m w f a;
      check (Printf.sprintf "test2 C  %d" i) C.i2 m w f a;
      check (Printf.sprintf "test3 ML %d" i) ML.i3 m w f a;
      check (Printf.sprintf "test3 C  %d" i) C.i3 m w f a)

let () =
  List.iter [ (0, 0, 0); (0, 0, 1); (Int.max_value, Int.max_value, 1) ]
    ~f:(fun (m, w, f) ->
      Benchmark.throughputN 1
        [
          (Printf.sprintf "ML 1 naive", (fun () -> ML.i1 m w f), ());
          (Printf.sprintf "ML 2", (fun () -> ML.i2 m w f), ());
          (Printf.sprintf "ML 3 simd", (fun () -> ML.i3 m w f), ());
          (Printf.sprintf "C 1 naive", (fun () -> C.i1 m w f), ());
          (Printf.sprintf "C 2", (fun () -> C.i2 m w f), ());
          (Printf.sprintf "C 3 simd", (fun () -> C.i3 m w f), ());
        ]
      |> Benchmark.tabulate)
