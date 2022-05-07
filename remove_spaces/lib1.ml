(* https://github.com/lemire/despacer/blob/master/src/despacer.c *)

(*
size_t despace(char *bytes, size_t howmany) {
  size_t pos = 0;
  for (size_t i = 0; i < howmany; i++) {
    char c = bytes[i];
    if (c == '\r' || c == '\n' || c == ' ') {
      continue;
    }
    bytes[pos++] = c;
  }
  return pos;
}
*)
let despace bytes ~len:howmany =
  let rec loop pos i =
    if i >= howmany then pos
    else
      let c = Bytes.unsafe_get bytes i in
      match c with
      | '\r' | '\n' | ' ' -> loop pos (i + 1)
      | _ ->
          Bytes.set bytes pos c;
          loop (pos + 1) (i + 1)
  in
  loop 0 0

(*
size_t despace_branchless( void* dst_void, void* src_void, size_t length )
{
	uint8_t* src = (uint8_t* )src_void;
	uint8_t* dst = (uint8_t* )dst_void;

	for( ; length != 0; length-- ){
		uint8_t c = *src++;
		*dst = c;
		dst += !!((c != 0x20) && (c != 0x0A) && (c != 0x0D) && (c != 0x09));
	}
	return (size_t)(dst - ((uint8_t* )dst_void));
}
*)

let despace_branchless bytes ~len ~src =
  let rec loop src dst length =
    if length <> 0 then (
      let c = Bytes.unsafe_get bytes src in
      Bytes.unsafe_set bytes dst c;
      let cc = Char.code c in
      let offset_dst : int =
        (cc <> 0x20 && cc <> 0x0A && cc <> 0x0D && cc <> 0x09) |> Obj.magic
      in
      loop (src + 1) (dst + offset_dst) (length - 1))
    else dst
  in
  loop src src len

let%expect_test _ =
  let input = Bytes.of_string "1 2 3 4 5 " in
  let len = Bytes.length input in
  let l = despace_branchless input ~len ~src:0 in
  Format.printf "input = %S\n%!" (Bytes.to_string input);
  Format.printf "rez   = %S\n%!" (Bytes.sub_string input 0 l);
  [%expect {| |}]
