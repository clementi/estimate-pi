./main: bin

bin:
	nim --opt:speed -d:release c main.nim

run: ./main
	./main

clean:
	rm -f ./main
