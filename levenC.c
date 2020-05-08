#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

static long
lev_dist (const char *s1,
          const char *s2)
{
    unsigned long m, n;
    unsigned long i, j;
    long *v0, *v1;
    long ret, *temp;

    m = strlen (s1);
    n = strlen (s2);

    /* Edge cases. */
    if (m == 0) {
        return n;
    } else if (n == 0) {
        return m;
    }

    v0 = malloc (sizeof (long) * (n + 1));
    v1 = malloc (sizeof (long) * (n + 1));

    if (v0 == NULL || v1 == NULL) {
        fprintf (stderr, "failed to allocate memory\n");
        exit (-1);
    }

    for (i = 0; i <= n; ++i) {
        v0[i] = i;
    }
    memcpy (v1, v0, n + 1);

    for (i = 0; i < m; ++i) {
        v1[0] = i + 1;

        for (j = 0; j < n; ++j) {
            const long subst_cost = (s1[i] == s2[j]) ? v0[j] : (v0[j] + 1);
            const long del_cost = v0[j + 1] + 1;
            const long ins_cost = v1[j] + 1;

#if !defined(__GNUC__) || defined(__llvm__)
            if (subst_cost < del_cost) {
                v1[j + 1] = subst_cost;
            } else {
                v1[j + 1] = del_cost;
            }
#else
            v1[j + 1] = (subst_cost < del_cost) ? subst_cost : del_cost;
#endif
            if (ins_cost < v1[j + 1]) {
                v1[j + 1] = ins_cost;
            }
        }

        temp = v0;
        v0 = v1;
        v1 = temp;
    }

    ret = v0[n];
    free (v0);
    free (v1);
    return ret;
}

int
main ()
{
    const int len = 15000;
    int i;
    char s1[15001], *s2 = s1, s3[15001];
    clock_t start_time, exec_time;

    for (i = 0; i < len; ++i) {
        s1[i] = 'a';
        s3[i] = 'b';
    }
    s1[len] = s3[len] = '\0';

    start_time = clock ();

    printf ("%ld\n", lev_dist (s1, s2));
    printf ("%ld\n", lev_dist (s1, s3));

    exec_time = clock () - start_time;
    fprintf (stderr,
             "Finished in %.3fs\n",
             ((double) exec_time) / CLOCKS_PER_SEC);
    return 0;
}
