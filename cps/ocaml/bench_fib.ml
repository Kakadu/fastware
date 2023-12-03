module type MONAD = sig
  type 'a t

  val return : 'a -> 'a t
  val ( >>= ) : 'a t -> ('a -> 'b t) -> 'b t
end

module type MONADERROR = sig
  include MONAD

  val error : string -> 'a t
end

module Cont
    (* : sig
         include MONADERROR

         val run_cont : ('a -> 'b) -> 'a t -> 'b [@@inline always]
       end *) =
struct
  type ('a, 'b) cont = 'a -> 'b
  type 'a t = { cont : 'b. ('a, 'b) cont -> 'b } [@@unboxed]

  let return (x : 'a) = { cont = (fun k -> k x) } [@@inline always]

  let ( >>= ) (x : 'a t) (f : 'a -> 'b t) : 'b t =
    { cont = (fun k -> x.cont (fun v -> (f v).cont k)) }
    [@@inline always]

  let error = failwith
  let run_cont f { cont } = cont f [@@inline always]

  module Syntax = struct
    let ( let* ) = ( >>= )
  end
end

let fib_cps1 =
  let rec helper n k =
    if n <= 1 then k 1
    else helper (n - 1) (fun p1 -> helper (n - 2) (fun p2 -> k (p1 + p2)))
  in
  fun n -> helper n Fun.id

let fib_cps2_bad =
  let rec helper n =
    if n <= 1 then fun k -> k 1
    else fun k ->
      helper (n - 1) (fun p1 -> helper (n - 2) (fun p2 -> k (p1 + p2)))
  in
  fun n -> helper n Fun.id

(* https://discuss.ocaml.org/t/manual-cps-is-faster-than-cps-monad-is-it-expected/13560/6?u=kakadu *)
let fib_cps3 =
  let rec helper n =
    if n <= 1 then fun k -> k 1
    else
      let h = helper (n - 1) in
      fun k -> h (fun p1 -> helper (n - 2) (fun p2 -> k (p1 + p2)))
  in
  fun n -> helper n Fun.id

let fib_cps_m n =
  let open Cont in
  let open Cont.Syntax in
  let rec helper n =
    if n <= 1 then return 1
    else
      let* l = helper (n - 1) in
      let* r = helper (n - 2) in
      return (l + r)
  in
  run_cont Fun.id (helper n)

let () = assert (fib_cps1 10 = 89)
let () = assert (fib_cps_m 10 = 89)

open Benchmark

let iterations = 10000L

let () =
  (* Printf.printf "custom_minor_max_size = %d\n\n"
     Gc.((get ()).custom_minor_max_size); *)
  let num_count = 10 in
  let res =
    (* throughputN ~repeat:1  *)
    latencyN iterations
      (* latencyN iterations *)
      [
        ("fib manual cps", fib_cps1, num_count);
        ("fib Bad manual cps", fib_cps2_bad, num_count);
        ("fib cps 3 SkySkimmer", fib_cps3, num_count);
        ("fib monadic cps", fib_cps_m, num_count);
      ]
  in
  tabulate res
