.SUFFIXES: .c .ml .dart .hs

OUTC=hello-c.exe
OUTML=hello-ocaml.exe
OUTHS=hello-hs.exe
OUTDART=hello-dart.exe

$(OUTC): hello.c
	gcc $^ -o $@


$(OUTML): hello-ocaml.ml
	ocamlopt $^ -o $@

$(OUTHS): hello.hs
	stack exec ghc --resolver=lts-13.11  -- --make $^ -o $@

$(OUTDART): hello.dart
	dart2native $^ -o $@



test: $(OUTC) $(OUTML) $(OUTHS) $(OUTDART)
	hyperfine --warmup 3 './$(OUTC)' './$(OUTML)' './$(OUTHS)' './$(OUTDART)'

hyperfine:
	wget https://github.com/sharkdp/hyperfine/releases/download/v1.9.0/hyperfine_1.9.0_amd64.deb
	sudo dpkg -i hyperfine_1.9.0_amd64.deb


clean:
	$(RM) -f *.exe *.o *.hi *.cm[ixoa]
