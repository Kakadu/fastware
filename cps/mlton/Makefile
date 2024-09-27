watch:
	inotifywait -mr -e close_write *.sml | while read base event file; do \
  		(clear && (cat Benchmark.sig; cat Benchmark.sml; cat Main.sml) | sml); \
	done

Fib.exe: Main.sml Fib.mlb
	mlton  -output Fib.exe Fib.mlb