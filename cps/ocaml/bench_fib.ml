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
  let res =
    (* throughputN ~repeat:1  *)
    latencyN iterations
      (* latencyN iterations *)
      [ ("fib manual cps", fib_cps1, 10); ("fib monadic cps", fib_cps_m, 10) ]
  in
  tabulate res
