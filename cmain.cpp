#include <benchmark/benchmark.h>
#include <cstdio>
#include <random>
#include <vector>
#include <cassert>

uint32_t count_digits(uint32_t v) {
    uint32_t result = 0;
    do {
        ++result;
        v /= 10;
    } while (v);
    result;
}

uint32_t count_digits2(uint32_t v) {
    uint32_t result = 1;
    for (;;) {
        if (v<10)    { return result;   }
        if (v<100)   { return result+1; }
        if (v<1000)  { return result+2; }
        if (v<10000) { return result+3; }
        v /= 10000U;
        result += 4;
    }
    assert(0);
}


uint32_t u64AsciiClassic(uint64_t value, char* dst) {
  // write backwards
  auto start = dst;
  do {
    *dst++ = '0' + (value % 10);
    value /= 10;
  } while (value != 0);
  const uint32_t result = dst - start;
  // reverse in plase 
  for (dst--; dst > start; start++, dst--) {
    std::iter_swap(dst, start);
  }
  return result;
}

std::random_device seed;
std::mt19937 gen(seed());
std::vector<uint32_t> nums;

void count1_benchmark(benchmark::State& state) {
  while (state.KeepRunning()) {
    count_digits(state.range(0));
  }
}

void count2_benchmark(benchmark::State& state) {
  while (state.KeepRunning()) {
    count_digits2(state.range(0));
  }
}

void args(benchmark::internal::Benchmark* b) {
  const auto count = 9;
  nums.reserve(count);
  
  auto prev = 1U;
  for (int i = 0; i < count; i++) {
    auto next = prev * 10U;
    assert( (prev <= next-1) && (0 <=prev) );
    std::uniform_int_distribution<> dis(prev, next-1);
    //printf("%s %d prev=%u next=%u\n", __FILE__, __LINE__, prev, next);
    uint32_t rez = dis(gen);
    //printf("%u\n", rez);
    nums.push_back(rez);
    prev *= 10U;
  }
  for (int i = 0; i < count; ++i)
    b->Arg({ nums.at(i) });
}
BENCHMARK(count1_benchmark)->Apply(args);
BENCHMARK(count2_benchmark)->Apply(args);
BENCHMARK_MAIN();


