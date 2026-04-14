type out_channel

external open_descriptor_out : int -> out_channel
  = "caml_ml_open_descriptor_out"

let stdout = open_descriptor_out 1

external output_char : out_channel -> char -> unit = "caml_ml_output_char"
external flush : out_channel -> unit = "caml_ml_flush"
external format_int : string -> int -> string = "caml_format_int"

let string_of_int n = format_int "%d" n

external unsafe_output_string : out_channel -> string -> int -> int -> unit
  = "caml_ml_output"

external string_length : string -> int = "%string_length"

let output_string oc s = unsafe_output_string oc s 0 (string_length s)

let print_endline s =
  output_string stdout s;
  output_char stdout '\n';
  flush stdout

let () = print_endline (string_of_int 42)
