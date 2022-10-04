module Naive_for_int = struct
  let sort arr =
    let l = Array.length arr in
    let put_inside high low =
      let temp = arr.(high) in
      for k = high downto low + 1 do
        arr.(k) <- arr.(k - 1)
      done;
      arr.(low) <- temp
    in
    let rec inner_loop i j =
      if j < 0 then (* insert to the very beginning *)
        put_inside i 0
      else if arr.(i) < arr.(j) then inner_loop i (j - 1)
      else put_inside i (1 + j)
    in
    for i = 1 to l - 1 do
      inner_loop i (i - 1)
    done
end

module A_la_Alexandrescu = struct
  let find_min_max arr len =
    let rec loop (min, max) i =
      if i >= len then (min, max)
      else
        loop
          ( (if arr.(i) < arr.(min) then i else min),
            if arr.(i) > arr.(max) then i else max )
          (1 + i)
    in
    loop (0, 0) 1

  let swap arr l r =
    let temp = arr.(l) in
    arr.(l) <- arr.(r);
    arr.(r) <- temp

  let pp_arr ppf arr =
    Format.fprintf ppf "[| @[%a@] |]%!"
      Format.(pp_print_list pp_print_int)
      (Array.to_list arr)

  let sort arr =
    let l = Array.length arr in
    let min_idx, max_idx = find_min_max arr l in
    (* Printf.printf "min_idx = %d, max_idx = %d\n" min_idx max_idx; *)
    (* Format.printf "arr = %a\n%!" pp_arr arr; *)
    swap arr min_idx 0;
    (* Format.printf "arr = %a\n%!" pp_arr arr;  *)
    if max_idx = 0 then swap arr min_idx (l - 1) else swap arr max_idx (l - 1);
    (* Format.printf "arr = %a\n%!" pp_arr arr; *)
    let put_inside high low =
      let temp = arr.(high) in
      for k = high downto low + 1 do
        arr.(k) <- arr.(k - 1)
      done;
      arr.(low) <- temp
    in
    let rec inner_loop i j =
      (* Printf.printf "inner_loop: i = %d, k = %d\n" i j; *)
      if arr.(i) < arr.(j) then inner_loop i (j - 1) else put_inside i (1 + j)
    in
    for i = 2 to l - 2 do
      inner_loop i (i - 1)
    done
end

let%expect_test _ =
  let arr = [| 5; 4; 3; 2; 1; 0 |] in
  A_la_Alexandrescu.sort arr;
  Format.(printf "@[<h>%a@]\n" (pp_print_list pp_print_int)) (Array.to_list arr);
  [%expect {| 012345 |}]

let%expect_test _ =
  let arr = Array.init 10 (fun x -> x) in
  A_la_Alexandrescu.sort arr;
  Format.(printf "@[<h>%a@]\n" (pp_print_list pp_print_int)) (Array.to_list arr);
  [%expect {| 0123456789 |}]

let%expect_test _ =
  let arr = [| 5; 6; 2; 7; 0; 1 |] in
  A_la_Alexandrescu.sort arr;
  Format.(printf "@[<h>%a@]\n" (pp_print_list pp_print_int)) (Array.to_list arr);
  [%expect {| 012567 |}]

module Naive_for_int_unsafe = struct
  let ( .%() ) = Array.unsafe_get
  let ( .%()<- ) = Array.unsafe_set

  let sort arr =
    let l = Array.length arr in
    let put_inside high low =
      let temp = arr.(high) in
      for k = high downto low + 1 do
        arr.%(k) <- arr.%(k - 1)
      done;
      arr.%(low) <- temp
    in
    let rec inner_loop i j =
      if j < 0 then (* insert to the very beginning *)
        put_inside i 0
      else if arr.%(i) < arr.%(j) then inner_loop i (j - 1)
      else put_inside i (1 + j)
    in
    for i = 1 to l - 1 do
      inner_loop i (i - 1)
    done
end

let insertion1 cmp arr =
  let l = Array.length arr in
  let put_inside high low =
    let temp = arr.(high) in
    for k = high downto low + 1 do
      arr.(k) <- arr.(k - 1)
    done;
    arr.(low) <- temp
  in
  let rec inner_loop i j =
    if j < 0 then (* insert to the very beginning *)
      put_inside i 0
    else if cmp arr.(i) arr.(j) < 0 then inner_loop i (j - 1)
    else put_inside i (1 + j)
  in
  for i = 1 to l - 1 do
    inner_loop i (i - 1)
  done

let%expect_test _ =
  let arr = [| 5; 4; 3; 2; 1; 0 |] in
  insertion1 Int.compare arr;
  Format.(printf "@[<h>%a@]\n" (pp_print_list pp_print_int)) (Array.to_list arr);
  [%expect {| 012345 |}]

let%expect_test _ =
  let arr = Array.init 10 (fun x -> x) in
  insertion1 Int.compare arr;
  Format.(printf "@[<h>%a@]\n" (pp_print_list pp_print_int)) (Array.to_list arr);
  [%expect {| 0123456789 |}]

let%expect_test _ =
  let arr = [| 5; 6; 2; 7; 0; 1 |] in
  insertion1 Int.compare arr;
  Format.(printf "@[<h>%a@]\n" (pp_print_list pp_print_int)) (Array.to_list arr);
  [%expect {| 012567 |}]

module Copy_of_standart = struct
  exception Bottom of int

  let sort cmp a =
    let open Array in
    let maxson l i =
      let i31 = i + i + i + 1 in
      let x = ref i31 in
      if i31 + 2 < l then (
        if cmp (get a i31) (get a (i31 + 1)) < 0 then x := i31 + 1;
        if cmp (get a !x) (get a (i31 + 2)) < 0 then x := i31 + 2;
        !x)
      else if i31 + 1 < l && cmp (get a i31) (get a (i31 + 1)) < 0 then i31 + 1
      else if i31 < l then i31
      else raise (Bottom i)
    in
    let rec trickledown l i e =
      let j = maxson l i in
      if cmp (get a j) e > 0 then (
        set a i (get a j);
        trickledown l j e)
      else set a i e
    in
    let trickle l i e = try trickledown l i e with Bottom i -> set a i e in
    let rec bubbledown l i =
      let j = maxson l i in
      set a i (get a j);
      bubbledown l j
    in
    let bubble l i = try bubbledown l i with Bottom i -> i in
    let rec trickleup i e =
      let father = (i - 1) / 3 in
      assert (i <> father);
      if cmp (get a father) e < 0 then (
        set a i (get a father);
        if father > 0 then trickleup father e else set a 0 e)
      else set a i e
    in
    let l = length a in
    for i = ((l + 1) / 3) - 1 downto 0 do
      trickle l i (get a i)
    done;
    for i = l - 1 downto 2 do
      let e = get a i in
      set a i (get a 0);
      trickleup (bubble i 0) e
    done;
    if l > 1 then (
      let e = get a 1 in
      set a 1 (get a 0);
      set a 0 e)
end
