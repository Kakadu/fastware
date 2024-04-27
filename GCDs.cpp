#include <iostream>
#include <numeric>
#include "gcd.h"

extern "C" {
#include <caml/memory.h>
#include <caml/mlvalues.h>

#define WRAP(name) \
value caml_##name(value u, value v) { \
    CAMLparam2(u,v);\
    CAMLreturn(Val_int(name(\
        (uint64_t)Int_val(u),\
        (uint64_t)Int_val(v))));\
}

WRAP(naive_gcd)
WRAP(binary_gcd)
WRAP(hybrid_binary_gcd)
// WRAP(extended_gcd)
// WRAP(extended_one_gcd)
// WRAP(binary_extended_gcd)

}