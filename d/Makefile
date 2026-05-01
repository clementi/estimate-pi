run: bin
	./main

bin: ./main

./main:
	ldc2 -O3 main.d

clean: ./main
	rm -f ./main
