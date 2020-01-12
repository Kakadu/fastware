#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <stdio.h>

CAMLextern value ml_count_digits(value _num) {
    CAMLparam1(_num);
    uint32_t v = Int_val(_num);
    uint32_t result = 0;
    do {
        ++result;
        v /= 10;
    } while (v);

    CAMLreturn(Val_int(result));
}

CAMLextern value ml_count_digits2(value _num) {
    CAMLparam1(_num);
    uint32_t v = Int_val(_num);
    uint32_t result = 1;
//    printf("counting digits of %d\n", v);
    for (;;) {
        if (v<10)    { CAMLreturn(Val_int(result)); }
        if (v<100)   { CAMLreturn(Val_int(result+1)); }
        if (v<1000)  { CAMLreturn(Val_int(result+2)); }
        if (v<10000) { CAMLreturn(Val_int(result+3)); }
        v /= 10000U;
        result += 4;
    }
}
