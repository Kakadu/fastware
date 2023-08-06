OUT=fib.exe

all: $(OUT)
	./$(OUT)

$(OUT): fib_bench.rkt
	raco exe -o $(OUT) --cs fib_bench.rkt

clean:
	$(OUT)
