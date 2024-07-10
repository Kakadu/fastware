// https://quick-bench.com/q/um-FjAjFlp556K-rvvR_phZpyE4
#include <benchmark/benchmark.h>
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <variant>
#include <vector>

using f32 = float;
using u32 = uint32_t;

constexpr f32 Pi32  = 3.14159;
constexpr int Count = 128;

class square {
public:
	square(f32 SideInit)
		: Side(SideInit) {}
	f32 Area() const { return Side * Side; }

private:
	f32 Side;
};

class rectangle {
public:
	rectangle(f32 WidthInit, f32 HeightInit)
		: Width(WidthInit), Height(HeightInit) {}
	f32 Area() const { return Width * Height; }

private:
	f32 Width, Height;
};

class triangle {
public:
	triangle(f32 BaseInit, f32 HeightInit)
		: Base(BaseInit), Height(HeightInit) {}
	f32 Area() const { return 0.5f * Base * Height; }

private:
	f32 Base, Height;
};

class circle {
public:
	circle(f32 RadiusInit)
		: Radius(RadiusInit) {}
	f32 Area() const { return Pi32 * Radius * Radius; }

private:
	f32 Radius;
};

using any_shape = std::variant<square, rectangle, triangle, circle>;

f32 TotalAreaVariant(u32 ShapeCount, any_shape *Shapes) {
	f32 Accum = 0.0f;
	for (u32 ShapeIndex = 0; ShapeIndex < ShapeCount; ++ShapeIndex) {
		Accum += std::visit([](auto &&shape) { return shape.Area(); }, Shapes[ShapeIndex]);
	}

	return Accum;
}

f32 TotalAreaVariant4(u32 ShapeCount, any_shape *Shapes) {
	f32 Accum0 = 0.0f;
	f32 Accum1 = 0.0f;
	f32 Accum2 = 0.0f;
	f32 Accum3 = 0.0f;

	u32 Count = ShapeCount / 4;
	while (Count--) {
		Accum0 += std::visit([](auto &&shape) { return shape.Area(); }, Shapes[0]);
		Accum1 += std::visit([](auto &&shape) { return shape.Area(); }, Shapes[1]);
		Accum2 += std::visit([](auto &&shape) { return shape.Area(); }, Shapes[2]);
		Accum3 += std::visit([](auto &&shape) { return shape.Area(); }, Shapes[3]);

		Shapes += 4;
	}

	f32 Result = (Accum0 + Accum1 + Accum2 + Accum3);
	return Result;
}

enum shape_type : u32 {
	Shape_Square,
	Shape_Rectangle,
	Shape_Triangle,
	Shape_Circle,

	Shape_Count,
};

struct shape_union {
	shape_type Type;
	f32 Width;
	f32 Height;
};

f32 GetAreaSwitch(shape_union Shape) {
	f32 Result = 0.0f;

	switch (Shape.Type) {
	case Shape_Square: {
		Result = Shape.Width * Shape.Width;
	} break;
	case Shape_Rectangle: {
		Result = Shape.Width * Shape.Height;
	} break;
	case Shape_Triangle: {
		Result = 0.5f * Shape.Width * Shape.Height;
	} break;
	case Shape_Circle: {
		Result = Pi32 * Shape.Width * Shape.Width;
	} break;

	case Shape_Count: {
	} break;
	}

	return Result;
}

f32 TotalAreaSwitch(u32 ShapeCount, shape_union *Shapes) {
	f32 Accum = 0.0f;

	for (u32 ShapeIndex = 0; ShapeIndex < ShapeCount; ++ShapeIndex) {
		Accum += GetAreaSwitch(Shapes[ShapeIndex]);
	}

	return Accum;
}

f32 TotalAreaSwitch4(u32 ShapeCount, shape_union *Shapes) {
	f32 Accum0 = 0.0f;
	f32 Accum1 = 0.0f;
	f32 Accum2 = 0.0f;
	f32 Accum3 = 0.0f;

	ShapeCount /= 4;
	while (ShapeCount--) {
		Accum0 += GetAreaSwitch(Shapes[0]);
		Accum1 += GetAreaSwitch(Shapes[1]);
		Accum2 += GetAreaSwitch(Shapes[2]);
		Accum3 += GetAreaSwitch(Shapes[3]);

		Shapes += 4;
	}

	f32 Result = (Accum0 + Accum1 + Accum2 + Accum3);
	return Result;
}

