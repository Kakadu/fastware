#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <string.h>

/* Check if a string contains only ASCII characters (0-127) */
__attribute__((optimize("no-tree-vectorize")))
CAMLprim value validate_ascii_c(value str) {
  CAMLparam1(str);
  int len = caml_string_length(str);
  const unsigned char *data = (const unsigned char *)String_val(str);

  for (int i = 0; i < len; i++) {
    if (data[i] > 0x7F) {
      CAMLreturn(Val_false);
    }
  }

  CAMLreturn(Val_true);
}
