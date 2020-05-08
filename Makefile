.PHONY: celan countDigites listVsArray

all:
	dune build

celan: clean
clean:
	dune clean

run:
	dune exec ./main.exe -- -quota 2

countDigits:
	dune exec ./BCountDigits.exe -- -quota 2

listVsArray:
	dune exec ./BListVsArray.exe -- -quota 2

