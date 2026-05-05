bin: ./main

./main:
	mlton -codegen llvm main.sml

clean: ./main
	rm -f ./main

run: ./main
	./main
