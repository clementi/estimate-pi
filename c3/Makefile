run: bin

bin: ./estimate_pi

./estimate_pi:
	c3c compile -O1 main.c3

run: ./estimate_pi
	./estimate_pi

clean: ./estimate_pi
	rm -f ./estimate_pi
