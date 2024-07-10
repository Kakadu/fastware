//
#include <benchmark/benchmark.h>
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <vector>

const int max = 8192;

__attribute__((optimize("no-tree-vectorize")))
uint64_t sum1naive(uint64_t len, uint64_t *arr) {
	uint64_t sum = 0;
	for (uint64_t i=0; i<len; i+=1)
		sum += arr[i];
	return sum;
}
__attribute__((optimize("no-tree-vectorize")))
uint64_t sum2(uint64_t len, uint64_t *arr) {
	uint64_t sum = 0;
	for (uint64_t i=0; i<len; i+=2) {
		sum += arr[i];
		sum += arr[i+1];
	}
	return sum;
}
__attribute__((optimize("no-tree-vectorize")))
uint64_t sum3(uint64_t len, uint64_t *arr) {
	uint64_t sum = 0;
	for (uint64_t i=0; i<len; i+=4) {
		sum += arr[i];
		sum += arr[i+1];
		sum += arr[i+2];
		sum += arr[i+3];
	}
	return sum;
}
__attribute__((optimize("no-tree-vectorize")))
uint64_t sum4(uint64_t len, uint64_t *arr) {
	uint64_t sum = 0, l, r;
	for (uint64_t i=0; i<len; i+=4) {
		l = arr[i] + arr[i+1];
		r = arr[i+2] + arr[i+3];
		sum += l+r;
	}
	return sum;
}
__attribute__((optimize("no-tree-vectorize")))
uint64_t sum5(uint64_t len, uint64_t *arr) {
	uint64_t a = 0, b=0, c=0, d=0;
	for (uint64_t i=0; i<len; i+=4) {
		a+=arr[i];
		b+=arr[i+1];
		c+=arr[i+2];
		d+=arr[i+3];
	}
	return a+b+c+d;
}

#define WRAP(ARG) static void Test##ARG(benchmark::State &state) {\
	srand(0);\
	uint64_t *data = new uint64_t[max];\
	for (int i = 0; i < max; i++) {\
		data[i] = rand();\
	}\
	for (auto _ : state) {\
		uint64_t result = ARG(max, data);\
		benchmark::DoNotOptimize(result);\
	}\
}\
BENCHMARK(Test##ARG);

WRAP(sum1naive)
WRAP(sum2)
WRAP(sum3)
WRAP(sum4)
WRAP(sum5)
// static void TestSum2(benchmark::State &state) {
// 	srand(0); // predictable seed
// 	uint64_t *data = new uint64_t[max];
// 	for (int i = 0; i < max; i++) {
// 		data[i] = rand();
// 	}

// 	// Code inside this loop is measured repeatedly
// 	for (auto _ : state) {
// 		uint64_t result = sum2(max, data);
// 		benchmark::DoNotOptimize(result);
// 	}
// }
// BENCHMARK(TestSum2);

// static void TestSum3(benchmark::State &state) {
// 	srand(0); // predictable seed
// 	uint64_t *data = new uint64_t[max];
// 	for (int i = 0; i < max; i++) {
// 		data[i] = rand();
// 	}

// 	// Code inside this loop is measured repeatedly
// 	for (auto _ : state) {
// 		uint64_t result = sum3(max, data);
// 		benchmark::DoNotOptimize(result);
// 	}
// }
// BENCHMARK(TestSum3);

BENCHMARK_MAIN();