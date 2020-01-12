.PHONY: celan

all:
	dune build

celan: clean
clean:
	dune clean

run:
	dune exec ./main.exe -- -quota 2

