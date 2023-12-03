OUT=fib.exe

all: $(OUT)
	./$(OUT)

deps: 
	raco pkg install --skip-installed benchmark pretty-format

$(OUT): fib_bench.rkt
	raco exe -o $(OUT) --cs fib_bench.rkt

clean:
	$(RM) -r compiled $(OUT)