static void TestTotalAreaVariant(benchmark::State &state) {

	// not part of the benchmark
	srand(0); // predictable seed
	std::vector<any_shape> shapes;
	shapes.reserve(Count);
	for (int i = 0; i < Count; i++) {
		switch (i & 3) {
		case 0:
			shapes.push_back(square(rand()));
			break;
		case 1:
			shapes.push_back(rectangle(rand(), rand()));
			break;
		case 2:
			shapes.push_back(triangle(rand(), rand()));
			break;
		case 3:
			shapes.push_back(circle(rand()));
			break;
		}
	}

	// Code inside this loop is measured repeatedly
	for (auto _ : state) {
		f32 result = TotalAreaVariant(Count, shapes.data());
		// Make sure the variable is not optimized away by compiler
		benchmark::DoNotOptimize(result);
	}
}
// Register the function as a benchmark
BENCHMARK(TestTotalAreaVariant);

static void TestTotalAreaVariant4(benchmark::State &state) {

	// not part of the benchmark
	srand(0); // predictable seed
	std::vector<any_shape> shapes;
	shapes.reserve(Count);
	for (int i = 0; i < Count; i++) {
		switch (i & 3) {
		case 0:
			shapes.push_back(square(rand()));
			break;
		case 1:
			shapes.push_back(rectangle(rand(), rand()));
			break;
		case 2:
			shapes.push_back(triangle(rand(), rand()));
			break;
		case 3:
			shapes.push_back(circle(rand()));
			break;
		}
	}

	// Code inside this loop is measured repeatedly
	for (auto _ : state) {
		f32 result = TotalAreaVariant4(Count, shapes.data());
		// Make sure the variable is not optimized away by compiler
		benchmark::DoNotOptimize(result);
	}
}
// Register the function as a benchmark
BENCHMARK(TestTotalAreaVariant4);

static void TestTotalAreaSwitch(benchmark::State &state) {

	// not part of the benchmark
	srand(0); // predictable seed
	shape_union shapes[Count];
	for (int i = 0; i < Count; i++) {
		switch (i & 3) {
		case 0:
			shapes[i] = {Shape_Square, static_cast<f32>(rand())};
			break;
		case 1:
			shapes[i] = {Shape_Rectangle, static_cast<f32>(rand()), static_cast<f32>(rand())};
			break;
		case 2:
			shapes[i] = {Shape_Triangle, static_cast<f32>(rand()), static_cast<f32>(rand())};
			break;
		case 3:
			shapes[i] = {Shape_Circle, static_cast<f32>(rand()), static_cast<f32>(rand())};
			break;
		}
	}

	// Code inside this loop is measured repeatedly
	for (auto _ : state) {
		f32 result = TotalAreaSwitch(Count, shapes);
		// Make sure the variable is not optimized away by compiler
		benchmark::DoNotOptimize(result);
	}
}
// Register the function as a benchmark
BENCHMARK(TestTotalAreaSwitch);

static void TestTotalAreaSwitch4(benchmark::State &state) {

	// not part of the benchmark
	srand(0); // predictable seed
	shape_union shapes[Count];
	for (int i = 0; i < Count; i++) {
		switch (i & 3) {
		case 0:
			shapes[i] = {Shape_Square, static_cast<f32>(rand())};
			break;
		case 1:
			shapes[i] = {Shape_Rectangle, static_cast<f32>(rand()), static_cast<f32>(rand())};
			break;
		case 2:
			shapes[i] = {Shape_Triangle, static_cast<f32>(rand()), static_cast<f32>(rand())};
			break;
		case 3:
			shapes[i] = {Shape_Circle, static_cast<f32>(rand()), static_cast<f32>(rand())};
			break;
		}
	}

	// Code inside this loop is measured repeatedly
	for (auto _ : state) {
		f32 result = TotalAreaSwitch4(Count, shapes);
		// Make sure the variable is not optimized away by compiler
		benchmark::DoNotOptimize(result);
	}
}
// Register the function as a benchmark
BENCHMARK(TestTotalAreaSwitch4);


BENCHMARK_MAIN();