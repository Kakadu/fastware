int i;
int j;
int dx;
int r;
int v[128];
int u[128];
int c[128];

int square() {
    for (i=0; i<dx; i++)
        for (r=1; r<=2; r++)
            u[i]+=c[r]*( v[i+ r*dx] + v[i- r*dx] );

}

int c1;
int c2;
int ix;

int square2() {
    for (int i=0; ix<dx; i++) {
        u[i] +=   c1 * (v[i+  dx] + v[i-  dx])
                + c2 * (v[i+2*dx] + v[i-2*dx]);
    }
}

int mandel_kernel_naive(float ax, float ay) {
    float x = 0; float y = 0;
    for (int n = 1; n <= 100; n++) {
        float newx = x*x - y*y + ax;
        float newy = 2*x*y + ay;
        if (4 < newx*newx + newy*newy) 
            return n;
        x = newx; y = newy;
    }
    return -1;
}

#include <immintrin.h>

__m256i kernel(__m256 ax, __m256 ay) {
    __m256 x = _mm256_setzero_ps();
    __m256 y = _mm256_setzero_ps();
    __m256 two  = _mm256_set_ps(2.0f, 2.0f, 2.0f, 2.0f, 2.0f, 2.0f, 2.0f, 2.0f);
    __m256 four = _mm256_set_ps(4.0f, 4.0f, 4.0f, 4.0f, 4.0f, 4.0f, 4.0f, 4.0f);
    
    for (int n = 1; n <= 100; n++) {
        __m256 newx = _mm256_add_ps(_mm256_sub_ps(_mm256_mul_ps(x,x), _mm256_mul_ps(y,y)), ax);
        __m256 newy = _mm256_add_ps(_mm256_mul_ps(two,_mm256_mul_ps(x,y)), ay);
        __m256 norm = _mm256_add_ps(_mm256_mul_ps(newx, newx),_mm256_mul_ps(newy, newy));
        __m256 cmpmask = _mm256_cmp_ps(four, norm, _CMP_LT_OS);
        int mask = _mm256_movemask_ps(cmpmask);
        if (mask)
            return _mm256_set_epi32(n,n,n,n,n,n,n,n);
        x = newx; y = newy;
    }
    return _mm256_set_epi32(-1, -1, -1, -1, -1, -1, -1, -1);
}        

