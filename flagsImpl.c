#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <stdint.h>

#define TOC \
  CAMLparam3(_m, _w, _f); \
  uint64_t m = Int_val(_m); \
  uint64_t w = Int_val(_w); \
  uint64_t f = Int_val(_f);

value caml_1naive(value _m, value _w, value _f) {
  TOC;
  uint64_t ans = f ? (w|m) : (w & ~m);
  CAMLreturn(Val_int(ans));
}

value caml_2(value _m, value _w, value _f) {
  TOC;
  uint64_t ans = w ^ ((-f ^ w) & m);
  CAMLreturn(Val_int(ans));
}

value caml_3(value _m, value _w, value _f) {
  TOC;
  uint64_t ans = (w & ~m) | (-f & m);
  CAMLreturn(Val_int(ans));
}
