#include <benchmark/benchmark.h>
#include <vector>
#include <numeric> // for std::accumulate

__attribute__((optimize("no-tree-vectorize")))
static void SumAccumulate(benchmark::State& state) {
    // Create a vector with a size defined by the benchmark state
    std::vector<int> array(state.range(0), 1); // Fill with 1s for simplicity

    for (auto _ : state) {
        // Reset the sum for each iteration
        benchmark::DoNotOptimize(array.data()); // Prevents the compiler from optimizing away the array
        int sum = std::accumulate(array.begin(), array.end(), 0);
        benchmark::DoNotOptimize(sum); // Prevents the compiler from optimizing away the sum
    }
}

__attribute__((optimize("no-tree-vectorize")))
long naive_sum(int* arr, unsigned len) {
    long ans = 0;
    for (size_t i=0; i<len; ++i)
        ans += arr[i];
    return ans;
}

__attribute__((optimize("no-tree-vectorize")))
long unroll_sum(int* arr, unsigned len) {
    long ans = 0;
    for (size_t i=0; i<len; i+=4) {
        ans += arr[i];
        ans += arr[i+1];
        ans += arr[i+2];
        ans += arr[i+3];
    }
    return ans;
}

__attribute__((optimize("no-tree-vectorize")))
long unroll_sum2(int* arr, unsigned len) {
    long ans0 = 0, ans1=0, ans2=0, ans3=0;
    for (size_t i=0; i<len; i+=4) {
        ans0 += arr[i];
        ans1 += arr[i+1];
        ans2 += arr[i+2];
        ans3 += arr[i+3];
    }
    return ans0+ans1+ans2+ans3;
}

static void SumNaive(benchmark::State& state) {
    // Create a vector with a size defined by the benchmark state
    std::vector<int> array(state.range(0), 1); // Fill with 1s for simplicity

    for (auto _ : state) {
        // Reset the sum for each iteration
        benchmark::DoNotOptimize(array.data()); // Prevents the compiler from optimizing away the array
        int sum = naive_sum(&array[0], array.size());
        benchmark::DoNotOptimize(sum); // Prevents the compiler from optimizing away the sum
    }
}

static void SumUnroll(benchmark::State& state) {
    // Create a vector with a size defined by the benchmark state
    std::vector<int> array(state.range(0), 1); // Fill with 1s for simplicity

    for (auto _ : state) {
        // Reset the sum for each iteration
        benchmark::DoNotOptimize(array.data()); // Prevents the compiler from optimizing away the array
        int sum = unroll_sum(&array[0], array.size());
        benchmark::DoNotOptimize(sum); // Prevents the compiler from optimizing away the sum
    }
}

static void SumUnroll2(benchmark::State& state) {
    // Create a vector with a size defined by the benchmark state
    std::vector<int> array(state.range(0), 1); // Fill with 1s for simplicity

    for (auto _ : state) {
        // Reset the sum for each iteration
        benchmark::DoNotOptimize(array.data()); // Prevents the compiler from optimizing away the array
        int sum = unroll_sum2(&array[0], array.size());
        benchmark::DoNotOptimize(sum); // Prevents the compiler from optimizing away the sum
    }
}
// Register the benchmark with a range of sizes
BENCHMARK(SumAccumulate)->Arg(1 << 10)->Arg(1 << 20)->Arg(1 << 24); // 1024, 1048576, 16777216 elements
BENCHMARK(SumNaive)->Arg(1 << 10)->Arg(1 << 20)->Arg(1 << 24); // 1024, 1048576, 16777216 elements
BENCHMARK(SumUnroll)->Arg(1 << 10)->Arg(1 << 20)->Arg(1 << 24); // 1024, 1048576, 16777216 elements
BENCHMARK(SumUnroll2)->Arg(1 << 10)->Arg(1 << 20)->Arg(1 << 24); // 1024, 1048576, 16777216 elements

// Main function to run the benchmarks
BENCHMARK_MAIN();