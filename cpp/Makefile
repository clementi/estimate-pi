run: bin
	./main

bin: ./main

./main:
	clang++ -O3 -std=c++23 main.cpp -o main

clean: ./main
	rm -f ./main
