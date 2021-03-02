extern "C" {
#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
}

#include <fast_float/fast_float.h>
#define Val_none  Val_int(0)

extern "C" value parse_double_caml(value _str, value _len)
{
  CAMLparam2(_str, _len);
  CAMLlocal1(_ans);
  const char *s = String_val(_str);
  int len = Int_val(_len);
  double result = 0.0;
  auto answer = fast_float::from_chars(s, s+len, result);
  if (answer.ec != std::errc()) {
    CAMLreturn(Val_none);
  }
  _ans = caml_alloc(1, 0); // Some
  Field(_ans, 0) = caml_copy_double(result);
  CAMLreturn(_ans);
}

extern "C" value parse_float_caml(value _str, value _len)
{
  CAMLparam2(_str, _len);
  CAMLlocal1(_ans);
  const char *s = String_val(_str);
  int len = Int_val(_len);
  float result = 0.0;
  auto answer = fast_float::from_chars(s, s+len, result);
  if (answer.ec != std::errc()) {
    CAMLreturn(Val_none);
  }

  _ans = caml_alloc(1, 0); // Some
  Field(_ans, 0) = caml_copy_double(result);
  CAMLreturn(_ans);
}
