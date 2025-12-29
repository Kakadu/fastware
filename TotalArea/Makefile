MAIN=bench.exe
CXXFLAGS += -O3

$(MAIN): main.cpp
	$(CXX) $(CXXFLAGS) main.cpp `pkg-config --libs benchmark` -o $@

clean:
	$(RM) $(MAIN)

.PHONY: bench
bench: $(MAIN)
	sudo cpupower frequency-set --governor performance
	./$(MAIN)