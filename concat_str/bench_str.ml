let large_length = 100000
let small_length = 10
let large_s = String.init large_length (fun _ -> 'x')
let small_s = String.init small_length (fun _ -> 'x')

module Four_string = struct
  let conc3 a b c d = a ^ b ^ c ^ d
  let concp a b c d = Printf.sprintf "%s%s%s%s" a b c d
  let concf a b c d = Format.sprintf "%s%s%s%s" a b c d
  let concs a b c d = String.concat "" [ a; b; c; d ]

  let conc_buffer a b c d =
    let sl = String.length in
    let len = sl a + sl b + sl c + sl d in
    let buf = Buffer.create len in
    Buffer.add_string buf a;
    Buffer.add_string buf b;
    Buffer.add_string buf c;
    Buffer.add_string buf d;

    Buffer.contents buf

  (* Large string *)
  let measure s =
    let info =
      Benchmark.throughputN 3 ~style:Nil
        [
          ("String.( ^ )", (fun () -> conc3 s s s s), ());
          ("Printf.sprintf", (fun () -> concp s s s s), ());
          ("Format.sprintf", (fun () -> concf s s s s), ());
          ("String.concat", (fun () -> concs s s s s), ());
          ("Manual buffer", (fun () -> conc_buffer s s s s), ());
        ]
    in
    Benchmark.tabulate info
end

let () =
  Format.printf "Concatenating %d long (%d) strings.\n%!" 4 large_length;
  Four_string.measure large_s;
  Format.printf "Concatenating %d short (%d) strings.\n%!" 4 small_length;
  Four_string.measure small_s

module Ten_string = struct
  let conc a b c d e f g h i j = a ^ b ^ c ^ d ^ e ^ f ^ g ^ h ^ i ^ j

  let conc_p a b c d e f g h i j =
    Printf.sprintf "%s%s%s%s%s%s%s%s%s%s" a b c d e f g h i j

  let conc_f a b c d e f g h i j =
    Format.sprintf "%s%s%s%s%s%s%s%s%s%s" a b c d e f g h i j

  let conc_s a b c d e f g h i j =
    String.concat "" [ a; b; c; d; e; f; g; h; i; j ]

  let conc_buffer a b c d e f g h i j =
    let sl = String.length in
    let len =
      sl a + sl b + sl c + sl d + sl e + sl f + sl g + sl h + sl i + sl j
    in
    let buf = Buffer.create len in
    Buffer.add_string buf a;
    Buffer.add_string buf b;
    Buffer.add_string buf c;
    Buffer.add_string buf d;
    Buffer.add_string buf e;
    Buffer.add_string buf f;
    Buffer.add_string buf g;
    Buffer.add_string buf h;
    Buffer.add_string buf i;
    Buffer.add_string buf j;
    Buffer.contents buf

  let measure s =
    let info =
      Benchmark.throughputN 3 ~style:Nil
        [
          ("String.( ^ )", (fun () -> conc s s s s s s s s s s), ());
          ("Printf.sprintf", (fun () -> conc_p s s s s s s s s s s), ());
          ("Format.sprintf", (fun () -> conc_f s s s s s s s s s s), ());
          ("String.concat", (fun () -> conc_s s s s s s s s s s s), ());
          ("manual Buffer", (fun () -> conc_buffer s s s s s s s s s s), ());
        ]
    in
    Benchmark.tabulate info
end

let () =
  Format.printf "Concatenating %d long (%d) strings.\n%!" 10 large_length;
  Ten_string.measure large_s;
  Format.printf "Concatenating %d short (%d) strings.\n%!" 10 small_length;
  Ten_string.measure small_s
